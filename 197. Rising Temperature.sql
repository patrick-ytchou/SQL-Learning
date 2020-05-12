
## Success
## Runtime: 569 ms, faster than 40.27% of MySQL online submissions for Rising Temperature.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Rising Temperature.

SELECT w1.Id AS 'Id'
FROM Weather w1 JOIN Weather w2
ON DATEDIFF(w1.RecordDate, w2.RecordDate) = 1
AND w1.Temperature > w2.Temperature;


## DATEDIFF(Date1, Date2) Returns Date1 - Date2

## ----------------------------------------------------------------

## Success
## Runtime: 371 ms, faster than 84.98% of MySQL online submissions for Rising Temperature.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Rising Temperature.

SELECT w1.Id AS 'Id'
FROM Weather w1, Weather w2
WHERE SUBDATE(w1.RecordDate, 1) = w2.RecordDate 
AND w1.Temperature > w2.Temperature;

## SUBDATE(Date1, INTERVAL) Returns Date1 - TIME INTERVAL
## SUBDATE/SUBTIME is faster than pure DATEDIFF command


## Note that you should not use w1.RecordDate - 1 since subtracting treats date as number not timestamp.
SELECT DATE('2015-02-01')-1, SUBDATE(DATE('2015-02-01'),1)
## The two result above will not be the same. Use DATEDIFF or SUBDATE/SUBTIME when you want to do DATE SUBTRACTING.

## ----------------------------------------------------------------

## Success
## Runtime: 539 ms, faster than 45.71% of MySQL online submissions for Rising Temperature.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Rising Temperature.

SELECT w1.Id AS 'Id'
FROM Weather w1 JOIN Weather w2
ON TO_DAYS(w1.RecordDate) = TO_DAYS(w2.RecordDate) + 1
WHERE w1.Temperature > w2.Temperature;

## TO_DAYS() Returns the number of days between a date and year 0 (date "0000-00-00").
## This function is not so slow compare to the DATEDIFF function.