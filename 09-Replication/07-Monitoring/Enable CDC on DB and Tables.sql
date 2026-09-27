USE AdventureWorks
GO

EXEC sys.sp_cdc_enable_db
GO


USE AdventureWorks
GO
EXEC sys.sp_cdc_enable_table
@source_schema = 'dbo',
@source_name = 'sales_hdr',
@role_name = null,
@supports_net_changes = 0;


USE AdventureWorks
GO
EXEC sys.sp_cdc_enable_table
@source_schema = 'dbo',
@source_name = 'shipments_hdr',
@role_name = null,
@supports_net_changes = 0;
