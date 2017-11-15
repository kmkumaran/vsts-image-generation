# Getting started with Packer on Azure
## Windows
[How to use Packer to create Windows virtual machine images in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/build-image-with-packer)
## Linux
[How to use Packer to create Linux virtual machine images in Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer)

# General Packer
[https://www.packer.io/](https://www.packer.io/)

# Build VS2017 Image
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

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
