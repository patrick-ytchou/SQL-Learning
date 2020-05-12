
## Solution 1.
## Simple and Naive Solution
## Runtime: 1567 ms, faster than 5.00% of MySQL online submissions for Nth Highest Salary.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Nth Highest Salary.

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  DECLARE M INT;
  SET M = N - 1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT IFNULL(
      (SELECT DISTINCT Salary
      FROM Employee
      ORDER By Salary DESC
      LIMIT 1 OFFSET M), NULL)
  );
END

## This soltuion dynamically reads in the N as input and set M as the OFFSET value.