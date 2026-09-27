--------------------Total Tables COUNT

SELECT COUNT(*) AS TotalUserTables
FROM sys.tables
WHERE is_ms_shipped = 0;