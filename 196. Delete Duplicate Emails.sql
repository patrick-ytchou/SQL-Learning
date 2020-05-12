## Success
## Runtime: 2118 ms, faster than 12.60% of MySQL online submissions for Delete Duplicate Emails.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Delete Duplicate Emails.

DELETE p1 FROM Person p1, Person p2
WHERE p1.Email = p2.Email AND p1.Id > p2.Id;

## ----------------------------------------------------------------

## Success
## Runtime: 2083 ms, faster than 15.01% of MySQL online submissions for Delete Duplicate Emails.
## Memory Usage: 0B, less than 100.00% of MySQL online submissions for Delete Duplicate Emails.

DELETE FROM Person 
WHERE Id NOT IN(
    SELECT t.Id 
    FROM(
        SELECT min(Id) AS Id 
        FROM Person 
        GROUP BY Email
) AS t);

## At first What you might want to do is the following query.

## DELETE FROM Person WHERE Id NOT IN(
## SELECT min(Id) AS Id FROM Person
## GROUP BY Email);

## Runtime Error: You cannot specify target table "Person" for update in FROM clause
## This is due to the conflict between DELETE and FROM statement on the same table PERSON
## In order to tackle this, you can use an temporary table as a copy

## In this case, "t" is the temporary table that takes the result from the clause

## ----------------------------------------------------------------

