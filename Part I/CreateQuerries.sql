USE NorthwindTipsonDW
Go

CREATE TABLE DimProduct
(
ProductKey int identity NOT NULL PRIMARY KEY,
ProductID int NOT NULL, --Business key
ProductName varchar(50)NOT NULL,
ProductCategory varchar(100)NOT NULL
)

Go
CREATE TABLE DimCustomer
(
CustomerKey int identity NOT NULL PRIMARY KEY,
CustomerID nchar(50) NOT NULL, --Business key
CustomerName varchar(100) NOT NULL,
City varchar(50) NULL,
Country varchar(50) NULL
)

Go

--drop table FactSalesOrders
--drop table DimSupplier
CREATE TABLE DimSupplier
(
SupplierKey int identity  NOT NULL PRIMARY KEY,
SupplierID int NOT NULL, --Business key
CountryName varchar(100) NOT NULL,
CityName varchar(100) NOT NULL
)

Go
CREATE TABLE DimTime
(
TimeKey int identity  NOT NULL PRIMARY KEY,
FullDate datetime NULL, --Business key
TYear varchar(50) NULL,
TQuarter varchar(100) NULL,
TMonth varchar(50) NULL,
TDay varchar(50) NULL
)

Go
CREATE TABLE DimEmployee
(
EmployeeKey int identity  NOT NULL PRIMARY KEY,
EmployeeID int NOT NULL, --Business key
EmployeeLastname varchar(100) NOT NULL,
EmployeeFirstame varchar(100) NOT NULL,
ReportsTo varchar(50) NULL
)

GO
CREATE TABLE FactSalesOrders
(
FactSalesOrdersKey int identity  NOT NULL PRIMARY KEY,
ProductKey int NOT NULL REFERENCES DimProduct(ProductKey),
CustomerKey int NOT NULL REFERENCES DimCustomer(CustomerKey),
SupplierKey int NOT NULL REFERENCES DimSupplier(SupplierKey),
TimeKey int NOT NULL REFERENCES DimTime(TimeKey),
EmployeeKey int NOT NULL REFERENCES DimEmployee(EmployeeKey),
OrderQuantity smallint NULL,
UnitPrice money NULL,
Discount real NULL
)