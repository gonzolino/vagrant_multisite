#!/bin/bash
echo "HOST_IP=$1
disable_service horizon
KEYSTONE_SERVICE_HOST=$2
KEYSTONE_AUTH_HOST=$2
REGION_NAME=$3" >> devstack/localrc
