@description('The name of the SQL server.')
param sqlServerName string

@description('The location for the SQL server.')
param location string = resourceGroup().location

@description('The administrator username for the SQL server.')
param adminUsername string

@description('The administrator password for the SQL server.')
@secure()
param adminPassword string

@description('The version of the SQL server.')
param sqlVersion string = '12.0'

resource sqlServer 'Microsoft.Sql/servers@2021-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: 'Password@123'
    minimalTlsVersion: '1.0' // Intentionally set to an outdated version
  }
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  name: 'AllowAllAzureIPs'
  parent: sqlServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}
