--Drop Subscription

USE AdventureWorks2022CDC;
GO

EXEC sp_dropsubscription
    @publication = N'AdventureWorks2022CDC_Pub',
    @article = N'all',  -- or specify article name if not dropping all
    @subscriber = N'sqlmi-dataint-stg-scus-01.e23821e168b9.database.windows.net',
    @destination_db = N'AdventureWorks2022CDC';
GO

USE ;
GO

EXEC sp_dropsubscription
    @publication = N'-ALLTABLES-pub',
    @article = N'all',  -- or specify article name if not dropping all
    @subscriber = N'sqlmi-dataint-stg-scus-01.e23821e168b9.database.windows.net',
    @destination_db = N'';
GO
--Drop Publication
USE AdventureWorks2022CDC;
GO
EXEC sp_droppublication
    @publication = N'AdventureWorks2022CDC_Pub';       -- Same name as above

--Verify on publisher
SELECT name, is_published, is_subscribed, is_distributor
FROM sys.databases
WHERE name = 'AdventureWorks2022CDC';

--xx not in sequence, run on publisher
USE [AdventureWorks2022CDC];
GO
EXEC sp_removedbreplication @dbname = N'AdventureWorks2022CDC';

--Verify on publisher
SELECT name, is_published, is_subscribed, is_distributor
FROM sys.databases
WHERE name = 'ADWK';



USE ADWK;
GO
EXEC sp_droppublication
    @publication = N'ADWK';       -- Same name as above

	USE ADWK;
GO
EXEC sp_removedbreplication @dbname = N'ADWK';

--@schema option values 0x00000000080310DF if non clustered indexes exclude, 0x00000000080350DF already being used, 0x000000000803509F plattesqltest	

Even if not dropped then

--Run on Publisher
USE [AdventureWorks2022CDC];
GO
-- Check if any subscription still exists
EXEC sp_helppublication;
EXEC sp_helpsubscription @publication = N'AdventureWorks2022CDC_Pub';

--Run this on the subscriber
SELECT name, is_published, is_subscribed, is_distributor
FROM sys.databases
WHERE name = 'AdventureWorks2022CDC';

--On the subscriber, run:
-- Removes all replication metadata for the database
EXEC sp_removedbreplication @dbname = N'AdventureWorks2022CDC';

--On the Publisher, run
USE [AdventureWorks2022CDC];
GO
EXEC sp_removedbreplication @dbname = N'AdventureWorks2022CDC';