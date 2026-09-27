SELECT
    DB_NAME(database_id) AS DatabaseName,
    CAST(SUM(size) * 8.0 / 1024 AS DECIMAL(18,2)) AS AllocatedSizeMB,
    CAST(SUM(size) * 8.0 / 1024 / 1024 AS DECIMAL(18,2)) AS AllocatedSizeGB
FROM sys.master_files
GROUP BY database_id
ORDER BY AllocatedSizeGB DESC;
GO

USE [<DATABASE_NAME>];
GO

SELECT
    DB_NAME() AS DatabaseName,
    CAST(SUM(size) * 8.0 / 1024 AS DECIMAL(18,2)) AS AllocatedSizeMB,
    CAST(SUM(size) * 8.0 / 1024 / 1024 AS DECIMAL(18,2)) AS AllocatedSizeGB
FROM sys.database_files;
