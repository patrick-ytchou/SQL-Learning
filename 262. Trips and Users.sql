
## Solution 1.

SELECT Request_at AS Day,
       ROUND(SUM(t.Status != "Completed") / COUNT(*), 2) AS "Cancellation Rate"
FROM Trips t
JOIN Users d
ON t.Driver_id = d.User_id
AND d.Banned = "No"
AND t.Request_at BETWEEN "2013-10-01" AND "2013-10-03"
JOIN Users d
on t.User_id = d.User_id
AND d.Banned = "No"
GROUP BY Request_at;

## Tables are filtered before joining so that the size is limited. 

## -------------------------------

## Solution 2.

SELECT Request_at AS Day,
       ROUND(SUM(t.Status != "Completed") / COUNT(*), 2) AS "Cancellation Rate"
FROM Trips t
WHERE Request_at BETWEEN "2013-10-01" AND "2013-10-03"
AND Driver_id IN (SELECT Driver_id FROM Users WHERE Banned = "No")
AND User_id IN (SELECT User_id FROM Users WHERE Banned = "No")
GROUP BY Request_at;

## Notes below
## Most databases evaluate IN operator with a series of OR operator.
## When filtering with multi columns, applying with the most restrictive columns first the limit the size of the column.
## Use IN ..... is more efficient than using NOT IN ....