IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'filesystem01_bamuse_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [filesystem01_bamuse_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://filesystem01@bamuse.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE station_stage (
	station_id nvarchar(4000),
	name nvarchar(4000),
	latitude float,
	longitude float
	)
	WITH (
	LOCATION = 'publicstation.csv',
	DATA_SOURCE = [filesystem01_bamuse_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.station_stage
GO