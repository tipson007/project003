USE NorthwindTipsonDW
GO

INSERT INTO DimSupplier(SupplierID, CountryName, CityName)
SELECT SupplierID,Country, City FROM
NORTHWND.dbo.Suppliers


USE NorthwindTipsonDW
Go
INSERT INTO DimEmployee(EmployeeID, EmployeeLastname, EmployeeFirstame, ReportsTo)
SELECT Employees.EmployeeID, Employees.LastName,
Employees.FirstName, Employees.ReportsTo              
FROM NORTHWND.dbo.Employees


USE NorthwindTipsonDW
Go

INSERT INTO DimProduct(ProductID, ProductName, ProductCategory)
SELECT        Products.ProductID, Products.ProductName, Categories.CategoryName
FROM            NORTHWND.dbo.Categories INNER JOIN
                         NORTHWND.dbo.Products ON NORTHWND.dbo.Categories.CategoryID = NORTHWND.dbo.Products.CategoryID


USE NorthwindTipsonDW
Go

INSERT INTO DimCustomer(CustomerID, CustomerName, City, Country)
SELECT        Customers.CustomerID, Customers.ContactName,
Customers.City, Customers.Country  
FROM            NORTHWND.dbo.Customers

USE NorthwindTipsonDW
Go

INSERT INTO DimTime(FullDate, TYear, TQuarter, TMonth, TDay)
Select NORTHWND.dbo.Orders.ShippedDate, DATEPART(year, NORTHWND.dbo.Orders.ShippedDate), DATEPART(quarter,NORTHWND.dbo.Orders.ShippedDate), DATEPART(month, NORTHWND.dbo.Orders.ShippedDate),
DATEPART(day, NORTHWND.dbo.Orders.ShippedDate)
FROM            NORTHWND.dbo.Orders


USE NorthwindTipsonDW
GO

INSERT INTO FactSalesOrders(ProductKey, CustomerKey, 
SupplierKey, TimeKey, EmployeeKey, OrderQuantity, UnitPrice, Discount, OrderCost)

SELECT DISTINCT dbo.DimProduct.ProductKey, 
		dbo.DimCustomer.CustomerKey, 
		dbo.DimSupplier.SupplierKey, 
		dbo.DimTime.TimeKey, 
		dbo.DimEmployee.EmployeeKey, 
		NORTHWND.dbo.[Order Details].Quantity, 
		NORTHWND.dbo.[Order Details].UnitPrice, 
		NORTHWND.dbo.[Order Details].Discount

FROM	NORTHWND.dbo.Orders INNER JOIN
		NORTHWND.dbo.[Order Details] ON NORTHWND.dbo.Orders.OrderID = NORTHWND.dbo.[Order Details].OrderID INNER JOIN
		NORTHWND.dbo.Products ON NORTHWND.dbo.[Order Details].ProductID = NORTHWND.dbo.Products.ProductID INNER JOIN
		NorthwindTipsonDW.dbo.DimTime ON NORTHWND.dbo.Orders.ShippedDate = NorthwindTipsonDW.dbo.DimTime.FullDate INNER JOIN
		NorthwindTipsonDW.dbo.DimEmployee ON NORTHWND.dbo.Orders.EmployeeID = NorthwindTipsonDW.dbo.DimEmployee.EmployeeID INNER JOIN
		NorthwindTipsonDW.dbo.DimCustomer ON NORTHWND.dbo.Orders.CustomerID = NorthwindTipsonDW.dbo.DimCustomer.CustomerID INNER JOIN
		NorthwindTipsonDW.dbo.DimSupplier ON NORTHWND.dbo.Orders.ShipVia = NorthwindTipsonDW.dbo.DimSupplier.SupplierID INNER JOIN
		NorthwindTipsonDW.dbo.DimProduct ON NORTHWND.dbo.[Order Details].ProductID = NorthwindTipsonDW.dbo.DimProduct.ProductID

ORDER BY 1,2,3,4,5 ASC
						 