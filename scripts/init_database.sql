/*
=================================================================

Create Database and Schemas

=================================================================

Script Purpose:
  This script initializes the 'DataWarehouse' database environment.
  It checks whether the database already exists and recreates it if necessary.
  The script also creates the following schemas within the database:
       - bronze
       - silver
       - gold

Warning: 
	Running this script will drop the existing 'DataWarehouse' database if it exists.
  All data within the database will be permanently deleted.
  Proceed with caution and ensure that proper backups are available before executing this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name ='DataWarehouse')
BEGIN
	ALTER DATABASE DaraWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE  DataWarehouse;

END;
GO


-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO


-- Create Schemas
CREATE Schema bronze;
GO

CREATE Schema silver;
GO

CREATE Schema gold;
GO
