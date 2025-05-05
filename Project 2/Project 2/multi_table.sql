use books;

-- Query with Inner Join using associative and two other tables
-- This query gives how many books each publisher has published, plus one example book title from each

SELECT 
    p.PublicationID,
    p.PublicationName,
    COUNT(b.BookID) AS TotalBooksPublished,
    MIN(b.Title) AS ExampleBookTitle
FROM Publication_Book pb
INNER JOIN Publication p ON pb.PublicationID = p.PublicationID
INNER JOIN Book b ON pb.BookID = b.BookID
GROUP BY p.PublicationID, p.PublicationName
ORDER BY TotalBooksPublished DESC;

-- Query with Inner Join using associative and two other tables  
-- This query shows each publisher along with the genres of the books they publish.

SELECT 
    p.PublicationName,
    g.GenreName,
    COUNT(b.BookID) AS NumBooks
FROM Publication_Book pb
INNER JOIN Book b ON pb.BookID = b.BookID
INNER JOIN Genre g ON b.GenreID = g.GenreID
INNER JOIN Publication p ON pb.PublicationID = p.PublicationID
GROUP BY p.PublicationName, g.GenreName
ORDER BY p.PublicationName;


-- Query with Left Outer Join
-- This query gives a list all customers and their orders (if any), including customers who haven’t placed an order yet.

SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customer c
LEFT OUTER JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID, o.OrderDate;

-- Query with Set Operation
-- This query gives the list of customers who either placed orders before August 2024 or made payments after November 2024.

-- Customers who placed early orders
SELECT DISTINCT c.CustomerID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate < '2024-08-01'

UNION

-- Customers who made late payments
SELECT DISTINCT c.CustomerID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Payment p ON o.OrderID = p.OrderID
WHERE p.PaymentDate > '2024-11-30';

-- Query with Set Operation  
-- This query lists book IDs from inventory where quantity > 50 or books that are priced above 90.

SELECT BookID
FROM Inventory
WHERE QuantitySupplied > 50

UNION

SELECT BookID
FROM Book
WHERE Price > 90;


-- Query with subquery and multi row operation
-- This query gives all orders that include at least one book from genres that have an average price over 70.

SELECT DISTINCT o.OrderID, o.OrderDate, o.TotalAmount
FROM Orders o
JOIN OrderDetail od ON o.OrderID = od.OrderID
JOIN Book b ON od.BookID = b.BookID
WHERE b.GenreID IN (
    SELECT GenreID
    FROM Book
    GROUP BY GenreID
    HAVING AVG(Price) > 70
)
ORDER BY o.OrderDate DESC;

-- Query with Subquery and Multi-row Operation  
-- This query retrieves suppliers who have supplied any book with stock below 20.

SELECT DISTINCT s.SupplierID, s.SupplierName
FROM Supplier s
WHERE s.SupplierID IN (
    SELECT i.SupplierID
    FROM Inventory i
    JOIN Book b ON i.BookID = b.BookID
    WHERE b.StockQuantity < 20
);


-- Query with derived table.
-- This query gives top 3 customers by total order amount.

WITH CustomerTotals AS (
    SELECT 
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(o.TotalAmount) AS TotalSpent
    FROM Customer c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.FirstName, c.LastName
)
SELECT *
FROM CustomerTotals
ORDER BY TotalSpent DESC
LIMIT 3;
