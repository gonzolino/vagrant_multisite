#!/bin/bash
#
# Installation of a BDC host.
#
# Configures the IP and the region for this host.
#
# Arguments:
# * IP for this host
# * Region name

echo "HOST_IP=$1
REGION_NAME=$2" >> devstack/localrc
