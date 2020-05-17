## Description
X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, visit_date, people

Please write a query to display the records which have 3 or more consecutive rows and the amount of people more than 100(inclusive).

## Solution 1.

SELECT DISTINCT s1.*
FROM stadium s1, stadium s2, stadium s3
WHERE s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100
AND ((s1.id = s2.id -1 AND s1.id = s3.id - 2) -- start of window (if three consecutive is detected and only this condition is set, only the first row will be returned)
     OR (s1.id = s2.id + 1 AND s1.id = s3.id -1) -- middle of the window (with this condition the middle value will be returned)
     OR (s1.id = s2.id + 2 AND s1.id = s3.id +1 )) -- end of the window (with this the last value)
ORDER BY s1.id;

## ------------------------------

## Solution 2.
## Move one part of the where clause up to limit the total number of records being pulled from the databases.

SELECT DISTINCT s1.*
FROM 
    (SELECT * FROM stadium WHERE people >= 100) AS s1,
    (SELECT * FROM stadium WHERE people >= 100) AS s2,
    (SELECT * FROM stadium WHERE people >= 100) AS s3
WHERE (s1.id = s2.id -1 AND s1.id = s3.id - 2)
     OR (s1.id = s2.id + 1 AND s1.id = s3.id -1)
     OR (s1.id = s2.id + 2 AND s1.id = s3.id +1 )
ORDER BY s1.id;

## ------------------------------

## Solution 3.
## Joining instead of juxtaposing

SELECT DISTINCT s1.*
FROM stadium s1
LEFT JOIN stadium s2
    ON s1.people >= 100
    AND s2.people >= 100
LEFT JOIN stadium s3
    ON s3.people >= 100
WHERE (s1.id = s2.id -1 AND s1.id = s3.id - 2)
     OR (s1.id = s2.id + 1 AND s1.id = s3.id -1)
     OR (s1.id = s2.id + 2 AND s1.id = s3.id +1 )
ORDER BY s1.id;