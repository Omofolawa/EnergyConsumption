USE EnergyMonitoringDW;
GO

-- Staging for meter readings data (exact match for CSV structure)
CREATE TABLE Staging_MeterData (
    MeterID NVARCHAR(20),
    CustomerID INT,
    Timestamp DATETIME,
    kWh DECIMAL(10,2),
    LoadBatchID INT  -- For tracking
);

-- Staging for customers
CREATE TABLE Staging_Customers (
    CustomerID INT,
    Name NVARCHAR(100),
    Address NVARCHAR(200),
    TariffPlan NVARCHAR(50),
    LoadBatchID INT  -- For tracking
);

-- Error Logging: Error tables for rejected rows
CREATE TABLE Staging_Errors (
    ErrorID INT IDENTITY(1,1),
    ErrorTime DATETIME DEFAULT GETDATE(),
    ErrorMessage NVARCHAR(500),
    SourceData NVARCHAR(MAX)
);