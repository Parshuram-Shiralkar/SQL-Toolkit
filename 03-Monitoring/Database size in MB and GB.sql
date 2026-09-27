USE [YourDatabase];
GO

SELECT
    DB_NAME() AS DatabaseName,
    CAST(SUM(size) * 8.0 / 1024 AS DECIMAL(18,2)) AS TotalSizeMB,
    CAST(SUM(size) * 8.0 / 1024 / 1024 AS DECIMAL(18,2)) AS TotalSizeGB
FROM sys.database_files;