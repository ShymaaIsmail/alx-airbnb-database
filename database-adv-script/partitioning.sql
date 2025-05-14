-- partitioning.sql

-- Step 1: Create the parent table with partitioning enabled
CREATE TABLE public."Booking_test" (
    booking_id SERIAL NOT NULL,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
	PRIMARY KEY (booking_id, start_date)  -- Composite primary key
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions based on the start_date
CREATE TABLE public."Booking_2024" PARTITION OF public."Booking_test"
FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');

CREATE TABLE public."Booking_2025" PARTITION OF public."Booking_test"
FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');

-- Step 3: Create indexes on partitions
CREATE INDEX idx_booking_2024_start_date ON public."Booking_2024" (start_date);
CREATE INDEX idx_booking_2025_start_date ON public."Booking_2025" (start_date);

-- Step 4: Test Query on Partitioned Table
EXPLAIN ANALYZE
SELECT * 
FROM public."Booking_test"
WHERE start_date BETWEEN '2024-06-01' AND '2024-12-31';
