-- Syntax to create DataWarehouse
CREATE DATABASE EnergyMonitoringDW;
GO

USE EnergyMonitoringDW;
GO

-- Dimension Tables
CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Address NVARCHAR(200),
    TariffPlan NVARCHAR(50)
);

CREATE TABLE DimTime (
    TimeID INT PRIMARY KEY, -- Format: YYYYMMDDHHMM
    [Date] DATE,
    [Hour] TINYINT,
    [Minute] TINYINT,
    DayOfWeek NVARCHAR(10)
);

-- Fact Table
CREATE TABLE FactEnergyConsumption (
    ReadingID INT IDENTITY(1,1) PRIMARY KEY,
    MeterID NVARCHAR(20),
    TimeID INT FOREIGN KEY REFERENCES DimTime(TimeID),
    CustomerID INT FOREIGN KEY REFERENCES DimCustomer(CustomerID),
    kWh DECIMAL(10,2),
    Cost AS (kWh * 0.15) PERSISTED -- Example rate: £0.15/kWh
);

-- Create a view for reporting
CREATE VIEW vw_ConsumptionReport AS
SELECT 
    c.Name, c.TariffPlan,
    t.[Date], t.[Hour],
    f.MeterID, f.kWh, f.Cost
FROM FactEnergyConsumption f
JOIN DimCustomer c ON f.CustomerID = c.CustomerID
JOIN DimTime t ON f.TimeID = t.TimeID;