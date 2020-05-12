** Note that the Ids are not guaranteed to be consecutive. 


## Solution 1. 
## Brilliant User-Defined Variables Solution
## Runtime: 522 ms, faster than 51.80% of MySQL online submissions for Consecutive Numbers.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Consecutive Numbers.

SELECT DISTINCT Num AS 'ConsecutiveNums' FROM(
SELECT Num, 
    CASE
        WHEN @record = Num THEN @count:= @count+1
        WHEN @record <> @record:=Num THEN @count :=1 END 
        AS ConsecutiveNums
    FROM 
        Logs, (SELECT @count:=0, @record:=(SELECT Num FROM Logs LIMIT 0,1)) r
) a
WHERE a.ConsecutiveNums >= 3;

SELECT @count:=0, @record:=(SELECT Num FROM Logs LIMIT 0,1)
## In this subquery, the variable count is set to be zero, and the variable record is set to be the first value in the Num column.
## Since this table is set, these values are fed into the CASE statement above so that those values can accumulate and detect.
## This subquery is, therefore, an extremely important initialization process.

## This method works by moving downward and storing uniquely seen values in the memory.

## ----------------------------------------------------------------

## Solution 2.
## Runtime: 660 ms, faster than 31.82% of MySQL online submissions for Consecutive Numbers.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Consecutive Numbers.

SELECT DISTINCT Num AS 'ConsecutiveNums'
FROM Logs
WHERE (Id + 1, Num) IN (SELECT * FROM Logs) 
AND (ID + 2, NUM) IN (SELECT * FROM Logs);

## This method works by naively checking whether there are three consecutive Ids with the same number.
 

## ----------------------------------------------------------------

## Solution 3.
## Runtime: 1705 ms, faster than 5.02% of MySQL online submissions for Consecutive Numbers.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Consecutive Numbers.

SELECT DISTINCT(a.Num) AS "ConsecutiveNums"
FROM Logs a, Logs b, Logs c
WHERE a.Id = b.Id + 1 AND a.Num = b.Num
AND b.Id = c.Id + 1 AND b.Num = c.Num
AND a.Id = c.Id + 2;


## This solution simply checks whether the numbers are the same and the Ids are consecutive.


## ----------------------------------------------------------------

## Solution 4.
## Fastest Result thus far! Window solution.
## Runtime: 478 ms, faster than 60.30% of MySQL online submissions for Consecutive Numbers.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Consecutive Numbers.

SELECT DISTINCT t.Num AS "ConsecutiveNums"
FROM (
SELECT Id, Num,
    LAG(Num, 1) OVER (ORDER BY Id) 'before',
    LEAD(Num, 1) OVER (ORDER BY Id) 'after'
FROM Logs
) t
WHERE t.Num = t.before AND t.before = t.after;

## This solution works my using the LAG() and LEAD() function.
## The LAG() and LEAD() function are window functions that allows you to look back / in front of a number of rows and access data of that row from the current row.
## In this example, we take the Num value of the previous and the subsequent row. If those three values are the same, this is the result we want.