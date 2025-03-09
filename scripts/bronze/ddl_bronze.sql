/*
-----------------------------------------------------------------------------------
-- Script: Drop and Recreate Bronze Layer Tables in DataWarehouse
-- Author: [Your Name]
-- Date: [Current Date]
--
-- Description:
-- This script ensures that the 'bronze' schema contains fresh tables by:
-- 1. Checking if each table exists and dropping it if found.
-- 2. Recreating the tables from scratch.
--
-- Warnings:
-- - **This script will delete all existing data** in the 'bronze' schema tables.
-- - Ensure that a backup is taken before execution in a production environment.
-- - If running in a shared database, coordinate with the team before executing.
-----------------------------------------------------------------------------------
*/

USE DataWarehouse;
GO

-- Drop and Recreate CRM Customer Info Table
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id             INT,
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    cst_lastname       NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr           NVARCHAR(50),
    cst_create_date    DATE
);
PRINT 'Table bronze.crm_cust_info created successfully.';
GO

-- Drop and Recreate CRM Product Info Table
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
PRINT 'Table bronze.crm_prd_info created successfully.';
GO

-- Drop and Recreate CRM Sales Details Table
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
PRINT 'Table bronze.crm_sales_details created successfully.';
GO

-- Drop and Recreate ERP Location Table
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
PRINT 'Table bronze.erp_loc_a101 created successfully.';
GO

-- Drop and Recreate ERP Customer Table
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
PRINT 'Table bronze.erp_cust_az12 created successfully.';
GO

-- Drop and Recreate ERP Product Category Table
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);
PRINT 'Table bronze.erp_px_cat_g1v2 created successfully.';
GO
