#!/bin/bash

IpConfigName=Primary
NICName=$1  # ${var.topology_name}-vns3-ni-${count.index}
PublicIpAddressId=$2  # ${var.topology_name}-VNS3-PublicIP-${count.index}
ResourceGroupName=$3

az network nic ip-config update \
    --name $IpConfigName \
    --nic-name $NICName \
    --public-ip-address $PublicIpAddressId \
    --resource-group $ResourceGroupName
