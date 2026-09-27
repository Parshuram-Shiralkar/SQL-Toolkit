/*
    Script: Database-Replication-Readiness.sql

    Purpose:
        Check database-level prerequisites before
        transactional replication setup or database backup.

    Replace <DATABASE_NAME> with the database being evaluated.
*/

SELECT
    d.name AS DatabaseName,
    d.state_desc AS DatabaseState,
    d.user_access_desc AS UserAccess,
    d.recovery_model_desc AS RecoveryModel,
    d.compatibility_level AS CompatibilityLevel,
    d.is_read_only AS IsReadOnly,
    d.is_auto_close_on AS AutoClose,
    d.is_auto_shrink_on AS AutoShrink,
    d.is_encrypted AS IsEncrypted
FROM sys.databases AS d
WHERE d.name = '<DATABASE_NAME>';