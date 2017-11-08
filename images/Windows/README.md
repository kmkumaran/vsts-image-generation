# Getting started with Packer on Azure
## Windows
[How to use Packer to create Windows virtual machine images in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/build-image-with-packer)
## Linux
[How to use Packer to create Linux virtual machine images in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer)

# General Packer
[https://www.packer.io/](https://www.packer.io/)

# Build Vs2017 Image
Packer should be in your path and you will need to gather your service principal and resource group information based on the Azure document above
```
cd images\Windows\Vs2017

packer.exe build^
    -var "client_id=<spn.applicationId>"^
    -var "client_secret=<spn_password>"^
    -var "subscription_id=<spn.subscriptionId>"^
    -var "tenant_id=<spn.tenantId>"^
    -var "object_id=<spn.Id>"^
    -var "location=<rg_location>"^
    -var "resource_group=<capture_rg>"^
    -var "storage_account=<capture_storage_account>"^
    vs2017-Server2016-Azure.json
```
You can shortcut the command line by creating a JSON file that has all of your variable values in it.
```
{
    "client_id": "<spn.applicationId>",
    "client_secret": "<spn_password>",
    "subscription_id": "<spn.subscriptionId>",
    "tenant_id": "<spn.tenantId>",
    "object_id": "<spn.Id>",
    "resource_group": "<capture_rg>",
    "storage_account": "<capture_storage_account>"
    "location": "<rg location>"
}

packer build -var-file=<path to variables file> -var "commit_id=$(git log --pretty=format:'%H' -n 1)" vs2017-Server2016-Azure.json
```