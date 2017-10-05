#!/bin/bash -v

# This script runs on instances with a node_type tag of "build-node"
# It sets the roles that determine what software is installed
# on this instance by platform-salt scripts and the minion
# id and hostname

# The pnda_env-<cluster_name>.sh script generated by the CLI should
# be run prior to running this script to define various environment
# variables

set -e

cat >> /etc/salt/grains <<EOF
roles:
  - bastion
EOF

cat >> /etc/salt/minion <<EOF
id: $PNDA_CLUSTER-build-node
EOF

echo $PNDA_CLUSTER-build-node > /etc/hostname
hostname $PNDA_CLUSTER-build-node

service salt-master restart
service salt-minion restart
