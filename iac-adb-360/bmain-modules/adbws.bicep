param baseName string
param env string
param location string = resourceGroup().location
param adbmngresourceid string
param locationshortname string
param lawid string

//var managedRGId = '${subscription().id}/resourceGroups/${resourceGroup().name}-mng'

resource adbws 'Microsoft.Databricks/workspaces@2023-02-01' = {
  name: 'adbws-${locationshortname}${baseName}${env}'
  location: location
  sku: { name: 'Standard' }  
  properties: {
    managedResourceGroupId: adbmngresourceid
  }
}

resource adbwsdiags 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${adbws.name}diags'
  scope: adbws
  properties: {
    workspaceId: lawid
    logs: [  
      {
        category: 'Audit'
        enabled: true
      }
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}





