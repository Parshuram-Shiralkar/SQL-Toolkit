--Database free-space check

USE [<DATABASE_NAME>];
GO
SELECT
    DB_NAME() AS DatabaseName,
    name AS LogicalFileName,
    type_desc AS FileType,
    CAST(size * 8.0 / 1024 AS DECIMAL(18,2)) AS AllocatedMB,
    CAST(FILEPROPERTY(name, 'SpaceUsed') * 8.0 / 1024 AS DECIMAL(18,2)) AS UsedMB,
    CAST(
        (size - FILEPROPERTY(name, 'SpaceUsed')) * 8.0 / 1024
        AS DECIMAL(18,2)
    ) AS FreeMB
FROM sys.database_files;	