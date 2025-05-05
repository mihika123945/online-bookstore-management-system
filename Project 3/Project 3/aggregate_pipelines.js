// 1. Count total orders per customer and sort it as per customer_id
db.customers.aggregate([
  { $unwind: "$Orders" },
  {
    $group: {
      _id: "$CustomerID",
      totalOrders: { $sum: 1 },
    },
  },
  {
    $sort: { _id: 1 },
  },
]);

//2. Find the total number of distinct books each customer has ordered across all their orders.

db.customers.aggregate([
  { $unwind: "$Orders" },
  { $unwind: "$Orders.OrderDetails" },
  {
    $group: {
      _id: "$CustomerID",
      uniqueBooksOrdered: { $addToSet: "$Orders.OrderDetails.BookID" },
    },
  },
  {
    $project: {
      _id: 1,
      totalUniqueBooks: { $size: "$uniqueBooksOrdered" },
    },
  },
]);

// 3. Show only OrderDetails where quantity > 2

db.customers.aggregate([
  {
    $project: {
      FirstName: 1,
      LastName: 1,
      Orders: {
        $map: {
          input: "$Orders",
          as: "order",
          in: {
            OrderID: "$$order.OrderID",
            FilteredOrderDetails: {
              $filter: {
                input: "$$order.OrderDetails",
                as: "item",
                cond: { $gt: ["$$item.Quantity", 2] },
              },
            },
          },
        },
      },
    },
  },
]);

// 4. Show books priced over $80 per customer

db.customers.aggregate([
  {
    $project: {
      FirstName: 1,
      LastName: 1,
      ExpensiveBooks: {
        $map: {
          input: "$Orders",
          as: "order",
          in: {
            OrderID: "$$order.OrderID",
            FilteredOrderDetails: {
              $filter: {
                input: "$$order.OrderDetails",
                as: "book",
                cond: { $gt: ["$$book.Price", 80] },
              },
            },
          },
        },
      },
    },
  },
]);

// 5. Group customers by genre of books they ordered

db.customers.aggregate([
  { $unwind: "$Orders" },
  { $unwind: "$Orders.OrderDetails" },
  { $match: { "Orders.OrderDetails.Genre.GenreName": { $ne: null } } },
  {
    $group: {
      _id: "$Orders.OrderDetails.Genre.GenreName",
      customersRaw: {
        $push: {
          FirstName: "$FirstName",
          LastName: "$LastName",
        },
      },
    },
  },
  {
    $project: {
      Customers: {
        $setUnion: ["$customersRaw", []],
      },
    },
  },
]);

// 6. Find the latest order date and earliest order date for each customer
db.customers.aggregate([
  { $unwind: "$Orders" },
  {
    $group: {
      _id: "$CustomerID",
      CustomerName: { $first: { $concat: ["$FirstName", " ", "$LastName"] } },
      earliestOrder: { $min: "$Orders.OrderDate" },
      latestOrder: { $max: "$Orders.OrderDate" },
    },
  },
  {
    $project: {
      _id: 0,
      CustomerID: "$_id",
      CustomerName: 1,
      earliestOrder: 1,
      latestOrder: 1,
    },
  },
]);

// 7. For each customer, reshape the document to show a custom label CustomerInfo, and a TotalOrders field.
db.customers.aggregate([
  {
    $project: {
      _id: 0,
      CustomerInfo: {
        FullName: { $concat: ["$FirstName", " ", "$LastName"] },
        Contact: {
          Email: "$Email",
          Phone: "$Phone",
        },
        Address: "$Address",
      },
      TotalOrders: {
        $size: { $ifNull: ["$Orders", []] },
      },
    },
  },
]);
