USE EnergyMonitoringDW;
GO

-- Staging for meter readings data (exact match for CSV structure)
CREATE TABLE Staging_MeterData (
    MeterID NVARCHAR(20),
    CustomerID INT,
    Timestamp DATETIME,
    kWh DECIMAL(10,2),
    LoadBatchID INT,  -- For tracking
	LoadDate DATETIME DEFAULT GETDATE()
);

-- Staging for customers
CREATE TABLE Staging_Customers (
    CustomerID INT,
    Name NVARCHAR(100),
    Address NVARCHAR(200),
    TariffPlan NVARCHAR(50),
    LoadBatchID INT  -- For tracking
);

-- Error Logging
CREATE TABLE ETL_Errors (
    ErrorID INT IDENTITY(1,1),
    ErrorTime DATETIME DEFAULT GETDATE(),
    ErrorMessage NVARCHAR(500),
    SourceData NVARCHAR(MAX)
);

-- Batch Tracking
CREATE TABLE ETL_Batches (
    BatchID INT IDENTITY(1,1),
    StartTime DATETIME DEFAULT GETDATE(),
    EndTime DATETIME,
    Status NVARCHAR(20),
    RowsProcessed INT
);