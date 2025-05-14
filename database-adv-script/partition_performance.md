
### ✅ **Testing Performance:**

* **Before Partitioning:**

  * Run a query on the original `Booking` table without partitioning.
  * Observe the query plan and execution time using `EXPLAIN ANALYZE`.

* **After Partitioning:**

  * Run the same query on the partitioned table.
  * Observe that the query planner should scan only the relevant partition (e.g., `Booking_2024`) instead of the entire table.

---

### ✅ **Report on Observed Improvements:**

* **Query Execution Time:**

  * Queries targeting specific date ranges execute faster because only the relevant partition(s) are scanned.

* **Reduced I/O and Memory Usage:**

  * The query planner avoids scanning unnecessary data, reducing disk I/O and memory usage.

* **Optimized Index Usage:**

  * Indexes are applied at the partition level, allowing for more focused index scans.

### `EXPLAIN ANALYZE` output:
"Bitmap Heap Scan on ""Booking_2024"" ""Booking_test""  (cost=4.17..9.51 rows=2 width=138) (actual time=0.089..0.092 rows=2 loops=1)"
"  Recheck Cond: ((start_date >= '2024-06-01'::date) AND (start_date <= '2024-12-31'::date))"
"  Heap Blocks: exact=1"
"  ->  Bitmap Index Scan on idx_booking_2024_start_date  (cost=0.00..4.17 rows=2 width=0) (actual time=0.022..0.023 rows=2 loops=1)"
"        Index Cond: ((start_date >= '2024-06-01'::date) AND (start_date <= '2024-12-31'::date))"
"Planning Time: 0.334 ms"
"Execution Time: 0.172 ms"
