# Objective  
Master SQL joins by writing complex queries using different types of joins.

## Instructions  

1. **INNER JOIN:**  
   Write a query using an `INNER JOIN` to retrieve all bookings and the respective users who made those bookings.
  ### INNER JOIN: Retrieve All Bookings and the Respective Users

```sql
SELECT B.*, U.* 
FROM public."Booking" AS B
INNER JOIN public."User" AS U ON B.user_id = U.user_id
ORDER BY B.booking_id ASC;



2. **LEFT JOIN:**  
   Write a query using a `LEFT JOIN` to retrieve all properties and their reviews, including properties that have no reviews.
  ### LEFT JOIN:
  ```sql
SELECT P.* from public."Property" AS P
LEFT JOIN public."Review" AS R on P.property_id = R.property_id;

3. **FULL OUTER JOIN:**  
   Write a query using a `FULL OUTER JOIN` to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
  ### FULL OUTER JOIN:
 ```sql

SELECT B.*, U.* FROM public."Booking" AS B
FULL OUTER JOIN public."User" AS U on B.user_id = U.user_id
ORDER BY booking_id ASC;
  
