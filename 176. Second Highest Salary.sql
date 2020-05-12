
## Solution 1.
## Runtime: 266 ms, faster than 40.45% of MySQL online submissions for Second Highest Salary.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Second Highest Salary.

SELECT IFNULL(
    (SELECT DISTINCT Salary
    FROM Employee
    ORDER BY Salary DESC
    LIMIT 1, 1) ,NULL) AS SecondHighestSalary;

## LIMIT 1, 1 indicates LIMIT 1 OFFSET 1

## ----------------------------------------------------------------

## Solution 2. (Special solution)
## Runtime: 279 ms, faster than 36.82% of MySQL online submissions for Second Highest Salary.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Second Highest Salary.

SELECT MAX(Salary) AS "SecondHighestSalary"
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee);

## The subquery will execute first. Therefore, the MAX(Salary) in the SELECT statement will only return the second highest salary.
## Using MAX() will return a NULL if the value does not exist. Therefore, you do not need to handle the NULL situation.

## ----------------------------------------------------------------

## Solution 3.
## Runtime: 455 ms, faster than 10.18% of MySQL online submissions for Second Highest Salary.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Second Highest Salary.

SELECT (CASE
        WHEN (SELECT COUNT(DISTINCT Salary) FROM Employee) < 2
        THEN NULL
        ELSE (SELECT Salary FROM Employee
             ORDER By Salary DESC LIMIT 1,1)
        END) AS "SecondHighestSalary";

## Use CASE statement to handle to NULL situation. 
## If there are enough "DISTINCT Salary", turn to the ELSE clause which is similar to the first solutuon.
