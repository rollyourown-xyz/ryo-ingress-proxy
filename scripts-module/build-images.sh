#!/bin/bash

# SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
# SPDX-License-Identifier: GPL-3.0-or-later

# Default software versions
webhook_version='2.8.0'
consul_template_version='0.30.0'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

helpMessage()
{
   echo "build-images.sh: Use packer to build images for deployment"
   echo ""
   echo "Help: build-images.sh"
   echo "Usage: ./build-images.sh -n hostname -w webhook_version -c consul_template_version -v version"
   echo "Flags:"
   echo -e "-n hostname \t\t(Mandatory) Name of the host for which to build images"
   echo -e "-w webhook_version \t(Optional) Override default webhook version to use for the ingress-proxy image, e.g. 2.8.0 (default)"
   echo -e "-c consul_template_version \t(Optional) Override default consul-template version to use for the ingress-proxy image, e.g. 0.27.0 (default)"
   echo -e "-v version \t\t(Mandatory) Version stamp to apply to images, e.g. 20210101-1"
   echo -e "-r remote_build \t\t(Mandatory) Whether to build images on the remote LXD host (true/false)"
   echo -e "-h \t\t\tPrint this help message"
   echo ""
   exit 1
}

errorMessage()
{
   echo "Invalid option or mandatory input variable is missing"
   echo "Use \"./build-images.sh -h\" for help"
   exit 1
}

while getopts n:w:c:v:r:h flag
do
    case "${flag}" in
        n) hostname=${OPTARG};;
        w) webhook_version=${OPTARG};;
        c) consul_template_version=${OPTARG};;
        v) version=${OPTARG};;
        r) remote_build=${OPTARG};;
        h) helpMessage ;;
        ?) errorMessage ;;
    esac
done

if [ -z "$hostname" ] || [ -z "$webhook_version" ] || [ -z "$consul_template_version" ] || [ -z "$version" ] || [ -z "$remote_build" ]
then
   errorMessage
fi


# Get Module ID from configuration file
MODULE_ID="$(yq eval '.module_id' "$SCRIPT_DIR"/../configuration/configuration.yml)"

echo "Building images for "$MODULE_ID" module on "$hostname""
echo ""
echo "Building Ingress Proxy image"
echo "Executing command: packer build -var \"host_id="$hostname"\" -var \"version="$version"\" -var \"remote="$remote_build"\" -var \"webhook_version="$webhook_version"\" -var \"consul_template_version="$consul_template_version"\" "$SCRIPT_DIR"/../image-build/ingress-proxy.pkr.hcl"
echo ""
packer build -var "host_id="$hostname"" -var "version="$version"" -var "remote="$remote_build"" -var "webhook_version="$webhook_version"" -var "consul_template_version="$consul_template_version"" "$SCRIPT_DIR"/../image-build/ingress-proxy.pkr.hcl
echo ""
