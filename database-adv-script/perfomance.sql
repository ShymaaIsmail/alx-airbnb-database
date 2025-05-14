# Objective: Refactor Complex Queries to Improve Performance

## Instructions:

1. **Write the Initial Query:**
   - Retrieve all bookings along with user details, property details, and payment details.
   ```sql
  
      SELECT * FROM
      public."Booking" AS B
      INNER JOIN 
      public."User" AS U
      ON B.user_id = U.user_id
      INNER JOIN
      public."Property" AS P
      ON B.property_id = P.property_id
      INNER JOIN
      public."Payment" AS PY
      on B.booking_id = PY.booking_id
      WHERE U.role = 'guest' AND PY.payment_method = 'credit_card'


2. **Analyze Query Performance:**
   - Use the `EXPLAIN` statement to assess the query's execution plan.
   - Identify any inefficiencies, such as unnecessary joins or missing indexes.
  OUTPUT: 
  "Hash Join  (cost=3.44..24.39 rows=780 width=528) (actual time=10.479..10.488 rows=2 loops=1)"
"  Hash Cond: (py.booking_id = b.booking_id)"
"  ->  Seq Scan on ""Payment"" py  (cost=0.00..17.80 rows=780 width=76) (actual time=0.162..0.164 rows=2 loops=1)"
"  ->  Hash  (cost=3.36..3.36 rows=6 width=452) (actual time=9.100..9.104 rows=5 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 10kB"
"        ->  Hash Join  (cost=2.25..3.36 rows=6 width=452) (actual time=9.073..9.088 rows=5 loops=1)"
"              Hash Cond: (b.property_id = p.property_id)"
"              ->  Hash Join  (cost=1.14..2.22 rows=6 width=288) (actual time=1.642..1.651 rows=5 loops=1)"
"                    Hash Cond: (b.user_id = u.user_id)"
"                    ->  Seq Scan on ""Booking"" b  (cost=0.00..1.06 rows=6 width=100) (actual time=0.009..0.011 rows=6 loops=1)"
"                    ->  Hash  (cost=1.06..1.06 rows=6 width=188) (actual time=0.096..0.097 rows=6 loops=1)"
"                          Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                          ->  Seq Scan on ""User"" u  (cost=0.00..1.06 rows=6 width=188) (actual time=0.035..0.038 rows=6 loops=1)"
"              ->  Hash  (cost=1.05..1.05 rows=5 width=164) (actual time=0.041..0.042 rows=5 loops=1)"
"                    Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"                    ->  Seq Scan on ""Property"" p  (cost=0.00..1.05 rows=5 width=164) (actual time=0.026..0.029 rows=5 loops=1)"
"Planning Time: 0.754 ms"
"Execution Time: 10.599 ms"

3. **Refactor the Query:**
   - Optimize the query to reduce execution time.
   - Implement indexing, reduce joins, or use subqueries where necessary.
   Refactored Query:
  ```sql

    SELECT 
        B.booking_id, 
        B.created_at, 
        B.status, 
        U.user_id, 
        U.email, 
        P.property_id, 
        P.name AS property_name, 
        PY.payment_id, 
        PY.amount, 
        PY.payment_date
    FROM public."Booking" AS B
    INNER JOIN public."User" AS U ON B.user_id = U.user_id
    INNER JOIN public."Property" AS P ON B.property_id = P.property_id
    INNER JOIN public."Payment" AS PY ON B.booking_id = PY.booking_id
   WHERE U.role = 'guest' AND PY.payment_method = 'credit_card';

    
