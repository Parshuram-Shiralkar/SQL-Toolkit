--Database file information
	USE [<DATABASE_NAME>];
	GO

	SELECT
		DB_NAME() AS DatabaseName,
		df.name AS LogicalFileName,
		df.type_desc AS FileType,
		df.physical_name AS PhysicalFileName,
		CAST(df.size * 8.0 / 1024 AS DECIMAL(18,2)) AS SizeMB,
		CASE
			WHEN df.max_size = -1 THEN 'UNLIMITED'
			ELSE CAST(CAST(df.max_size * 8.0 / 1024 AS DECIMAL(18,2)) AS VARCHAR(30))
		END AS MaxSizeMB,
		df.growth AS GrowthValue,
		CASE
			WHEN df.is_percent_growth = 1 THEN 'PERCENT'
			ELSE 'MB'
		END AS GrowthType
	FROM sys.database_files AS df
	ORDER BY df.type, df.name;