SELECT TOP (1)
    end_time,
    reserved_storage_mb AS ReservedStorageMB,
    storage_space_used_mb AS UsedStorageMB,
    reserved_storage_mb - storage_space_used_mb AS FreeStorageMB
FROM sys.server_resource_stats
ORDER BY end_time DESC;