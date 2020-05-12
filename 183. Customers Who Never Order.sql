## Slowest
## Success
## Runtime: 1313 ms, faster than 5.00% of MySQL online submissions for Customers Who #Never Order.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Customers Who #Never Order.

SELECT c.Name AS Customers 
FROM Customers c LEFT JOIN Orders o
ON c.Id = o.CustomerId
WHERE ISNULL(o.Id);

#-------------------------------------

# Middle
## Success
## Runtime: 598 ms, faster than 27.64% of MySQL online submissions for Customers Who #Never Order.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Customers Who #Never Order.

SELECT c.Name As Customers
FROM Customers c
WHERE c.Id not in 
(
SELECT CustomerId FROM Orders
)

#-------------------------------------
## Fastest
## Success
## Runtime: 515 ms, faster than 37.61% of MySQL online submissions for Customers Who Never Order.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Customers Who Never Order.

SELECT c.Name As Customers 
FROM Customers c
WHERE NOT EXISTS (SELECT 1 FROM Orders o WHERE c.Id = o.CustomerId);
