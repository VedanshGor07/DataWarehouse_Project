
-- Script purpose : This script creates a database after checking whether it already exists ? IF Exists Then it drops it and makes a new DWH
-- Warning. : running this code will delete every data in database permanently.Ensure You have backup before running it.

DROP DATABASE IF EXISTS DataWarehouse;
CREATE DATABASE DataWarehouse;


USE DataWarehouse;

CREATE SCHEMA Bronze;
CREATE SCHEMA Silver;
CREATE SCHEMA Gold; 
