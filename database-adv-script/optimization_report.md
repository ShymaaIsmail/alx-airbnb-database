
### 1. **Use Explicit Column Selection (Avoid `SELECT *`):**

* **Before:** You used `SELECT *`, which retrieves all columns from all tables, leading to unnecessary data being fetched.
* **After:** You selected only the necessary columns, reducing the size of the result set and improving performance by reducing memory usage and I/O overhead.

### 2. **Create Explicit Indexes:**

* **Before:** The query was potentially using inefficient sequential scans because it was not utilizing indexes effectively.
* **After:** You added explicit indexes on the foreign keys and primary keys (e.g., `booking_id`, `user_id`, `property_id`, and `payment.booking_id`).
* **Result:** This helped the database use the indexes to perform faster lookups instead of full table scans.

### 3. **Analyze Execution Plans Using `EXPLAIN ANALYZE`:**

* **Before:** You observed that the query was using sequential scans and hash joins, leading to longer execution times.
* **After:** By running `EXPLAIN ANALYZE`, you identified inefficient operations (like unnecessary hash joins and sequential scans) and confirmed that indexes were not being used optimally.
* **Result:** The execution plan showed improved performance after indexing.

### 4. **Avoid Redundant Indexes on Primary Keys:**

* **Before:** You created explicit indexes on primary keys, which led to redundancy because primary keys already have implicit indexes.
* **After:** You removed the redundant explicit indexes, allowing PostgreSQL to use the primary key indexes effectively.
* **Result:** This prevented unnecessary index usage and ensured the query planner used the optimal index.

### 5. **Final Performance Gains:**

* **Before:** The query execution time was higher (around 10 ms).
* **After:** After selecting specific columns and removing redundant indexes, the execution time dropped significantly to around 1.7 ms.
* **Result:** The query is now more efficient, with improved execution time and reduced resource usage.

---

### **Summary of Key Performance Improvements:**

* **Column selection optimization:** Reducing the columns fetched.
* **Indexing optimization:** Ensuring indexes are used on foreign keys and avoiding redundant indexes on primary keys.
* **Execution plan analysis:** Ensuring the query planner uses the most efficient execution plan, with the correct indexes.
