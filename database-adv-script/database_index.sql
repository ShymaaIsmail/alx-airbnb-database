-- Index for user_id (Primary Key) - already indexed implicitly as PRIMARY KEY
-- Index for email for quick lookups
CREATE INDEX IF NOT EXISTS idx_user_email ON "User" (email);

-- Index for created_at for filtering and ordering by registration date
CREATE INDEX IF NOT EXISTS idx_user_created_at ON "User" (created_at);

-- Composite index for quick lookups by email and role
CREATE INDEX IF NOT EXISTS idx_user_email_role ON "User" (email, role);



-- Index for booking_id (Primary Key) - already indexed implicitly as PRIMARY KEY
-- Index for user_id to quickly retrieve all bookings by a user
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON "Booking" (user_id);

-- Index for property_id to quickly retrieve all bookings for a property
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON "Booking" (property_id);

-- Index for start_date to optimize date range queries
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON "Booking" (start_date);

-- Index for end_date to optimize date range queries
CREATE INDEX IF NOT EXISTS idx_booking_end_date ON "Booking" (end_date);

-- Composite index for filtering by status and date range
CREATE INDEX IF NOT EXISTS idx_booking_status_date ON "Booking" (status, start_date, end_date);

-- Index for total_price to optimize filtering/sorting based on price
CREATE INDEX IF NOT EXISTS idx_booking_total_price ON "Booking" (total_price);


-- Index for property_id (Primary Key) - already indexed implicitly as PRIMARY KEY
-- Index for host_id to quickly retrieve all properties by a host
CREATE INDEX IF NOT EXISTS idx_property_host_id ON "Property" (host_id);

-- Index for location_id to quickly retrieve properties by location
CREATE INDEX IF NOT EXISTS idx_property_location_id ON "Property" (location_id);

-- Index for pricepernight to optimize price range queries
CREATE INDEX IF NOT EXISTS idx_property_price ON "Property" (pricepernight);

-- Index for number_of_guests to quickly filter properties based on capacity
CREATE INDEX IF NOT EXISTS idx_property_guests ON "Property" (number_of_guests);

-- Index for created_at for filtering and ordering by creation date
CREATE INDEX IF NOT EXISTS idx_property_created_at ON "Property" (created_at);

-- Composite index for filtering by price and number of guests
CREATE INDEX IF NOT EXISTS idx_property_price_guests ON "Property" (pricepernight, number_of_guests);
