USE DBName;
GO
EXEC sp_addsubscription
     @publication          = N'PUBLICATIONNAME-ALLTABLES-pub',
     @subscriber           = N'SQL MI Name',
     @destination_db       = N'DBName',
     @subscription_type    = N'push',
     @sync_type            = N'initialize with backup',
     @backupdevicetype     = N'disk',
     @backupdevicename     = N'E:\Backups\FolderName\DBName_1.bak',
     @article              = N'all',
     @update_mode          = N'read only',
     @subscriber_type      = 0;
GO
EXEC sp_addpushsubscription_agent
     @publication              = N'PUBLICATIONNAME-ALLTABLES-pub',
     @subscriber               = N'SQL MI Name',
     @subscriber_db            = N'DBName',
     @subscriber_security_mode = 0,
     @subscriber_login         = N'Login Name',
     @subscriber_password      = N'********';
GO