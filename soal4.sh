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

# ====== Soal 4: NAT internet pada Eru agar client bisa akses internet ======
need_root
pkg_install
set_resolv

HOST="$(hostname | tr '[:upper:]' '[:lower:]')"

if [[ "$HOST" != "eru" ]]; then
  warn "Script Soal 4 ditujukan untuk node ERU. Tidak ada aksi untuk host: $HOST"
  exit 0
fi

log "Menyiapkan NAT di ERU (WAN=${ERU_WAN_IF}, LAN1=${ERU_LAN1_IF}, LAN2=${ERU_LAN2_IF})"

# Pastikan interface sudah diatur (Soal 3). Jika belum, tulis minimal WAN DHCP agar internet aktif.
if ! ip addr show "${ERU_WAN_IF}" >/dev/null 2>&1; then
  warn "Interface ${ERU_WAN_IF} tidak ditemukan."
fi

# Aktifkan IP forwarding (jika belum)
backup_once /etc/sysctl.conf
sed -i 's/^\s*#\s*net.ipv4.ip_forward=.*$/net.ipv4.ip_forward=1/' /etc/sysctl.conf || true
if ! grep -q '^net.ipv4.ip_forward=1' /etc/sysctl.conf; then
  echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
fi
sysctl -w net.ipv4.ip_forward=1 >/dev/null

# Atur NAT MASQUERADE
iptables -t nat -F || true
iptables -F || true

iptables -t nat -A POSTROUTING -o "${ERU_WAN_IF}" -j MASQUERADE
iptables -A FORWARD -i "${ERU_WAN_IF}" -o "${ERU_LAN1_IF}" -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i "${ERU_WAN_IF}" -o "${ERU_LAN2_IF}" -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i "${ERU_LAN1_IF}" -o "${ERU_WAN_IF}" -j ACCEPT
iptables -A FORWARD -i "${ERU_LAN2_IF}" -o "${ERU_WAN_IF}" -j ACCEPT

log "NAT aktif. Uji dari client: ping -c3 1.1.1.1; ping -c3 google.com"
