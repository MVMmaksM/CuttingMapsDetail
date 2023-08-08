USE [master]


DECLARE @kill VARCHAR(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(VARCHAR(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('CuttingMapsDetail')

EXEC(@kill);

GO

IF DB_ID('CuttingMapsDetail') IS NOT NULL
	DROP DATABASE CuttingMapsDetail
GO
CREATE DATABASE CuttingMapsDetail
GO
USE CuttingMapsDetail
GO
CREATE TABLE [dbo].[Material]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR (100) NOT NULL,
	[FullName] NVARCHAR (200) NOT NULL,
	[Thick] REAL NOT NULL,

	CONSTRAINT PK__Material PRIMARY KEY CLUSTERED([Id])
)
GO
CREATE TABLE [dbo].[Sheet] 
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR (100) NOT NULL,
	[FullName] NVARCHAR (200) NOT NULL,
	[Width] REAL NOT NULL,
	[Height] REAL NOT NULL,

	CONSTRAINT PK__Sheet PRIMARY KEY CLUSTERED([Id])
)
GO
CREATE TABLE [dbo].[CuttingMap]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR (100) NOT NULL,
	[FullName] NVARCHAR (200) NOT NULL,
	[MaterialId] BIGINT NOT NULL,
	[SheetId] BIGINT NOT NULL,

	CONSTRAINT PK__CuttingMap PRIMARY KEY CLUSTERED([Id]),
	CONSTRAINT FK__CuttingMap_MaterialId FOREIGN KEY([MaterialId]) REFERENCES [dbo].[Material]([Id]),
	CONSTRAINT FK__CuttingMap_SheetId FOREIGN KEY([SheetId]) REFERENCES [dbo].[Sheet]([Id])
)
GO
CREATE TABLE [dbo].[Detail]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR (100) NOT NULL,
	[FullName] NVARCHAR (200) NOT NULL,
	[Countours] VARBINARY(MAX) NOT NULL,

	CONSTRAINT PK__Detail PRIMARY KEY CLUSTERED([Id])
)
GO
CREATE TABLE [dbo].[CuttingMapDetail]
(
	[CuttingMapId] BIGINT NOT NULL,
	[DetailId] BIGINT NOT NULL,

	CONSTRAINT PK__CuttingMapDetail PRIMARY KEY CLUSTERED([CuttingMapId],[DetailId]),
	CONSTRAINT FK__CuttingMapDetail_CuttingMapId FOREIGN KEY([CuttingMapId]) REFERENCES [dbo].[CuttingMap]([Id]),
	CONSTRAINT FK__CuttingMapDetail_DetailId FOREIGN KEY([DetailId]) REFERENCES [dbo].[Detail]([Id])

)
GO
USE master
GO
CREATE LOGIN [User] WITH PASSWORD=N'qwerty123!@#', DEFAULT_DATABASE=[CuttingMapsDetail]
CREATE LOGIN [Admin] WITH PASSWORD=N'Ktnj2023!@#', DEFAULT_DATABASE=[CuttingMapsDetail]
GO
USE CuttingMapsDetail
GO
CREATE USER [User] FOR LOGIN [User]
CREATE USER [Admin] FOR LOGIN [Admin]
GO
GRANT EXECUTE ON SCHEMA::[dbo] TO [User]
GRANT SELECT, INSERT, DELETE, UPDATE ON SCHEMA::[dbo] TO [Admin]


