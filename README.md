# Azure Machine Learning Lab Exercises

Azure Machine Learning lab exercises from course [Build AI solutions with Azure Machine Learning](https://docs.microsoft.com/en-us/learn/paths/build-ai-solutions-with-azure-ml-service/), see also the [Azure Machine Learning Lab Exercises](https://github.com/MicrosoftLearning/mslearn-dp100) on GitHub.

## Pre-requisites
- A valid Azure subscription (if you do not already have an Azure subscription, sign up for a free trial at https://azure.microsoft.com)
- [Azure CLI 2.20.0+](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

## Setup an Azure Machine Learn Workspace

Sign in to Azure and select the subscription you want to use.
```sh
az login
az account set --subscription [subscriptionId]
```

Create a resource group. In this case I'll use the name "lab-azure-ml" and 

```sh
az group create --name "lab-azure-ml" --location "West Europe"
```

Find the id of the tenant you want to use.
```sh
az account tenant list
```

Create an Azure Machine Learning Workspace by deploying the bicep file `azuredeploy.bicep`

```sh
az deployment group create --name "lab-azure-ml-deploy" --resource-group "lab-azure-ml" --template-file "azuredeploy.bicep" --parameters tenantId=[tenantId]
```