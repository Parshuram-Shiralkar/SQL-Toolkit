USE [YourDatabase];
GO

SELECT
    type_desc AS FileType,
    CAST(SUM(size) * 8.0 / 1024 AS DECIMAL(18,2)) AS SizeMB,
    CAST(SUM(size) * 8.0 / 1024 / 1024 AS DECIMAL(18,2)) AS SizeGB
FROM sys.database_files
GROUP BY type_desc;