use project3;

// 1. Find customers who placed an order with total amount greater than 600
db.customers.find(
  { Orders: { $elemMatch: { TotalAmount: { $gt: 600 } } } },
  { FirstName: 1, LastName: 1, Orders: { $elemMatch: { TotalAmount: { $gt: 600 } } } }
);

// 2. Find customers who ordered a book priced less than 50 
db.customers.find(
  { "Orders.OrderDetails": { $elemMatch: { "Price": { $lt: 50 } } } },
  { FirstName: 1, LastName: 1, "Orders.OrderDetails.Title": 1, "Orders.OrderDetails.Price": 1 }
);

// 3. Find customers who have purchased a book with the word "military" in the title
db.customers.find(
  { "Orders.OrderDetails.Title": { $regex: "military", $options: "i" } },
  { FirstName: 1, LastName: 1, "Orders.OrderDetails.Title": 1 }
);

// 4. Find customers whose orders included books of Genre 'Fantasy' 
db.customers.find(
  { "Orders.OrderDetails.Genre.GenreName": "Fantasy" },
  { FirstName: 1, LastName: 1, "Orders.OrderDetails.Genre": 1 }
);

// 5. Find customers whose orders paid using 'PayPal' 
db.customers.find(
  { "Orders.Payment.PaymentMethod": "PayPal" },
  { FirstName: 1, LastName: 1, "Orders.Payment.PaymentMethod": 1 }
);

// 6. Find customers who did NOT order books of Genre 'Science' or 'History'
db.customers.find(
  { $nor: [ { "Orders.OrderDetails.Genre.GenreName": "Science" }, { "Orders.OrderDetails.Genre.GenreName": "History" } ] },
  { FirstName: 1, LastName: 1 }
);

// 7. Find the specific order item in orders where quantity is greater than 3
db.customers.find(
  { "Orders.OrderDetails.Quantity": { $gt: 3 } },
  { "FirstName": 1, "LastName": 1, "Orders.OrderDetails.$": 1 }
);