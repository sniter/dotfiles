#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

nix flake update
sudo nixos-rebuild switch --flake ".#$(hostname)"
