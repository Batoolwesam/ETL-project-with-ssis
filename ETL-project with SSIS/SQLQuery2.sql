use MiniStoreDW

SELECT SUM(SalesAmount) AS TotalRevenue FROM dbo.FactSales;

SELECT p.ProductName, SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY TotalSales DESC;


SELECT c.CustomerName, SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactSales f
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerName

SELECT c.City, SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactSales f
JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.City

 --the total sales amount by month

 SELECT d.Year, d.MonthName, SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactSales f
JOIN dbo.DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName

--product generated the highest revenue:

SELECT TOP 1 p.ProductName, SUM(f.SalesAmount) AS TotalRevenue
FROM dbo.FactSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY TotalRevenue DESC;

-- Check Source
SELECT COUNT(*) AS SourceCustomerCount FROM MiniStoreSource.dbo.Customers;
-- Check DW
SELECT COUNT(*) AS DWCustomerCount FROM MiniStoreDW.dbo.DimCustomer;

--All expected products were loaded:

-- Check Source
SELECT COUNT(*) AS SourceProductCount FROM MiniStoreSource.dbo.Products;
-- Check DW
SELECT COUNT(*) AS DWProductCount FROM MiniStoreDW.dbo.DimProduct;



--FactSales contains only eligible completed order lines.

SELECT COUNT(*) AS InvalidOrdersCount
FROM MiniStoreDW.dbo.FactSales f
JOIN MiniStoreSource.dbo.Orders o ON f.OrderID = o.OrderID
WHERE o.OrderStatus <> 'Completed';

--No fact row references a missing dimension record.

SELECT COUNT(*) FROM MiniStoreDW.dbo.FactSales
WHERE CustomerKey NOT IN (SELECT CustomerKey FROM MiniStoreDW.dbo.DimCustomer);
SELECT COUNT(*) FROM MiniStoreDW.dbo.FactSales 
WHERE ProductKey NOT IN (SELECT ProductKey FROM MiniStoreDW.dbo.DimProduct);
SELECT COUNT(*) FROM MiniStoreDW.dbo.FactSales 
WHERE DateKey NOT IN (SELECT DateKey FROM MiniStoreDW.dbo.DimDate);


-- Total in Source (Completed, Valid rows only)
SELECT SUM(oi.Quantity * oi.UnitPrice) AS SourceTotalSales
FROM MiniStoreSource.dbo.OrderItems oi
JOIN MiniStoreSource.dbo.Orders o ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed' 
  AND oi.Quantity > 0 
  AND oi.UnitPrice IS NOT NULL;

-- Total in Data Warehouse
SELECT SUM(SalesAmount) AS DW_TotalSales 
FROM MiniStoreDW.dbo.FactSales;