#!/bin/bash
#
# Installation of a FDC host.
#
# Configures the IP and the region for this host.
# FDCs only contain 'secondary' regions which are tied
# to a region on a BDC. Therefore their web interface
# is disabled and they use the keystone service of
# the BDC.
#
# Arguments:
# * IP for this host
# * IP adress the BDC keystone service is running on
# * Region name

echo "HOST_IP=$1
disable_service horizon
KEYSTONE_SERVICE_HOST=$2
KEYSTONE_AUTH_HOST=$2
REGION_NAME=$3" >> devstack/localrc
