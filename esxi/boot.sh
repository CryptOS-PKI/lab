#!/usr/bin/env bash
# Power the VM on (from the CD) and, after a wait, print the serial log and save a
# console screenshot. Usage: boot.sh [wait-seconds]
here="$(cd "$(dirname "$0")" && pwd)"; source "$here/lib.sh"
wait="${1:-80}"
# fresh serial capture
govc datastore.rm -ds "$LAB_DATASTORE" "$LAB_SERIAL" >/dev/null 2>&1 || true
govc vm.power -on "$LAB_VM"
echo "powered on; waiting ${wait}s for boot..."; sleep "$wait"
govc vm.console -capture "/tmp/${LAB_VM}.png" "$LAB_VM" && echo "screenshot: /tmp/${LAB_VM}.png"
govc datastore.download "$LAB_SERIAL" "/tmp/${LAB_VM}-serial.log" >/dev/null 2>&1 \
  && { echo "=== serial (tail) ==="; strip_ansi < "/tmp/${LAB_VM}-serial.log" | tail -30; } \
  || echo "(no serial yet — a quiet 'prod' image writes nothing; use a console/qemu-dev ISO to see boot output)"
