#!/bin/bash

IMAGE_URL=$1

if [ -z "$IMAGE_URL" ]; then
    echo "Usage: $0 <image-url>"
    exit 1
fi

temp=$(mktemp -d)

# Download Fedora Remix MSIX from Github
wget -O $temp/image.zip $IMAGE_URL

# Extract MSIX
unzip -o $temp/image.zip -d $temp

# Extract x64 embedded MSIX
unzip -o $temp/*x64.msix -d $temp

# GUnzip rootfs
gunzip $temp/install.tar.gz

# Import rootfs
sudo docker import $temp/install.tar fedora-remix-wsl

rm -rf $temp