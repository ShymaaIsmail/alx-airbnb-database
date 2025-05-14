
# Objective  
Write both correlated and non-correlated subqueries.

---

## Instructions  

1. **Non-Correlated Subquery:**  
   - Write a query to find all properties where the average rating is greater than `4.0` using a subquery.
  ```sql
      SELECT property.* FROM public."Property" AS property
    WHERE property.property_id IN (
    SELECT P.property_id FROM public."Property" AS P
    JOIN public."Review" AS R on P.property_id = R.property_id
    GROUP BY P.property_id
    HAVING AVG(R.rating) > 4.0
    );

2. **Correlated Subquery:**  
   - Write a correlated subquery to find users who have made more than `3` bookings.
```
  SELECT U.* FROM public."User" AS U
  WHERE 3 < (SELECT COUNT(*)
  FROM public."Booking" AS B
  WHERE B.user_id = U.user_id
  )
