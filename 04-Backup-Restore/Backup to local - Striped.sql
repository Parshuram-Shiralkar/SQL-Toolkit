/*
    Script: Backup-MultiFile-Compressed.sql
    Purpose:
        Create a compressed COPY_ONLY database backup split
        across multiple disk files.

    Replace:
        <DATABASE_NAME>
        <BACKUP_PATH>
*/

BACKUP DATABASE [DBName]
TO DISK = 'E:\Backups\DBName_1.bak',
   DISK = 'E:\Backups\DBName_2.bak',
   DISK = 'E:\Backups\DBName_3.bak',
   DISK = 'E:\Backups\DBName_4.bak'
WITH
    COMPRESSION,
    COPY_ONLY,
    CHECKSUM,
    MAXTRANSFERSIZE = 4194304,
    STATS = 10;