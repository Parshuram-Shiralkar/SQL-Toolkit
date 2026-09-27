SELECT name
FROM sysarticles;

SELECT COUNT(DISTINCT objid) AS ReplicatedTableCount
FROM sysarticles;

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sysarticles a
INNER JOIN sys.tables t
    ON t.object_id = a.objid
INNER JOIN sys.schemas s
    ON s.schema_id = t.schema_id
ORDER BY
    s.name,
    t.name;