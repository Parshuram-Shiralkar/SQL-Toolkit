SELECT DISTINCT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
INNER JOIN sys.schemas s
    ON s.schema_id = t.schema_id
INNER JOIN sys.identity_columns c
    ON c.object_id = t.object_id
WHERE t.is_ms_shipped = 0
ORDER BY
    s.name,
    t.name;