/*
    Script: Restore-Database-From-URL.sql
    Purpose:
        Restore a SQL Server database from multiple backup files
        stored in Azure Blob Storage.

    Replace all values enclosed in < > before execution.

    Prerequisites:
        - SQL Server must have access to the Azure Blob Storage location.
        - Appropriate SQL Server credential/access must be configured.
        - Logical file names must match the backup.
*/

RESTORE DATABASE [<DATABASE_NAME>]
FROM
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<BACKUP_FILE_1>.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<BACKUP_FILE_2>.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<BACKUP_FILE_3>.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<BACKUP_FILE_4>.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<BACKUP_FILE_5>.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<BACKUP_FILE_6>.bak'
WITH
    MOVE '<LOGICAL_DATA_FILE_1>'
        TO '<DATA_PATH>\<DATA_FILE_1>.mdf',

    MOVE '<LOGICAL_DATA_FILE_2>'
        TO '<DATA_PATH>\<DATA_FILE_2>.ndf',

    MOVE '<LOGICAL_LOG_FILE>'
        TO '<LOG_PATH>\<LOG_FILE>.ldf',

    REPLACE,
    CHECKSUM,
    STATS = 10;
