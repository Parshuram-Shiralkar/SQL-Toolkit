/*
    Script: Backup-Database-To-Azure-Blob.sql

    Purpose:
        Create a compressed COPY_ONLY database backup
        directly to Azure Blob Storage using multiple
        backup files.

    Replace all values enclosed in < > before execution.

    Prerequisites:
        - Azure Blob Storage access must be configured.
        - Required SQL Server credential/access must exist.
        - Storage container must already exist.
*/

BACKUP DATABASE [<DATABASE_NAME>]
TO
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<DATABASE_NAME>_1.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<DATABASE_NAME>_2.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<DATABASE_NAME>_3.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<DATABASE_NAME>_4.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<DATABASE_NAME>_5.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<DATABASE_NAME>_6.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<DATABASE_NAME>_7.bak',
    URL = 'https://<STORAGE_ACCOUNT>.blob.core.windows.net/<CONTAINER>/<DATABASE_NAME>_8.bak'
WITH
    COMPRESSION,
    COPY_ONLY,
    CHECKSUM,
    MAXTRANSFERSIZE = 4194304;