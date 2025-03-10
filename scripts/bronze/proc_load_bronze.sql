-- ============================================================
-- Stored Procedure: bronze.load_bronze
-- Purpose: Loads data into the Bronze Layer using BULK INSERT.
-- Notes:
--   - Loads multiple CSV files into corresponding tables.
--   - Uses TRY...CATCH for error handling.
--   - Tracks and displays execution time for each table and total duration.
-- Warnings:
--   - Ensure SQL Server has read access to the file locations.
--   - Files should be correctly formatted (CSV with ',' delimiter).
-- ============================================================
EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @total_start DATETIME, @total_end DATETIME;

    BEGIN TRY
        PRINT '============================================================'
        PRINT '               STARTING BRONZE LAYER LOADING               '
        PRINT '============================================================'

        -- Start Total Execution Timer
        SET @total_start = GETDATE();

        -- Loading Customer Information
        PRINT 'Loading: bronze.crm_cust_info'
        SET @start_time = GETDATE();
        
        BULK INSERT bronze.crm_cust_info
        FROM 'E:\resume_projects\sql\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);

        SET @end_time = GETDATE();
        PRINT '✅ Loaded: bronze.crm_cust_info'
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

        -- Loading Product Information
        PRINT 'Loading: bronze.crm_prd_info'
        SET @start_time = GETDATE();
        
        BULK INSERT bronze.crm_prd_info
        FROM 'E:\resume_projects\sql\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);

        SET @end_time = GETDATE();
        PRINT '✅ Loaded: bronze.crm_prd_info'
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

        -- Loading Sales Details
        PRINT 'Loading: bronze.crm_sales_details'
        SET @start_time = GETDATE();
        
        BULK INSERT bronze.crm_sales_details
        FROM 'E:\resume_projects\sql\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);

        SET @end_time = GETDATE();
        PRINT '✅ Loaded: bronze.crm_sales_details'
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

        -- Loading ERP Customer Data
        PRINT 'Loading: bronze.erp_cust_az12'
        SET @start_time = GETDATE();
        
        BULK INSERT bronze.erp_cust_az12
        FROM 'E:\resume_projects\sql\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);

        SET @end_time = GETDATE();
        PRINT '✅ Loaded: bronze.erp_cust_az12'
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

        -- Loading ERP Location Data
        PRINT 'Loading: bronze.erp_loc_a101'
        SET @start_time = GETDATE();
        
        BULK INSERT bronze.erp_loc_a101
        FROM 'E:\resume_projects\sql\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);

        SET @end_time = GETDATE();
        PRINT '✅ Loaded: bronze.erp_loc_a101'
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

        -- Loading ERP Product Category Data
        PRINT 'Loading: bronze.erp_px_cat_g1v2'
        SET @start_time = GETDATE();
        
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'E:\resume_projects\sql\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);

        SET @end_time = GETDATE();
        PRINT '✅ Loaded: bronze.erp_px_cat_g1v2'
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

        -- End Total Execution Timer
        SET @total_end = GETDATE();

        PRINT '============================================================'
        PRINT '               BRONZE LAYER LOADING COMPLETED               '
        PRINT '============================================================'
        PRINT '🚀 Total Execution Time: ' + CAST(DATEDIFF(SECOND, @total_start, @total_end) AS NVARCHAR) + ' seconds'

    END TRY
    BEGIN CATCH
        -- Error Handling
        PRINT '❌ ERROR: An error occurred while loading the Bronze Layer.'
        PRINT ERROR_MESSAGE();  -- Print the error message
        PRINT '============================================================'
    END CATCH
END;
