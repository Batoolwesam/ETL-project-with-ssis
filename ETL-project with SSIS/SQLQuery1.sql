USE MiniStoreSource;
--analysis part 

--DISPLAYING ALL THE TABLES
SELECT * FROM dbo.Customers ORDER BY CustomerID;
SELECT * FROM dbo.Products ORDER BY ProductID;
SELECT * FROM dbo.Orders ORDER BY OrderID;
SELECT * FROM dbo.OrderItems ORDER BY OrderItemID;


-- 1.Display all customers and their cities.

SELECT CustomerName, City
FROM dbo.Customers;

--2.Display each order with the customer name and order date.

SELECT
    o.OrderID,
    c.CustomerName,
    o.OrderDate
FROM dbo.Orders AS o
INNER JOIN dbo.Customers AS c
    ON o.CustomerID = c.CustomerID

-- 3. Calculate the total sales amount for each completed order

SELECT
    o.OrderID,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM dbo.Orders o
JOIN dbo.OrderItems oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY o.OrderID;

-- 4. Display the total sales for each product
SELECT
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM dbo.Products p
JOIN dbo.OrderItems oi
    ON p.ProductID = oi.ProductID
JOIN dbo.Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY p.ProductID, p.ProductName;

-- 5. Display the total sales for each customer

SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM dbo.Customers c
JOIN dbo.Orders o
    ON c.CustomerID = o.CustomerID
JOIN dbo.OrderItems oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY c.CustomerID, c.CustomerName;

-- 6. Find the product with the highest sales

SELECT TOP 1
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM dbo.Products p
JOIN dbo.OrderItems oi
    ON p.ProductID = oi.ProductID
JOIN dbo.Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSales DESC;


-- 7. Display the number of orders in each status

SELECT
    OrderStatus,
    COUNT(*) AS NumberOfOrders
FROM dbo.Orders
GROUP BY OrderStatus;
