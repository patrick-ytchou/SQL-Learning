

## Solution 1.
## Runtime: 735 ms, faster than 35.75% of MySQL online submissions for Department Highest Salary.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Department Highest Salary.

SELECT d.Name "Department", e.Name "Employee", e.Salary
FROM Department d JOIN Employee e
ON d.Id = e.DepartmentId
WHERE NOT EXISTS (SELECT 1 FROM Employee e2 WHERE e2.Salary > e.Salary AND e.DepartmentId = e2.DepartmentId);

## https://dev.mysql.com/doc/refman/8.0/en/exists-and-not-exists-subqueries.html
## WHERE NOT EXISTS Only takes TRUE FALSE value.  MySQL ignores the SELECT list in such a subquery, so it makes no difference.
## We cannot use WHERE EXISTS with e.Salary > e2.Salary in this case. Why?
## Because there might be only one row. In this case, it is not higher than other values so that it will not be taken into the result.
## To take all those results, we can use WHERE NOT EXISTS and use the opposite logic.

## ---------------------------------

## Solution 2.
## Runtime: 1305 ms, faster than 9.79% of MySQL online submissions for Department Highest Salary.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Department Highest Salary.

SELECT D.Name AS Department, E.Name AS Employee, E.Salary
FROM Employee E,
     (SELECT DepartmentId,max(Salary) AS Max FROM Employee GROUP BY DepartmentId) T,
     Department D
WHERE E.DepartmentId = T.DepartmentId
AND E.Salary = T.Max
AND D.Id = T.DepartmentId;

## This creates another table indicating the highest salary in each department and link the three table together.
## This solution is slower but is the most naive one.

## ----------------------------------------------------------------

## Solution 3.
## Runtime: 644 ms, faster than 46.96% of MySQL online submissions for Department Highest Salary.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Department Highest Salary.

SELECT D.Name AS Department, E.Name AS Employee, E.Salary
FROM Employee E JOIN Department D
ON E.DepartmentId = D.Id
AND (E.DepartmentId, E.Salary) 
    IN 
    (
    SELECT DepartmentId, MAX(Salary) as Max 
    FROM Employee 
    GROUP BY DepartmentID
    );

## This result is similar to the previous one. The difference is that we did not build a temporary table for the subquery.
## Instead, we use an IN statement to check whether the employee is in that temporary table.

## --------------------------------

## Solution 4.
## Runtime: 1047 ms, faster than 16.53% of MySQL online submissions for Department Highest Salary.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Department Highest Salary.

SELECT d.Name "Department", e.Name "Employee", e.Salary
FROM Department d, Employee e
WHERE e.DepartmentId = d.Id
AND e.Salary = (
    SELECT MAX(Salary) 
    FROM Employee e2 
    WHERE e2.DepartmentId = d.Id
    );

## This result is similar to the first solution as it takes the second employee table to calculate the max salary by department Id.