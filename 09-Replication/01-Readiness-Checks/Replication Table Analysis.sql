/*
    Script: Replication-Table-Analysis.sql

    Purpose:
        Identify table-level considerations before adding
        tables as transactional replication articles.

    Checks:
        - Row count
        - Primary key
        - Identity columns
        - Triggers
        - Foreign keys
        - Computed columns
        - LOB columns
        - Rowversion/timestamp columns
        - Table size
*/

-- ============================================================
-- 1. Table row counts
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    SUM(p.rows) AS RowCounts
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
INNER JOIN sys.partitions AS p
    ON t.object_id = p.object_id
WHERE p.index_id IN (0, 1)
GROUP BY
    s.name,
    t.name
ORDER BY
    RowCounts DESC;


-- ============================================================
-- 2. Primary key information
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    kc.name AS PrimaryKeyName,
    c.name AS ColumnName,
    ic.key_ordinal AS KeyOrdinal
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
LEFT JOIN sys.indexes AS i
    ON t.object_id = i.object_id
    AND i.is_primary_key = 1
LEFT JOIN sys.key_constraints AS kc
    ON i.object_id = kc.parent_object_id
    AND i.index_id = kc.unique_index_id
LEFT JOIN sys.index_columns AS ic
    ON i.object_id = ic.object_id
    AND i.index_id = ic.index_id
LEFT JOIN sys.columns AS c
    ON ic.object_id = c.object_id
    AND ic.column_id = c.column_id
ORDER BY
    s.name,
    t.name,
    ic.key_ordinal;


-- ============================================================
-- 3. Tables without a primary key
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
LEFT JOIN sys.indexes AS i
    ON t.object_id = i.object_id
    AND i.is_primary_key = 1
WHERE i.object_id IS NULL
ORDER BY
    s.name,
    t.name;


-- ============================================================
-- 4. Identity columns
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    TYPE_NAME(c.user_type_id) AS DataType,
    c.is_nullable,
    c.is_identity
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
INNER JOIN sys.columns AS c
    ON t.object_id = c.object_id
WHERE c.is_identity = 1
ORDER BY
    s.name,
    t.name,
    c.column_id;


-- ============================================================
-- 5. Triggers
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    tr.name AS TriggerName,
    tr.is_disabled AS IsDisabled,
    tr.is_instead_of_trigger AS IsInsteadOfTrigger
FROM sys.triggers AS tr
INNER JOIN sys.tables AS t
    ON tr.parent_id = t.object_id
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
WHERE tr.parent_class = 1
ORDER BY
    s.name,
    t.name;


-- ============================================================
-- 6. Computed columns
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    c.definition AS ComputedDefinition
FROM sys.computed_columns AS c
INNER JOIN sys.tables AS t
    ON c.object_id = t.object_id
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
ORDER BY
    s.name,
    t.name;


-- ============================================================
-- 7. LOB columns
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    TYPE_NAME(c.user_type_id) AS DataType,
    c.max_length
FROM sys.columns AS c
INNER JOIN sys.tables AS t
    ON c.object_id = t.object_id
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
WHERE TYPE_NAME(c.user_type_id) IN
(
    'text',
    'ntext',
    'image',
    'varchar',
    'nvarchar',
    'varbinary'
)
AND c.max_length = -1
ORDER BY
    s.name,
    t.name;


-- ============================================================
-- 8. rowversion / timestamp columns
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    TYPE_NAME(c.user_type_id) AS DataType
FROM sys.columns AS c
INNER JOIN sys.tables AS t
    ON c.object_id = t.object_id
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
WHERE c.system_type_id = 189
ORDER BY
    s.name,
    t.name;


-- ============================================================
-- 9. Foreign keys
-- ============================================================

SELECT
    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS SchemaName,
    OBJECT_NAME(fk.parent_object_id) AS TableName,
    fk.name AS ForeignKeyName,
    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS ReferencedSchema,
    OBJECT_NAME(fk.referenced_object_id) AS ReferencedTable,
    fk.is_disabled AS IsDisabled,
    fk.is_not_trusted AS IsNotTrusted
FROM sys.foreign_keys AS fk
ORDER BY
    SchemaName,
    TableName;


-- ============================================================
-- 10. Table sizes
-- ============================================================

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    SUM(p.rows) AS RowCounts,
    CAST(SUM(a.total_pages) * 8.0 / 1024 AS DECIMAL(18,2)) AS TotalSizeMB,
    CAST(SUM(a.used_pages) * 8.0 / 1024 AS DECIMAL(18,2)) AS UsedSizeMB,
    CAST(SUM(a.data_pages) * 8.0 / 1024 AS DECIMAL(18,2)) AS DataSizeMB
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
INNER JOIN sys.indexes AS i
    ON t.object_id = i.object_id
INNER JOIN sys.partitions AS p
    ON i.object_id = p.object_id
    AND i.index_id = p.index_id
INNER JOIN sys.allocation_units AS a
    ON p.partition_id = a.container_id
GROUP BY
    s.name,
    t.name
ORDER BY
    TotalSizeMB DESC;