# lab

Reusable tooling for booting CryptOS on VMware ESXi via `govc`: build and upload an
ISO, create a UEFI VM (Secure Boot off, optional vTPM), boot it, and capture the
serial console and screenshots for validation and debugging.

## Prerequisites

- `govc` (VMware CLI): `go install github.com/vmware/govmomi/govc@latest`
- Reachable ESXi/vCenter and a built CryptOS ISO.

## Setup

Copy `.env.example` to `.env`, fill in your host and lab settings, then `source .env`.
`.env` is gitignored and must never be committed — this repo is public.

## Scripts

Added as the flow is validated (see `scripts/`): upload an ISO to a datastore,
create the lab VM, power/boot it, and pull its serial log + a console screenshot.
