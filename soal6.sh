#!/usr/bin/env bash
set -euo pipefail

# ====== PARAM UMUM (ubah bila perlu) ======
: "${PREFIX:=192.168}"
NET1="${PREFIX}.1"
NET2="${PREFIX}.2"

ERU_ETH1_IP="${NET1}.1"
ERU_ETH2_IP="${NET2}.1"

MELKOR_IP="${NET1}.2"
MANWE_IP="${NET1}.3"
VARDA_IP="${NET2}.2"
ULMO_IP="${NET2}.3"

ERU_WAN_IF="eth0"
ERU_LAN1_IF="eth1"
ERU_LAN2_IF="eth2"

DNS1="1.1.1.1"
DNS2="8.8.8.8"

log()  { echo -e "[\e[96mINFO\e[0m] $*"; }
warn() { echo -e "[\e[93mWARN\e[0m] $*"; }
die()  { echo -e "[\e[91mERR \e[0m] $*" >&2; exit 1; }

need_root() {
  if [[ $(id -u) -ne 0 ]]; then
    die "Jalankan sebagai root."
  fi
}

pkg_install() {
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y
  apt-get install -y --no-install-recommends iproute2 net-tools iptables tcpdump iptables-persistent ca-certificates curl wget nano tshark || true
}

backup_once() {
  local f="$1"
  if [[ -f "$f" && ! -f "${f}.bak" ]]; then
    cp -a "$f" "${f}.bak"
  fi
}

set_resolv() {
  echo -e "nameserver ${DNS1}\nnameserver ${DNS2}" > /etc/resolv.conf || true
}

restart_networking() {
  if command -v systemctl >/dev/null && systemctl list-unit-files 2>/dev/null | grep -q '^networking\.service'; then
    systemctl restart networking || true
  else
    ifdown --exclude=lo -a || true
    ifup --exclude=lo -a || true
  fi
}

write_interfaces_router() {
  backup_once /etc/network/interfaces
  cat >/etc/network/interfaces <<EOF
# /etc/network/interfaces — Eru (Router)
auto lo
iface lo inet loopback

auto ${ERU_WAN_IF}
iface ${ERU_WAN_IF} inet dhcp

auto ${ERU_LAN1_IF}
iface ${ERU_LAN1_IF} inet static
  address ${ERU_ETH1_IP}
  netmask 255.255.255.0

auto ${ERU_LAN2_IF}
iface ${ERU_LAN2_IF} inet static
  address ${ERU_ETH2_IP}
  netmask 255.255.255.0
EOF
}

write_interfaces_client() {
  local ip="$1" gw="$2"
  backup_once /etc/network/interfaces
  cat >/etc/network/interfaces <<EOF
# /etc/network/interfaces — Client
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address ${ip}
  netmask 255.255.255.0
  gateway ${gw}
EOF
}

# ====== Soal 6: Traffic test & capture pcap (Manwe <-> jaringan, capture di Eru) ======
need_root
pkg_install

: "${TRAFFIC_URL:=}"   # set misal: TRAFFIC_URL="https://link/traffic.sh"
WORKDIR="/root/praktikum-soal-3-6"
CAPDIR="${WORKDIR}/captures"
mkdir -p "${WORKDIR}" "${CAPDIR}"

HOST="$(hostname | tr '[:upper:]' '[:lower:]')"

download_traffic() {
  if [[ -n "${TRAFFIC_URL}" ]]; then
    log "Mengunduh traffic.sh dari ${TRAFFIC_URL}"
    if command -v curl >/dev/null; then
      curl -fsSL "${TRAFFIC_URL}" -o "${WORKDIR}/traffic.sh" || true
    else
      wget -O "${WORKDIR}/traffic.sh" "${TRAFFIC_URL}" || true
    fi
    if [[ -f "${WORKDIR}/traffic.sh" ]]; then
      chmod +x "${WORKDIR}/traffic.sh"
    else
      warn "traffic.sh gagal diunduh."
    fi
  else
    warn "TRAFFIC_URL tidak diset. Lewati unduh traffic.sh"
  fi
}

case "$HOST" in
  eru)
    # Capture pada ERU-LAN1 agar terlihat lalu lintas Manwe
    PCAP_FILE="${CAPDIR}/soal6_eru_$(date +%Y%m%d_%H%M%S).pcap"
    log "Memulai capture 60 detik di ${ERU_LAN1_IF} untuk host ${MANWE_IP} -> ${PCAP_FILE}"
    timeout 60 tcpdump -i "${ERU_LAN1_IF}" -w "${PCAP_FILE}" host "${MANWE_IP}" || true
    log "Selesai. Contoh analisis:"
    echo "tshark -r ${PCAP_FILE} -Y \"ip.src==${MANWE_IP} || ip.dst==${MANWE_IP}\""
    ;;
  manwe)
    download_traffic
    if [[ -f "${WORKDIR}/traffic.sh" ]]; then
      log "Menjalankan traffic.sh selama 60 detik di Manwe..."
      timeout 60 bash "${WORKDIR}/traffic.sh" || true
    else
      warn "traffic.sh tidak ada; buat traffic manual (ping/curl) selama capture berjalan di ERU."
    fi
    ;;
  *)
    warn "Soal 6: aksi utama hanya di ERU (capture) dan MANWE (generate traffic). Host sekarang: $HOST"
    ;;
esac

log "Soal 6 selesai."
