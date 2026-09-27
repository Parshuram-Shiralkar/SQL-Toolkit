SELECT COUNT(DISTINCT a.objid) AS ReplicatedTableCount
FROM sysarticles AS a
INNER JOIN sys.tables AS t
    ON t.object_id = a.objid
WHERE t.is_ms_shipped = 0;