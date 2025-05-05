-- Create the database
CREATE DATABASE Books;

-- Select the database for use
USE Books;

-- Creating the tables
CREATE TABLE Publication (
    PublicationID CHAR(4) PRIMARY KEY,
    PublicationName VARCHAR(25)
);

CREATE TABLE Publication_Book (
    PublicationID CHAR(4),
    BookID INT,
    PRIMARY KEY (PublicationID, BookID)
);

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(45),
    Author VARCHAR(45),
    Price FLOAT,
    StockQuantity INT,
    GenreID INT
);


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(10),
    LastName VARCHAR(10),
    Email VARCHAR(30),
    Phone VARCHAR(15),
    Address VARCHAR(60)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    TotalAmount FLOAT,
    CustomerID INT
);

CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    Subtotal FLOAT,
    OrderID INT,
    BookID INT,
    Quantity INT
);

CREATE TABLE Genre (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(15),
    Description VARCHAR(50)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATE,
    PaymentMethod VARCHAR(20),
    Amount FLOAT,
    OrderID INT
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(30),
    ContactName VARCHAR(25),
    Phone VARCHAR(15),
    Email VARCHAR(50),
    Address VARCHAR(60)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    BookID INT,
    SupplierID INT,
    QuantitySupplied INT,
    SupplyDate DATE
);

-- Adding the foreign keys
ALTER TABLE Publication_Book 
ADD CONSTRAINT fk_Publication_BookID FOREIGN KEY (BookID) REFERENCES Book(BookID),
ADD CONSTRAINT fk_Publication_PublicationID FOREIGN KEY (PublicationID) REFERENCES Publication(PublicationID);

ALTER TABLE Book 
ADD CONSTRAINT fk_Book_Genre FOREIGN KEY (GenreID) REFERENCES Genre(GenreID);

ALTER TABLE Orders 
ADD CONSTRAINT fk_Orders_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

ALTER TABLE OrderDetail 
ADD CONSTRAINT fk_OrderDetail_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
ADD CONSTRAINT fk_OrderDetail_Book FOREIGN KEY (BookID) REFERENCES Book(BookID);

ALTER TABLE Payment 
ADD CONSTRAINT fk_Payment_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

ALTER TABLE Inventory 
ADD CONSTRAINT fk_Inventory_Book FOREIGN KEY (BookID) REFERENCES Book(BookID),
ADD CONSTRAINT fk_Inventory_Supplier FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID);

-- Now inserting the values
INSERT INTO Publication (PublicationID, PublicationName) VALUES
('P001', 'Harper & Co.'),
('P002', 'Penguin Books'),
('P003', 'Global Reads'),
('P004', 'Peak Publications'),
('P005', 'Legacy Books'),
('P006', 'Elite Books'),
('P007', 'Evergreen Books'),
('P008', 'New Age Publishing'),
('P009', 'Infinity Press');

INSERT INTO Genre (GenreID, GenreName, Description) VALUES
(1, 'Fiction', 'Thus common control.'),
(2, 'Non-Fiction', 'Yes necessary music standard later worker force.'),
(3, 'Science', 'Than chance true treat approach.'),
(4, 'History', 'Federal lot pass feeling tell instead commercial.'),
(5, 'Biography', 'Maintain political star he production successful.'),
(6, 'Fantasy', 'Sit bar risk his.'),
(7, 'Mystery', 'Himself about gas task other window leader.');


INSERT INTO Book (BookID, Title, Author, GenreID, Price, StockQuantity) VALUES
(1, 'Group military away.', 'Sydney Scott', 4, 60.00, 47),
(2, 'Research edge.', 'Mrs. Kathryn Edwards', 3, 96.13, 6),
(3, 'Cultural these available.', 'Rachael Butler', 6, 84.51, 29),
(4, 'Subject development.', 'Stephen Thomas', 3, 71.18, 16),
(5, 'Soldier explain.', 'Jennifer Ruiz', 2, 42.09, 16),
(6, 'Ready true we.', 'Daniel Carter', 4, 11.31, 17),
(7, 'Last music.', 'Stacy Adams', 7, 99.24, 13),
(8, 'Seat grow.', 'Tommy Edwards', 4, 87.48, 47),
(9, 'Spend enough.', 'Allen Williams', 6, 49.53, 15),
(10, 'Impact second.', 'Thomas Rodriguez', 5, 84.06, 43),
(11, 'Teach fish.', 'Richard Matthews', 6, 63.80, 43),
(12, 'Including film.', 'Mary Robbins', NULL, 13.71, 14),
(13, 'Final show military.', 'Mary Evans', 3, 74.32, 25),
(14, 'News fight west.', 'Karen Buchanan', 2, 94.94, 20),
(15, 'Film possible enough anyone.', 'Sergio Bell', 5, 88.09, 18);

INSERT INTO Publication_Book (PublicationID, BookID) VALUES
('P001', 1),
('P003', 2),
('P005', 3),
('P007', 14),
('P002', 13),
('P004', 5),
('P006', 15),
('P008', 9),
('P009', 8),
('P007', 11),
('P005', 12),
('P004', 3),
('P001', 5),
('P002', 9),
('P004', 10),
('P007', 6),
('P008', 6),
('P009', 7),
('P002', 3),
('P003', 4);


INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Phone, Address) VALUES
(1, 'Thomas', 'Johnson', 'tjohnson@yahoo.com', '671-292-5003', '849 Michael Stravenue Suite 019, New Jeffrey, CA 87181'),
(2, 'Michael', 'Chavez', 'mchavez@yahoo.com', '850-534-3884', 'Unit 3126 Box 7807, DPO AE 80060'),
(3, 'Kelly', 'Hall', 'hallk@gmail.com', '680-544-4398', '3962 Mary Union, South Amanda, OH 80602'),
(4, 'Kayla', 'Walter', 'walterk@williams.com', '146-699-4135', 'USNV Hodges, FPO AA 05459'),
(5, 'Matthew', 'Huynh', 'mathewh@gmail.com', '254-004-9017', '8224 Boyer Locks, North Amyberg, SD 32940'),
(6, 'Mark', 'Bauer', 'markbauer@gmail.com', '101-599-8707', '7563 Hunter Ranch, West Vickistad, VT 54748'),
(7, 'Lisa', 'Hartman', 'hartman@hotmail.com', '724-759-3674', '89223 Campos Valley, Mannborough, NM 54873'),
(8, 'Natalie', 'Robles', 'natalier@king-ramos.info', '123-734-0104', '83605 Pamela Crescent Suite 778, East Jamestown, WV 53326'),
(9, 'Michael', 'Hayes', 'michael@simmons.org', '774-914-2165', '9136 Cross Plains, North Deborahview, DC 01714'),
(10, 'Lisa', 'Tran', 'lisa@gmail.com', '972-391-1533', '253 Heather Cape, Fordmouth, ME 24285');

INSERT INTO Orders (OrderID, OrderDate, CustomerID, TotalAmount) VALUES
(1, '2024-11-25', 9, 120),
(2, '2024-08-29', 6, 845.42),
(3, '2024-10-07', 6, 528.48),
(4, '2024-12-16', 8, 253.53),
(5, '2024-11-24', 7, 487.6),
(6, '2024-12-19', 7, 223.73),
(7, '2024-07-15', 7, 586.11),
(8, '2024-12-06', 3, 60),
(9, '2024-12-04', 10, 791.9),
(10, '2024-02-29', 6, 22.62),
(11, '2024-08-22', 9, 692.99),
(12, '2024-06-18', 10, 284.82),
(13, '2025-01-28', 9, 352.36),
(14, '2024-10-16', 2, 130.87),
(15, '2024-08-11', 8, 316.2),
(16, '2024-08-13', 5, 183.42),
(17, '2024-07-30', 3, 539.7),
(18, '2024-08-29', 5, 339.06),
(19, '2024-02-14', 8, 433.98),
(20, '2024-09-09', 5, 404.48);

INSERT INTO OrderDetail (OrderDetailID, OrderID, BookID, Quantity, Subtotal) VALUES
(1, 1, 1, 2, 120),
(2, 2, 4, 4, 284.72),
(3, 2, 2, 4, 384.52),
(4, 2, 15, 2, 176.18),
(5, 3, 15, 5, 440.45),
(6, 3, 13, 1, 74.32),
(7, 3, 12, 1, 13.71),
(8, 4, 3, 3, 253.53),
(9, 5, 5, 2, 84.18),
(10, 5, 14, 2, 189.88),
(11, 5, 4, 3, 213.54),
(12, 6, 2, 1, 96.13),
(13, 6, 11, 2, 127.6),
(14, 7, 2, 3, 288.39),
(15, 7, 7, 3, 297.72),
(16, 8, 1, 1, 60),
(17, 9, 10, 5, 420.3),
(18, 9, 13, 5, 371.6),
(19, 10, 6, 2, 22.62),
(20, 11, 7, 4, 396.96),
(21, 11, 4, 4, 284.72),
(22, 11, 6, 1, 11.31),
(23, 12, 14, 3, 284.82),
(24, 13, 15, 4, 352.36),
(25, 14, 13, 1, 74.32),
(26, 14, 6, 5, 56.55),
(27, 15, 12, 5, 68.55),
(28, 15, 9, 5, 247.65),
(29, 16, 7, 1, 99.24),
(30, 16, 5, 2, 84.18),
(31, 17, 4, 5, 355.90),
(32, 17, 1, 2, 120.00),
(33, 17, 11, 1, 63.80),
(34, 18, 9, 2, 99.06),
(35, 18, 1, 4, 240.00),
(36, 19, 10, 4, 349.92),
(37, 19, 10, 1, 84.06),
(38, 20, 5, 1, 87.48),
(39, 20, 13, 2, 148.64),
(40, 20, 5, 4, 168.36);

INSERT INTO Payment (PaymentID, OrderID, PaymentDate, PaymentMethod, Amount) VALUES
(1, 1, '2024-08-10', 'PayPal', 120),
(2, 2, '2025-01-25', 'PayPal', 845.42),
(3, 3, '2024-12-10', 'Bank Transfer', 528.48),
(4, 4, '2024-08-15', 'Credit Card', 253.53),
(5, 5, '2024-05-19', 'Bank Transfer', 487.6),
(6, 6, '2024-08-28', 'PayPal', 223.73),
(7, 7, '2024-08-15', 'Bank Transfer', 586.11),
(8, 8, '2024-05-14', 'Bank Transfer', 60),
(9, 9, '2024-03-07', 'Bank Transfer', 791.9),
(10, 10, '2024-10-07', 'Credit Card', 22.62),
(11, 11, '2024-05-05', 'Credit Card', 692.99),
(12, 12, '2024-12-09', 'Credit Card', 284.82),
(13, 13, '2024-02-19', 'Bank Transfer', 352.36),
(14, 14, '2025-02-07', 'PayPal', 130.87),
(15, 15, '2024-09-07', 'Credit Card', 316.2),
(16, 16, '2024-11-22', 'Credit Card', 183.42),
(17, 17, '2024-10-03', 'Credit Card', 539.7),
(18, 18, '2024-10-29', 'Bank Transfer', 339.06),
(19, 19, '2024-12-14', 'PayPal', 433.98),
(20, 20, '2024-06-23', 'PayPal', 404.48);

INSERT INTO Supplier (SupplierID, SupplierName, ContactName, Phone, Email, Address) VALUES
(1, 'Russell-Peterson', 'Jeffrey Castillo', '(520) 462-3110', 'bbowen@taylor.com', '562 Benton Lake, Lake Sheila, AZ 38541'),
(2, 'Reeves Ltd', 'Bryan Phillips', '(520) 204-8650', 'hunter30@kirk.com', '72698 Heather Groves Apt. 125, North Betty, HI 20603'),
(3, 'Little, Clark and Velazquez', 'Rebecca Davis', '(535) 285-8950', 'tylermartin@jensen-owen.org', '140 Adam Radial Apt. 710, South Michelle, HI 89822'),
(4, 'Jimenez, Perry and Wilkerson', 'Angela Larson', '(788) 784-1396', 'lisa96@marquez.org', '8900 Shaw Route Suite 695, Michaelfurt, MS 57393'),
(5, 'Hancock, Chavez and Ross', 'Karen Craig', '(539) 365-4108', 'melvin99@allen.com', '635 Seth Hill, East Christopher, NC 49086');

INSERT INTO Inventory (InventoryID, BookID, SupplierID, QuantitySupplied, SupplyDate) VALUES
(1, 1, 1, 50, '2024-12-06'),
(2, 2, 5, 56, '2024-12-05'),
(3, 3, 2, 90, '2024-02-26'),
(4, 4, 5, 24, '2023-02-24'),
(5, 5, 2, 33, '2023-05-29'),
(6, 6, 5, 36, '2024-01-18'),
(7, 7, 5, 31, '2023-12-21'),
(8, 8, 1, 46, '2024-02-02'),
(9, 9, 4, 46, '2024-08-28'),
(10, 10, 5, 19, '2023-09-30'),
(11, 11, 4, 53, '2023-06-14'),
(12, 12, 3, 98, '2024-10-21'),
(13, 13, 1, 65, '2024-12-13'),
(14, 14, 4, 97, '2023-06-10'),
(15, 15, 4, 72, '2024-04-29');
