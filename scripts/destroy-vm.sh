#!/usr/bin/env bash
# Power off and delete the lab VM (leaves the uploaded ISO in place).
here="$(cd "$(dirname "$0")" && pwd)"; source "$here/lib.sh"
govc vm.power -off -force "$LAB_VM" >/dev/null 2>&1 || true
govc vm.destroy "$LAB_VM"
echo "destroyed $LAB_VM"
