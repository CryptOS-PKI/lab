# Shared helpers. Source this after `source .env`.
set -euo pipefail
: "${GOVC_URL:?source your .env first}"
command -v govc >/dev/null || { echo "govc not found (go install github.com/vmware/govmomi/govc@latest)" >&2; exit 1; }
: "${LAB_VM:=cryptos-lab}"
: "${LAB_DATASTORE:=DATASTORE}"
: "${LAB_NETWORK:=Datacenter}"
: "${LAB_ISO_PATH:=ISO/cryptos-amd64-vmware.iso}"
: "${LAB_DISK_GB:=20}"
: "${LAB_SERIAL:=$LAB_VM/serial.log}"
strip_ansi() { sed -E 's/\x1b\[[0-9;=?]*[A-Za-z]//g'; }
