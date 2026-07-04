#!/usr/bin/env bash
# Create a UEFI (Secure Boot off) lab VM booting the uploaded ISO, with an NVMe
# disk, an e1000e NIC, and a serial port wired to a datastore file. Idempotent-ish:
# destroy first if it exists.
here="$(cd "$(dirname "$0")" && pwd)"; source "$here/lib.sh"
# govc vm.info exits 0 even when no VM matches (it just prints nothing), so test
# for actual output, not the exit code.
if govc vm.info "$LAB_VM" 2>/dev/null | grep -q "Name:"; then
  echo "$LAB_VM already exists; run destroy-vm.sh first" >&2; exit 1
fi
govc vm.create -on=false -g other6xLinux64Guest -firmware=efi -c 2 -m 2048 \
  -disk "${LAB_DISK_GB}GB" -disk.controller nvme -ds "$LAB_DATASTORE" \
  -net "$LAB_NETWORK" -net.adapter e1000e \
  -iso "$LAB_ISO_PATH" -iso-datastore "$LAB_DATASTORE" \
  "$LAB_VM"
govc device.boot -vm "$LAB_VM" -order cdrom,disk -secure=false
govc device.serial.add -vm "$LAB_VM" >/dev/null
govc device.serial.connect -vm "$LAB_VM" "[$LAB_DATASTORE] $LAB_SERIAL"
echo "created $LAB_VM (EFI, Secure Boot off, NVMe ${LAB_DISK_GB}GB, e1000e, serial -> [$LAB_DATASTORE] $LAB_SERIAL)"
