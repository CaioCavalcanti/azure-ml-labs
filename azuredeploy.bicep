param tenantId string

var resourceGroupName = resourceGroup().name
var location = resourceGroup().location

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'kv-${resourceGroupName}'
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenantId
    accessPolicies: []
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'st${uniqueString(resourceGroup().id)}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: 'appi-${resourceGroupName}'
  location: location
  kind: 'other'
  properties: {
    Application_Type: 'other'
  }
}

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2020-11-01-preview' = {
  name: 'cr${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Basic'
  }
}

resource machineLearningWorkspace 'Microsoft.MachineLearningServices/workspaces@2020-09-01-preview' = {
  name: 'mlw-${resourceGroupName}'
  location: location
  sku: {
    name: 'Basic'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    applicationInsights: appInsights.id
    storageAccount: storageAccount.id
    keyVault: keyVault.id
  }
}

resource computeInstance 'Microsoft.MachineLearningServices/workspaces/computes@2020-09-01-preview' = {
  name: 'mlw-${resourceGroupName}/vm-${resourceGroupName}'
  location: location
  properties: {
    computeType: 'VirtualMachine'
    properties: {
      virtualMachineSize: 'Standard_DS11_v2'
    }
  }
  dependsOn: [
    machineLearningWorkspace
  ]
}