-- Step 1: Drop the database if it already exists
-- WHY: Ensures a clean setup every time you run the script (avoids conflicts with old data)
DROP DATABASE IF EXISTS DataWarehouse;

-- Step 2: Create a fresh database
-- WHY: This will act as the main container for your data warehouse
CREATE DATABASE DataWarehouse;

-- Step 3: Switch to the newly created database
-- WHY: All further objects (tables, etc.) will be created inside this database
USE DataWarehouse;

-- Step 4: Create separate databases for Bronze, Silver, Gold layers
-- WHY: In MySQL, SCHEMA = DATABASE, so we simulate layers using separate databases
-- These layers represent stages of data processing in a data pipeline

-- Bronze Layer: Raw data (no cleaning, directly ingested)
CREATE DATABASE IF NOT EXISTS Bronze;

-- Silver Layer: Cleaned and transformed data
CREATE DATABASE IF NOT EXISTS Silver;

-- Gold Layer: Final, business-ready data for reporting/analysis
CREATE DATABASE IF NOT EXISTS Gold;
