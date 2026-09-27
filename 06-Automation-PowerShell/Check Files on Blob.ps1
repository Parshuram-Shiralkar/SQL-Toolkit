#############################Verify from Blob

Install-Module -Name Az.Storage -Force -Scope CurrentUser
Import-Module Az.Storage
# Set variables
$context = New-AzStorageContext -StorageAccountName "stdata*****" -SasToken "?*****"
$container = 'backups'
$prefix = 'Arefresh/ADWK'
# List and delete matching blobs
Get-AzStorageBlob -Container $container -Context $context | Where-Object {
    $_.Name -like "$prefix*.bak"
    } | Select-Object -ExpandProperty Name



###############################Delete from Blob

# Load the module if needed
Install-Module -Name Az.Storage -Force -Scope CurrentUser
Import-Module Az.Storage
# Set variables
$context = New-AzStorageContext -StorageAccountName "stdata***" -SasToken ?*****"
$container = 'backups'
$prefix = 'Arefresh/ADWK'
# List and delete matching blobs
Get-AzStorageBlob -Container $container -Context $context | Where-Object {
    $_.Name -like "$prefix*.bak"
} | ForEach-Object {
    Remove-AzStorageBlob -Blob $_.Name -Container $container -Context $context
    Write-Host "Deleted: $($_.Name)"
}