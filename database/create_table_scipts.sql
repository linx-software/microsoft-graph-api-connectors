IF OBJECT_ID(N'dbo.tblToken', N'U') IS  NULL
BEGIN
   CREATE TABLE [dbo].[tblToken](
   [ID] INT IDENTITY(1,1) NOT NULL,
   [platform] VARCHAR(500) NULL,
   [platform_id] VARCHAR(500) NULL,
   [state] VARCHAR(500) NULL,
   [code_verifier] VARCHAR(500) NULL,
   [code_challenge] VARCHAR(500) NULL,
   [token_object] VARCHAR(8000) NULL,
   [token_type]  VARCHAR(500) NULL,
   [access_token] VARCHAR(8000) NULL,
   [refresh_token] VARCHAR(8000) NULL,
   [expires_in] INT NULL,
   [expiry_time] DATETIME NULL,
   [last_updated] DATETIME NULL
) ON [PRIMARY]
END