
## Solution 1.
## Runtime: 361 ms, faster than 48.55% of MySQL online submissions for Combine Two Tables.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Combine Two Tables.

SELECT p.FirstName, p.LastName, a.City, a.State
FROM Person p LEFT JOIN Address a
ON p.PersonId = a.PersonId;

