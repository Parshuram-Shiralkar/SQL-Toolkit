"Install-Module -Name Az.Storage -Force -Scope CurrentUser
Import-Module Az.Storage
$context = New-AzStorageContext `
    -StorageAccountName ""stdata*****"" `
    -SasToken ""?sv***""

$container = ""backups""
$sourcePath = ""E:\Backups""
$prefix = ""Arefresh""

$files = Get-ChildItem -Path $sourcePath -Filter ""AdventureWorks_*.bak"" -File

foreach ($file in $files) {

    $blobName = ""$prefix/$($file.Name)""

    Write-Host ""Uploading $($file.Name)..."" -ForegroundColor Cyan

    Set-AzStorageBlobContent `
        -File $file.FullName `
        -Container $container `
        -Blob $blobName `
        -Context $context `
        -Force

    Write-Host ""Uploaded: $blobName"" -ForegroundColor Green
}"
