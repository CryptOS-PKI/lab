#!/usr/bin/env bash
# Upload a local ISO to the datastore. Usage: upload-iso.sh [local.iso]
here="$(cd "$(dirname "$0")" && pwd)"; source "$here/lib.sh"
local_iso="${1:-${LAB_ISO_LOCAL:?set LAB_ISO_LOCAL or pass a path}}"
echo "uploading $local_iso -> [$LAB_DATASTORE] $LAB_ISO_PATH"
govc datastore.upload -ds "$LAB_DATASTORE" "$local_iso" "$LAB_ISO_PATH"
