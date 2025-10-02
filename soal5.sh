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

# ====== Soal 5: Membuat konfigurasi persisten ======
need_root
pkg_install

HOST="$(hostname | tr '[:upper:]' '[:lower:]')"

# Persisten untuk IP forwarding (terutama ERU)
backup_once /etc/sysctl.conf
if grep -q '^net.ipv4.ip_forward=' /etc/sysctl.conf; then
  sed -i 's/^net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf
else
  echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
fi
sysctl -w net.ipv4.ip_forward=1 >/dev/null || true

# Persisten untuk iptables via iptables-persistent
if command -v netfilter-persistent >/dev/null 2>&1; then
  netfilter-persistent save || true
  systemctl enable netfilter-persistent || true
else
  warn "netfilter-persistent tidak tersedia."
fi

# Pastikan /etc/network/interfaces sudah terisi dari Soal 3; jika belum, tulis sesuai peran minimal.
case "$HOST" in
  eru)
    if ! grep -q "${ERU_LAN1_IF}" /etc/network/interfaces 2>/dev/null; then
      write_interfaces_router
    fi
    ;;
  melkor) write_interfaces_client "${MELKOR_IP}" "${ERU_ETH1_IP}" ;;
  manwe)  write_interfaces_client "${MANWE_IP}"  "${ERU_ETH1_IP}" ;;
  varda)  write_interfaces_client "${VARDA_IP}"  "${ERU_ETH2_IP}" ;;
  ulmo)   write_interfaces_client "${ULMO_IP}"   "${ERU_ETH2_IP}" ;;
  *)      warn "Hostname tidak dikenali. Abaikan." ;;
esac

restart_networking || true

log "Soal 5 selesai. Reboot untuk verifikasi persistensi (IP, NAT, ip_forward)."
