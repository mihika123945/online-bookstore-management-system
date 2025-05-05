-- Procedure that simplifies inserting a new order and its details by calculating the total amount internally

DELIMITER $$

CREATE PROCEDURE AddOrderWithDetails(
	IN p_OrderID INT,
    IN p_CustomerID INT,
    IN p_OrderDate DATE,
    IN p_BookID INT,
    IN p_Quantity INT
)
BEGIN
    DECLARE v_Price FLOAT;
    DECLARE v_Subtotal FLOAT;

    -- Get book price
    SELECT Price INTO v_Price
    FROM Book
    WHERE BookID = p_BookID;

    SET v_Subtotal = v_Price * p_Quantity;

    -- Insert into Orders table
    INSERT INTO Orders (OrderID, OrderDate, CustomerID, TotalAmount)
    VALUES (p_OrderID, p_OrderDate, p_CustomerID, v_Subtotal);


    -- Insert into OrderDetail table
    INSERT INTO OrderDetail (OrderID, BookID, Quantity, Subtotal)
    VALUES (p_OrderID, p_BookID, p_Quantity, v_Subtotal);
END$$

DELIMITER ;

-- Validation of procedure 

START TRANSACTION;

-- Calling the procedure to simulate adding an order for customer 1, book 2, quantity 3
CALL AddOrderWithDetails(22, 1, '2025-03-28', 2, 3);

-- Checking the newly inserted order
SELECT * FROM Orders ORDER BY OrderID DESC LIMIT 1;
SELECT * FROM OrderDetail ORDER BY OrderDetailID DESC LIMIT 1;

ROLLBACK;

-- Procedure that returns a quick sales summary for any month (total orders, revenue, avg order value).

DELIMITER $$

CREATE PROCEDURE MonthlySalesReport(
    IN p_Year INT,
    IN p_Month INT
)
BEGIN
    SELECT 
        COUNT(OrderID) AS TotalOrders,
        SUM(TotalAmount) AS TotalRevenue,
        AVG(TotalAmount) AS AverageOrderValue
    FROM Orders
    WHERE YEAR(OrderDate) = p_Year AND MONTH(OrderDate) = p_Month;
END$$

DELIMITER ;

-- Validation of procedure

START TRANSACTION;

-- Run a report for December 2024
CALL MonthlySalesReport(2024, 12);

ROLLBACK;

-- Function that returns the customer's full name from their id
DELIMITER $$

CREATE FUNCTION GetCustomerName(p_CustomerID INT)
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE v_Name VARCHAR(200);
    
    SELECT CONCAT(FirstName, ' ', LastName)
    INTO v_Name
    FROM Customer
    WHERE CustomerID = p_CustomerID;

    RETURN v_Name;
END$$

DELIMITER ;

-- Function Call

SELECT GetCustomerName(1) AS CustomerFullName;

-- Function that gets the most recent order date

DELIMITER $$

CREATE FUNCTION GetLastOrderDate(p_CustomerID INT)
RETURNS DATE
DETERMINISTIC
BEGIN
    DECLARE v_LastDate DATE;

    SELECT MAX(OrderDate)
    INTO v_LastDate
    FROM Orders
    WHERE CustomerID = p_CustomerID;

    RETURN v_LastDate;
END$$

DELIMITER ;

-- Function Call
SELECT GetLastOrderDate(9) AS LastOrder;
