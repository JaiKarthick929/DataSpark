USE DataSpark;
select * from customers;
select * from exchange_rates;
select * from products;
select * from sales;
select * from stores;

-- 1. Distribution by Gender
SELECT Gender, COUNT(*) AS TotalCustomers 
FROM Customers 
GROUP BY Gender;

-- 2 Distribution by City, State, Country, and Continent
SELECT Continent, Country, State, City, COUNT(*) AS TotalCustomers 
FROM Customers 
GROUP BY Continent, Country, State, City 
ORDER BY TotalCustomers DESC;

-- 3 Total Customers
SELECT COUNT(*) AS TotalCustomers 
FROM Customers;

-- 4 Products purchases by gender
SELECT 
    Gender, 
    SUM(Sales.Quantity) AS TotalProductsPurchased
FROM Sales
JOIN Customers ON Sales.CustomerKey = Customers.CustomerKey
GROUP BY Gender
ORDER BY TotalProductsPurchased DESC;

-- 5 Sales done in monthwise
SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month, 
    SUM(UnitPriceUSD * Quantity) AS TotalSales
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
GROUP BY Month
ORDER BY Month;

-- 6 No of Quantity slod by each products
SELECT 
    ProductName, 
    SUM(Quantity) AS TotalQuantitySold
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
GROUP BY ProductName
ORDER BY TotalQuantitySold DESC;

-- 7 Sales by store
SELECT 
    StoreKey, 
    SUM(UnitPriceUSD * Quantity) AS TotalSales
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
GROUP BY StoreKey
ORDER BY TotalSales DESC;

-- 8 Most Product Sales
SELECT 
    ProductName, 
    SUM(Quantity) AS TotalQuantitySold
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
GROUP BY ProductName
ORDER BY TotalQuantitySold DESC;

-- 9 Least Product Sales
SELECT 
    ProductName, 
    SUM(Quantity) AS TotalQuantitySold
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
GROUP BY ProductName
ORDER BY TotalQuantitySold ASC
LIMIT 10;

-- 10 Product Profit Margins
SELECT 
    ProductName, 
    UnitCostUSD, 
    UnitPriceUSD, 
    (UnitPriceUSD - UnitCostUSD) AS ProfitPerUnit,
    ((UnitPriceUSD - UnitCostUSD) / UnitCostUSD) * 100 AS ProfitMarginPercentage
FROM Products
ORDER BY ProfitMarginPercentage DESC;

-- 11 Sales by Category
SELECT 
    Category, 
    SUM(UnitPriceUSD * Quantity) AS TotalSales,
    SUM(Quantity) AS TotalUnitsSold
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
GROUP BY Category
ORDER BY TotalSales DESC;
-- Sales by SubCategory
SELECT 
    Subcategory, 
    SUM(UnitPriceUSD * Quantity) AS TotalSales,
    SUM(Quantity) AS TotalUnitsSold
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
GROUP BY Subcategory
ORDER BY TotalSales DESC;

-- 12 store Performance
SELECT 
    Stores.StoresKey, 
    SUM(UnitPriceUSD * Quantity) AS TotalSales, 
    Square_Meters AS StoreSize, 
    ROUND(SUM(UnitPriceUSD * Quantity) / Square_Meters, 2) AS SalesPerSquareMeter
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
JOIN Stores ON Sales.StoreKey = Stores.StoresKey
GROUP BY Stores.StoresKey, StoreSize
ORDER BY TotalSales DESC;

-- 13 Yearwise Sales
SELECT 
    YEAR(Open_Date) AS OpenYear, 
    SUM(UnitPriceUSD * Quantity) AS TotalSales
FROM Sales
JOIN Products ON Sales.ProductKey = Products.ProductKey
JOIN Stores ON Sales.StoreKey = Stores.StoresKey
GROUP BY OpenYear
ORDER BY OpenYear ASC, TotalSales DESC;




