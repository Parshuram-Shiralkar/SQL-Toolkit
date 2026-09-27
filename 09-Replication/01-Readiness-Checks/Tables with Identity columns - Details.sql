SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS IdentityColumn,
    TYPE_NAME(c.user_type_id) AS DataType,
    c.seed_value AS SeedValue,
    c.increment_value AS IncrementValue,
    IDENT_CURRENT(QUOTENAME(s.name) + '.' + QUOTENAME(t.name)) AS CurrentIdentityValue
FROM sys.tables t
INNER JOIN sys.schemas s
    ON s.schema_id = t.schema_id
INNER JOIN sys.identity_columns c
    ON c.object_id = t.object_id
WHERE t.is_ms_shipped = 0
ORDER BY
    s.name,
    t.name,
    c.column_id;