use books;

-- Query with Single Row Functions 
-- This query transforms the author's name to uppercase and concatenates it with the book title in a formatted way

SELECT BookID, Title, CONCAT(UPPER(Author), ' - ', Title) AS AuthorAndTitle
FROM Book;


-- Query with Single Row Function  
-- This query returns the full name of the customer in uppercase format for display purposes.

SELECT CustomerID, UPPER(CONCAT(FirstName, ' ', LastName)) AS FullName_UpperCase, Email
FROM Customer;


-- Query with Sorting  
-- This query retrieves orders sorted by total amount in descending order to highlight high-value transactions.

SELECT OrderID, CustomerID, OrderDate, TotalAmount
FROM Orders
ORDER BY TotalAmount DESC;


-- Query with Aggregate Function  
-- This query calculates the total quantity of books sold and total revenue generated from the OrderDetail table.

SELECT SUM(Quantity) AS TotalBooksSold, SUM(Subtotal) AS TotalRevenue
FROM OrderDetail;


-- Query with First N Results  
-- This query retrieves the top 3 genres based on alphabetical order of genre name.

SELECT GenreID, GenreName, Description
FROM Genre
ORDER BY GenreName ASC
LIMIT 3;


-- Query with Selection Control Function  
-- This query labels suppliers as 'Local' or 'Out of State' based on whether their address contains 'AZ'.

SELECT SupplierID, SupplierName, Address,
       CASE 
           WHEN Address LIKE '%AZ%' THEN 'Local'
           ELSE 'Out of State'
       END AS SupplierRegion
FROM Supplier;

-- Query with Sorting  
-- This query lists inventory records ordered by supply date (most recent first).

SELECT InventoryID, BookID, SupplierID, QuantitySupplied, SupplyDate
FROM Inventory
ORDER BY SupplyDate DESC;

-- Query with First N Results  
-- This query retrieves the first 5 publications sorted alphabetically by name.

SELECT PublicationID, PublicationName
FROM Publication
ORDER BY PublicationName
LIMIT 5;

-- Query with Selection Control Function  
-- This query labels payments as 'High', 'Medium', or 'Low' based on the amount paid.

SELECT PaymentID, OrderID, Amount,
       CASE 
           WHEN Amount >= 700 THEN 'High'
           WHEN Amount BETWEEN 300 AND 699 THEN 'Medium'
           ELSE 'Low'
       END AS PaymentCategory
FROM Payment;


