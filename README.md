# VNS3 Infrastructure templates
[![contact][contact-image]][contact-url]

This project contains code for getting started with different network architectures using VNS3 to enable secure connectivity. The topologies are defined using common IaaC templating systems such as terraform and cloudformation. 

## Common Use-Cases
- VPN Site to Site
- Multi-Cloud
- Encrypted overlay network
- Plug in functionality on your Network Edge with our [Plugin System](https://docs.cohesive.net/docs/network-edge-plugins)

**This is a work in progress as we collect and organize the work we've done the last number of years so we appreciate your understanding.** If you'd like to see an example use case using a certain templating system, let us know! You can [Create an Issue](https://github.com/cohesive/vns3-infra-templates/issues/new) here or [open a support ticket](https://support.cohesive.net/support/tickets/new) for some one on one help getting started.

## Building topologies
Each templating system has different conventions but are all relatively easy to use. After building your infrastructure, you can automate configuration of your network topology using the [VNS3 API](https://docs.cohesive.net/apis/vns3/v/4.8). We also currently support a [Python SDK](https://github.com/cohesive/python-cohesivenet-sdk) (with Bash and Ruby to come!) which has some example code for getting started.

### Terraform
You can deploy terraform templates using the [Terraform command line tool](https://learn.hashicorp.com/terraform/getting-started/install.html). We also wrote a little helper script to output your build plans @ `scripts/tfplan`

```bash
terraform plan              # view the resources to be built
terraform apply -force      # create resources using force to skip confirming step
./tfplan [path to dir]      # create a timestamped build plan, optional path to dir
terraform apply -force build__2019-09-23T19-06-08Z.tfplan
```

### Cloudformation
You can deploy AWS Cloudformation templates via the AWS console or utilizing the AWS SDKs, most easily with the [CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) and the [create-stack](https://docs.aws.amazon.com/cli/latest/reference/cloudformation/create-stack.html) method.

```bash
aws cloudformation create-stack --stack-name myteststack \
  --template-body file://sampletemplate.json \
  --parameters ParameterKey=KeyPairName,ParameterValue=TestKey \
  ParameterKey=SubnetIDs,ParameterValue=SubnetID1\\,SubnetID2
```

### Azure Resource Manager Templates
You can deploy azure resource manager templates via the Azure console or utilizing the Azure SDKs, most easily with the [CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) and the [resource manager deploy method](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-deploy-cli).

```bash
az group create --name ExampleGroup --location "Central US"
az group deployment create \
  --name ExampleDeployment \
  --resource-group ExampleGroup \
  --template-file multi-region-peering-topology.json \
  --parameters storageAccountType=Standard_GRS
```

## Configuring Topologies
Now that your infrastructure is deployed, you can programmatically configure the topology with the [VNS3 API.](https://docs.cohesive.net/apis/vns3/v/). We also currently support a [Python SDK](https://github.com/cohesive/python-cohesivenet-sdk) (with Bash and Ruby to come!) which has some example code for getting started with configuration your topology.

## Automated Topology Verification
To come!


<!-- Markdown links -->

[contact-image]: https://img.shields.io/badge/contact-support-blue.svg?style=flat-square
[contact-url]: https://support.cohesive.net/support/home
