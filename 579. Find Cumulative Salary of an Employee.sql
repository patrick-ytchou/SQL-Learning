## Description

The Employee table holds the salary information in a year.

Write a SQL to get the cumulative sum of an employee salary over a period of 3 months but exclude the most recent month.

The result should be displayed by 'Id' ascending, and then by 'Month' descending.

## Solution 1.

SELECT e.Id,
       e.Month,
       IFNULL(e.Salary,0) + IFNULL(e2.Salary,0) + IFNULL(e3.Salary,0) AS "Salary"
FROM Employee e
LEFT JOIN Employee e2 ON e.id = e2.id AND e.Month = e2.Month+1
LEFT JOIN Employee e3 ON e.id = e3.id AND e.Month = e3.Month+2 
WHERE (e.Id, e.Month) NOT IN (
    SELECT Id, MAX(Month) AS "Month"
    FROM Employee
    GROUP BY Id
)
ORDER BY e.Id ASC, e.Month DESC;

## The naive way to exclude the most recent month is the exclude the MAX month by setting the WHERE condition.
## One important thing is to keep in mind the Null Value. 

## ------------------------------

## Solution 2.
## Non-equijoin
SELECT e.Id,
       e.Month,
       IFNULL(e.Salary,0) + IFNULL(e2.Salary,0) + IFNULL(e3.Salary,0) AS "Salary"
FROM (
    SELECT Id, MAX(Month) AS "Max_month"
    FROM Employee
    GROUP BY Id) AS recent
JOIN Employee e ON recent.Id = e.Id AND recent.Max_Month > e.Month
LEFT JOIN Employee e2 ON e.Id = e2.Id AND e.Month = e2.Month + 1
LEFT JOIN Employee e3 ON e.Id = e3.Id AND e.Month = e3.Month + 2
ORDER BY e.Id ASC, e.Month DESC;

## The filtering where clause is moved up in the from clause and serve as a temporary table.
## The first JOIN is a INNER JOIN since we need to have at least two month records in order to be tracked. LEFT JOIN is not what we want.

## ------------------------------

## Solution 3.
## Exclude the most recent month my explicitely not joining on those months

SELECT e1.Id,
       MAX(e2.Month) AS "Month",
       SUM(e2.Salary) AS "Salary"
FROM Employee e1
JOIN Employee e2
    ON e1.Id = e2.Id
    AND e1.Month - e2.Month BETWEEN 1 AND 3
GROUP BY e1.Id, e1.Month
ORDER BY e.Id ASC, e.Month DESC;

## The SUM() function ignores NULL value automatically so we do not need to use the IFNULL function here.