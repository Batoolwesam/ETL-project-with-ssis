--minimarket online sotre

CREATE DATABASE MiniStoreSource;


USE MiniStoreSource;

CREATE TABLE dbo.Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    City NVARCHAR(50)
);


INSERT INTO dbo.Customers
    (CustomerID, CustomerName, City)
VALUES
(1,  'Ahmed Hassan',       'Cairo'),
(2,  'Mariam Ali',         'Giza'),
(3,  'Omar Mohamed',      'Alexandria'),
(4,  'Sara Mahmoud',       'Tanta'),
(5,  '   ',                'Mansoura'),       
(6,  'Nour Khaled',        'Cairo'),
(7,  'Mostafa Adel',       'Giza'),
(8,  'Farah Samir',        'Alexandria'),
(9,  'Karim Ashraf',       '   '),            
(10, 'Jana Tarek',         'Ismailia'),
(11, 'Abdelrahman Said',   'Port Said'),
(12, 'Layla Hany',         'Zagazig'),
(13, 'Mohamed Fathy',      'Beni Suef'),
(14, 'Hana Sherif',        'Aswan'),
(15, 'Merna El Hagar',     'Kafr El Sheikh');


CREATE TABLE dbo.Products
(
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO dbo.Products
    (ProductID, ProductName, Category, Price)
VALUES
(1,  'White Rice ',          'Groceries',       45.00),
(2,  'Sugar ',               'Groceries',       35.00),
(3,  'Flour ',               'Groceries',      -30.00), 
(4,  'Cooking Oil ',         'Groceries',       85.00),
(5,  'Pasta ',               'Groceries',       20.00),
(6,  'Milk ',                'Dairy',           40.00),
(7,  'White Cheese ',        'Dairy',           65.00),
(8,  'Eggs ',                'Dairy',          165.00),
(9,  'Yogurt ',              'Dairy',           15.00),
(10, 'Bottled Water ',       'Beverages',       15.00),
(11, 'Orange Juice ',        'Beverages',       50.00),
(12, 'Cola ',                'Beverages',       30.00),
(13, 'Potato Chips',         'Snacks',          15.00),
(14, 'Chocolate Bar',        'Snacks',          25.00),
(15, '   ',                  'Snacks',          20.00), 
(16, 'Dishwashing Liquid',   'Cleaning',        55.00),
(17, 'Laundry Detergent ',   'Cleaning',       110.00),
(18, 'Paper Towels',         NULL,               45.00), 
(19, 'Shampoo ',             'Personal Care',   95.00),
(20, 'Toothpaste',           'Personal Care',   50.00);

CREATE TABLE dbo.Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderStatus NVARCHAR(20),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES dbo.Customers(CustomerID)
);

INSERT INTO dbo.Orders
    (OrderID, CustomerID, OrderDate, OrderStatus)
VALUES
(1001, 1,  '2026-01-05', 'Completed'),
(1002, 2,  '2026-01-07', 'Completed'),
(1003, 3,  '2026-01-10', 'Cancelled'),
(1004, 4,  '2026-01-12', 'Completed'),
(1005, 5,  '2026-01-15', 'Pending'),
(1006, 6,  '2026-01-18', 'Completed'),
(1007, 7,  '2026-01-20', 'Completed'),
(1008, 8,  '2026-01-22', 'Cancelled'),
(1009, 9,  '2026-02-02', 'Completed'),
(1010, 10, '2026-02-05', 'Completed'),
(1011, 11, '2026-02-08', 'Pending'),
(1012, 12, '2026-02-10', 'Completed'),
(1013, 13, '2026-02-13', 'Completed'),
(1014, 15, '2026-02-15', 'Completed'),
(1015, 1,  '2026-02-18', 'Completed'),
(1016, 2,  '2026-02-20', 'Cancelled'),
(1017, 3,  '2026-03-01', 'Completed'),
(1018, 4,  '2026-03-04', 'Pending'),
(1019, 5,  '2026-03-07', 'Completed'),
(1020, 6,  '2026-03-10', 'Completed'),
(1021, 7,  '2026-03-12', 'Completed'),
(1022, 8,  '2026-03-15', 'Completed'),
(1023, 9,  '2026-03-18', 'Cancelled'),
(1024, 10, '2026-03-20', 'Completed'),
(1025, 11, '2026-03-23', 'Completed'),
(1026, 15, '2026-03-25', 'Pending');

CREATE TABLE dbo.OrderItems
(
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID)
);

INSERT INTO dbo.OrderItems
    (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1,  1001, 1,  2, 45.00),
(2,  1001, 6,  2, 40.00),
(3,  1001, 13, 3, 15.00),
(4,  1002, 2,  2, 35.00),
(5,  1002, 4,  1, 85.00),
(6,  1003, 8,  1, 165.00),
(7,  1003, 5,  4, 20.00),
(8,  1004, 7,  1, 65.00),
(9,  1004, 9,  4, 15.00),
(10, 1005, 3,  2, 30.00),
(11, 1005, 10, 6, 15.00),
(12, 1006, 11, 2, 50.00),
(13, 1006, 14, 3, 25.00),
(14, 1007, 17, 1, 110.00),
(15, 1007, 16, 2, 55.00),
(16, 1008, 19, 1, 95.00),
(17, 1008, 20, 2, 50.00),
(18, 1009, 1,  -2, 45.00),    
(19, 1009, 5,   0, 20.00),    
(20, 1010, 6,   3, -40.00),   
(21, 1010, 8,   1, NULL),      
(22, 1011, 18, 2, 45.00),
(23, 1011, 12, 4, 30.00),
(24, 1012, 4,  2, 85.00),
(25, 1012, 2,  3, 35.00),
(26, 1013, 7,  2, 65.00),
(27, 1013, 9,  6, 15.00),
(28, 1014, 1,  2, 45.00),
(29, 1014, 6,  2, 40.00),
(30, 1014, 14, 2, 25.00),
(31, 1015, 10, 8, 15.00),
(32, 1015, 13, 4, 15.00),
(33, 1016, 17, 2, 110.00),
(34, 1016, 16, 1, 55.00),
(35, 1017, 3,  3, 30.00),
(36, 1017, 5,  6, 20.00),
(37, 1018, 11, 1, 50.00),
(38, 1018, 12, 3, 30.00),
(39, 1019, 8,  1, 165.00),
(40, 1019, 7,  1, 65.00),
(41, 1020, 19, 2, 95.00),
(42, 1020, 20, 2, 50.00),
(43, 1021, 4,  1, 85.00),
(44, 1021, 1,  2, 45.00),
(45, 1022, 15, 4, 20.00),
(46, 1022, 14, 2, 25.00),
(47, 1023, 2,  4, 35.00),
(48, 1023, 3,  2, 30.00),
(49, 1024, 6,  2, 40.00),
(50, 1024, 9,  4, 15.00),
(51, 1025, 16, 2, 55.00),
(52, 1025, 18, 3, 45.00),
(53, 1026, 11, 2, 50.00),
(54, 1026, 13, 5, 15.00);

-- CREATE DATA WAREHOUSE

CREATE DATABASE MiniStoreDW;

USE MiniStoreDW;

CREATE TABLE dbo.DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL UNIQUE,
    CustomerName NVARCHAR(100),
    City NVARCHAR(50)
);

CREATE TABLE dbo.DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL UNIQUE,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2) 
);

CREATE TABLE dbo.DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    [Year] INT,
    [Month] INT,
    MonthName NVARCHAR(20)
);

CREATE TABLE dbo.FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    OrderItemID INT NOT NULL UNIQUE,
    OrderID INT NOT NULL,
    DateKey INT NOT NULL FOREIGN KEY REFERENCES dbo.DimDate(DateKey),
    CustomerKey INT NOT NULL FOREIGN KEY REFERENCES dbo.DimCustomer(CustomerKey),
    ProductKey INT NOT NULL FOREIGN KEY REFERENCES dbo.DimProduct(ProductKey),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    SalesAmount DECIMAL(12,2) NOT NULL
);

CREATE TABLE dbo.RejectedCustomers (
    RejectID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    CustomerName NVARCHAR(100),
    City NVARCHAR(50),
    RejectReason NVARCHAR(255)
);

CREATE TABLE dbo.RejectedProducts (
    RejectID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10,2),
    RejectReason NVARCHAR(255)
);

USE MiniStoreDW;

--before running the package we run these commands, 
--so we don't have duplicates of the unique values

DELETE FROM dbo.FactSales;
DELETE FROM dbo.DimCustomer;
DELETE FROM dbo.DimProduct;
DELETE FROM dbo.DimDate;
DELETE FROM dbo.RejectedCustomers;
DELETE FROM dbo.RejectedProducts;
----------------------------------------------------------------------------------------------