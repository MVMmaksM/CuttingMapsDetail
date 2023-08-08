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
-- создание таблицы для хранения материалов
CREATE TABLE [dbo].[Material]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR (100) NOT NULL,
	[FullName] NVARCHAR (200) NOT NULL,
	[Thick] REAL NOT NULL,

	CONSTRAINT PK__Material PRIMARY KEY CLUSTERED([Id])
)
GO
-- создание таблицы для хранения листов
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
-- создание таблицы для хранения карт раскроя
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
-- создание таблицы для хранения деталей
CREATE TABLE [dbo].[Detail]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL,
	[Title] NVARCHAR (100) NOT NULL,
	[FullName] NVARCHAR (200) NOT NULL,
	[Countours] VARBINARY(MAX) NOT NULL,

	CONSTRAINT PK__Detail PRIMARY KEY CLUSTERED([Id])
)
GO
-- создание таблицы для хранения карт раскроя детали 
CREATE TABLE [dbo].[CuttingMapDetail]
(
	[CuttingMapId] BIGINT NOT NULL,
	[DetailId] BIGINT NOT NULL,

	CONSTRAINT PK__CuttingMapDetail PRIMARY KEY CLUSTERED([CuttingMapId],[DetailId]),
	CONSTRAINT FK__CuttingMapDetail_CuttingMapId FOREIGN KEY([CuttingMapId]) REFERENCES [dbo].[CuttingMap]([Id]),
	CONSTRAINT FK__CuttingMapDetail_DetailId FOREIGN KEY([DetailId]) REFERENCES [dbo].[Detail]([Id])

)
GO
-- создание схемы для представлений пользователй
CREATE SCHEMA user_views
GO
CREATE VIEW [user_views].[all_material_vw]
AS
SELECT *
FROM [dbo].[Material]
GO
CREATE VIEW [user_views].[all_sheet_vw]
AS
SELECT *
FROM [dbo].[Sheet]
GO
CREATE VIEW [user_views].[all_detail_vw]
AS
SELECT *
FROM [dbo].[Detail]
GO
CREATE VIEW [user_views].[all_CuttingMap_vw]
AS
SELECT *
FROM [dbo].[CuttingMap]
GO
CREATE VIEW [user_views].[all_CuttingMapDetail_vw]
AS
SELECT *
FROM [dbo].[CuttingMapDetail]
GO
CREATE PROCEDURE sp_
USE master
GO
-- создание пользователей для сервера
CREATE LOGIN [User] WITH PASSWORD=N'qwerty123!@#', DEFAULT_DATABASE=[CuttingMapsDetail]
CREATE LOGIN [Admin] WITH PASSWORD=N'Ktnj2023!@#', DEFAULT_DATABASE=[CuttingMapsDetail]
GO
USE CuttingMapsDetail
GO
-- создание пользователй для базы
CREATE USER [User] FOR LOGIN [User]
CREATE USER [Admin] FOR LOGIN [Admin]
GO
-- предоставление разрешений пользователям
GRANT SELECT ON SCHEMA::[user_views] TO [User]
GRANT EXECUTE ON SCHEMA::[dbo] TO [User]
GRANT EXECUTE, SELECT, INSERT, DELETE, UPDATE ON SCHEMA::[dbo] TO [Admin]