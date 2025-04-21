#!/bin/bash

echo "Enter the version of Trivy you want to install (e.g., 0.29.0, default version is 0.60.0):"
read version

# Define the URL template for the Trivy binary
URL_TEMPLATE="https://github.com/aquasecurity/trivy/releases/download/v${version}/trivy_${version}_Linux-64bit.deb"

# Check if the version exists by attempting to download it
if ! wget -q --spider "${URL_TEMPLATE}"; then
    echo "Version $version does not exist. Installing default version 0.60.0."
    version="0.60.0"
    URL_TEMPLATE="https://github.com/aquasecurity/trivy/releases/download/v${version}/trivy_${version}_Linux-64bit.deb"
fi

# Download the Trivy Debian package
wget "${URL_TEMPLATE}" -O trivy.deb

# Use dpkg tool to install Trivy
sudo dpkg -i trivy.deb

# Clean up the downloaded package
rm -f trivy.deb

# Verify the installation
trivy --version
