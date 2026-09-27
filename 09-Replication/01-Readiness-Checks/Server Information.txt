SELECT
    SERVERPROPERTY('ServerName')        AS ServerName,
    SERVERPROPERTY('MachineName')       AS MachineName,
    SERVERPROPERTY('InstanceName')      AS InstanceName,
    SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS HostName,
    SERVERPROPERTY('Edition')           AS Edition,
    SERVERPROPERTY('EngineEdition')     AS EngineEdition,
    SERVERPROPERTY('ProductVersion')    AS ProductVersion,
    SERVERPROPERTY('ProductLevel')      AS ProductLevel,
    SERVERPROPERTY('ProductUpdateLevel') AS ProductUpdateLevel,
    SERVERPROPERTY('ProductUpdateReference') AS ProductUpdateReference,
    SERVERPROPERTY('Collation')         AS ServerCollation,
    SERVERPROPERTY('IsClustered')       AS IsClustered,
    SERVERPROPERTY('IsHadrEnabled')     AS IsHadrEnabled;
GO

--For a more detailed version/build output:

SELECT
    @@SERVERNAME AS ServerName,
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('ProductLevel') AS ProductLevel,
    SERVERPROPERTY('Edition') AS Edition,
    SERVERPROPERTY('EngineEdition') AS EngineEdition;
GO