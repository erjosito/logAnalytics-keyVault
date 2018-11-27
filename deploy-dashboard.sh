dashboardName="KV Logs"
logAnalyticsWorkspaceName="keyvaultlogs1138"
logAnalyticsWorkspaceResourceGroup="keyvaultlogs"
az group deployment create -g $logAnalyticsWorkspaceResourceGroup --template-file ./AKVdashboard.json --parameters \
"{\"dashboardName\":{\"value\":\"$dashboardName\"}, \
  \"logAnalyticsWorkspaceName\":{\"value\":\"$logAnalyticsWorkspaceName\"}, \
  \"logAnalyticsWorkspaceResourceGroup\":{\"value\":\"$logAnalyticsWorkspaceResourceGroup\"}}"