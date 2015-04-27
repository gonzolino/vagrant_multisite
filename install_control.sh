#!/bin/bash
#
# Installation of a nova controller node.
#
# Ensures that the services needed for a
# nova controller node are enabled.

echo "disable_service n-net
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta
enable_service h-eng
enable_service h-api
enable_service h-api-cfn
enable_service h-api-cw
enable_service neutron" >> devstack/localrc
