# Objective  
Use SQL aggregation and window functions to analyze data.

---

## Instructions  

1. **Aggregation with COUNT and GROUP BY:**  
   - Write a query to find the total number of bookings made by each user using the `COUNT` function and `GROUP BY` clause.
  ```sql
      SELECT U.user_id, COUNT(B.*) AS total_number_of_bookings
    FROM public."Booking" AS B
    INNER JOIN public."User" AS U
    on B.user_id = U.user_id
    GROUP BY U.user_id

2. **Window Functions:**  
   - Use a window function (`ROW_NUMBER`, `RANK`) to rank properties based on the total number of bookings they have received.
  ```sql
    SELECT P.property_id, COUNT(B.*) AS "total_bookings",
	ROW_NUMBER() OVER (ORDER BY COUNT(B.booking_id) DESC) AS row_number,
	RANK () OVER (
		ORDER BY  COUNT(B.booking_id) DESC
	) rank_number
    FROM public."Booking" AS B
    INNER JOIN public."Property" AS P
    ON B.property_id = P.property_id
    GROUP BY P.property_id
