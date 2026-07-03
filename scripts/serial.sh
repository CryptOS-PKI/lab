#!/usr/bin/env bash
# Download and print the current serial log.
here="$(cd "$(dirname "$0")" && pwd)"; source "$here/lib.sh"
govc datastore.download "$LAB_SERIAL" "/tmp/${LAB_VM}-serial.log"
strip_ansi < "/tmp/${LAB_VM}-serial.log"
