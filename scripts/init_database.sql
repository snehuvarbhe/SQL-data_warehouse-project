/*
-----------------------------------------------------------------------------------
-- Script: Reset and Recreate DataWarehouse Database with Bronze, Silver, and Gold Schemas
-- Author: Snehal Varbhe
--
-- Description:
-- This script performs the following actions:
-- 1. Switches to the master database to ensure safe execution.
-- 2. Checks if the 'DataWarehouse' database exists:
--    - If it exists, it is dropped after setting it to SINGLE_USER mode 
--      (to prevent active connections from interfering with the drop operation).
--    - If it does not exist, it proceeds to creation.
-- 3. Creates a fresh 'DataWarehouse' database.
-- 4. Switches to the newly created 'DataWarehouse' database.
-- 5. Checks for the existence of schemas 'bronze', 'silver', and 'gold':
--    - If they do not exist, they are created.
--    - If they already exist (which is unlikely since the database was just recreated), 
--      they are left unchanged.
--
-- Warnings:
-- - **This script will delete all data** in the 'DataWarehouse' database if it already exists.
-- - **Ensure you have backups** before running this script in a production environment.
-- - The script sets the database to SINGLE_USER mode before dropping it, 
--   which will forcibly disconnect any active users.
-- - The script does not create tables; it only sets up the database and schema structure.
-- - If you are running this in a shared environment, ensure you have proper permissions 
--   and inform relevant users before execution.
-----------------------------------------------------------------------------------
*/

USE master;
GO

-- Drop database if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
    PRINT 'Existing database DataWarehouse dropped successfully.';
END

-- Create new database
CREATE DATABASE DataWarehouse;
PRINT 'Database DataWarehouse created successfully.';
GO

-- Use the new database
USE DataWarehouse;
GO

-- Create schema bronze
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC('CREATE SCHEMA bronze');
    PRINT 'Schema bronze created successfully.';
END
GO

-- Create schema silver
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC('CREATE SCHEMA silver');
    PRINT 'Schema silver created successfully.';
END
GO

-- Create schema gold
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC('CREATE SCHEMA gold');
    PRINT 'Schema gold created successfully.';
END
GO
