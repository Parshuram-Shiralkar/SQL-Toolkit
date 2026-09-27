SELECT COUNT(DISTINCT t.object_id) AS TablesWithIdentityColumns
FROM sys.tables t
INNER JOIN sys.identity_columns c
    ON c.object_id = t.object_id
WHERE t.is_ms_shipped = 0;