# Encrypted Overlay Network across AWS Regions
This topology provides an encrypted overlay network across regions in AWS. The overlay network provides network isolation, client based policy enforcement and full attestability for your network traffic. Common use cases for this are ensuring network isolation for servers in a application pool behind a load balancer or for a container cluster.

## API Configuration Steps
After infrastructure is provisioned, network connectivity and policies can be configured via the API:

### Configuring the VNS3 Controllers
1. License your root controller
2. Generate keyset on root controller
3. For each controller peer in the overlay, fetch licensing and keyset from the root controller
4. For a complete mesh, peer each controller together (the python SDK provides a macro [function for this.](https://github.com/cohesive/python-cohesivenet-sdk/blob/master/examples/peering_mesh.py))

### Configuring network overlay clients
1. 
2. 
3. 

[View our API Specification Here](https://docs.cohesive.net/apis/vns3/v/4.8).

## Architecture
Note: IPsec site-to-site VPN to a datacenter shown for demonstration purposes, it is not reflected in the terraform.

![Peering mesh diagram](./vns3-peering-mesh-aws.png "Peering mesh diagram")