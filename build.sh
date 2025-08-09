#!/bin/bash

cd live-build

sudo lb clean
lb config \
  --mode debian \
  --distribution trixie \
  --debian-installer none \
  --binary-images iso-hybrid \
  --bootappend-live "boot=live components quiet splash noeject toram persistence.read-only" \
  --linux-flavours amd64
sudo lb build

