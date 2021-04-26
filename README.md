# azure-network

## components

* VNet
* Subnets
* Linux server Ubuntu 18.04 in backend subnet
* Windows Server 2016 in frontend subnet with public IP

## requirements
* Terraform v14

## usage
* before starting, create a resource group e.g. csa21
```
terraform init
terraform workspace new csa21
terraform plan
terraform apply
```
