#!/bin/bash
#
# Installation of a nova compute node.
#
# Ensures that only services needed for a
# nova compute node are enabled. Also sets the
# control node as service host.
#
# Arguments:
# * IP adress of the control node

echo "ENABLED_SERVICES=n-cpu,rabbit,neutron,q-agt
SERVICE_HOST=$1
MYSQL_HOST=\$SERVICE_HOST
RABBIT_HOST=\$SERVICE_HOST
Q_HOST=\$SERVICE_HOST
MATCHMAKER_REDIS_HOST=\$SERVICE_HOST" >> devstack/localrc
