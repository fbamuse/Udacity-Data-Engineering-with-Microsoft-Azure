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

CREATE EXTERNAL TABLE payment_stage (
	payment_id bigint,
	date NVARCHAR(4000),
	amount float,
	account_number bigint
	)
	WITH (
	LOCATION = 'publicpayment.csv',
	DATA_SOURCE = [filesystem01_bamuse_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.payment_stage
GO