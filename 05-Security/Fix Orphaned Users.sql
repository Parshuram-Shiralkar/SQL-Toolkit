USE DBName;
GO

SET NOCOUNT ON;

DECLARE @UserName SYSNAME;
DECLARE @SQL NVARCHAR(MAX);

DECLARE OrphanedUsers CURSOR LOCAL FAST_FORWARD FOR
SELECT dp.name
FROM sys.database_principals AS dp
LEFT JOIN master.sys.server_principals AS sp
    ON dp.sid = sp.sid
WHERE dp.type IN ('S', 'U', 'G')
  AND dp.authentication_type_desc <> 'DATABASE'
  AND sp.sid IS NULL
  AND dp.name NOT IN
      (
          'dbo',
          'guest',
          'INFORMATION_SCHEMA',
          'sys'
      );

OPEN OrphanedUsers;

FETCH NEXT FROM OrphanedUsers INTO @UserName;

WHILE @@FETCH_STATUS = 0
BEGIN
    /*
       Only attempt the fix if a login with the SAME NAME
       exists on the SQL Server / MI.
    */
    IF EXISTS
    (
        SELECT 1
        FROM master.sys.server_principals
        WHERE name = @UserName
    )
    BEGIN
        SET @SQL =
            N'ALTER USER ' + QUOTENAME(@UserName) +
            N' WITH LOGIN = ' + QUOTENAME(@UserName) + N';';

        PRINT 'Fixing orphaned user: ' + @UserName;
        PRINT @SQL;

        EXEC sys.sp_executesql @SQL;
    END
    ELSE
    BEGIN
        PRINT 'Skipped - matching server login does not exist: '
            + @UserName;
    END;

    FETCH NEXT FROM OrphanedUsers INTO @UserName;
END;

CLOSE OrphanedUsers;
DEALLOCATE OrphanedUsers;
GO