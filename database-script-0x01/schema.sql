-- Connect to the default database to create airbnb_db
\c postgres;

-- Create the airbnb_db database if it does not exist
CREATE DATABASE airbnb_db;

-- Connect to airbnb_db
\c airbnb_db;

-- Enable the UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Define ENUM types
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
        CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'booking_status') THEN
        CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_method') THEN
        CREATE TYPE payment_method AS ENUM ('credit_card', 'paypal', 'stripe');
    END IF;
END $$;

-- Create User table
CREATE TABLE IF NOT EXISTS "User" (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR,
    role user_role NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on email
CREATE INDEX IF NOT EXISTS idx_user_email ON "User" (email);

-- Create Location table to normalize location data
CREATE TABLE IF NOT EXISTS "Location" (
    location_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    city VARCHAR NOT NULL,
    state VARCHAR NOT NULL,
    country VARCHAR NOT NULL
);

-- Create Property table with location_id as a foreign key
CREATE TABLE IF NOT EXISTS "Property" (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID REFERENCES "User"(user_id) ON DELETE SET NULL,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location_id UUID REFERENCES "Location"(location_id) ON DELETE RESTRICT,  -- Changed to RESTRICT
    pricepernight DECIMAL NOT NULL,
    number_of_guests INTEGER NOT NULL CHECK (number_of_guests >= 1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Amenity table
CREATE TABLE IF NOT EXISTS "Amenity" (
    amenity_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR NOT NULL
);

-- Create PropertyAmenity table to link properties with amenities
CREATE TABLE IF NOT EXISTS "PropertyAmenity" (
    property_id UUID REFERENCES "Property"(property_id) ON DELETE CASCADE,
    amenity_id UUID REFERENCES "Amenity"(amenity_id) ON DELETE CASCADE,
    PRIMARY KEY (property_id, amenity_id)
);

-- Create Booking table (linked to bookings)
CREATE TABLE IF NOT EXISTS "Booking" (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    property_id UUID REFERENCES "Property"(property_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Payment table (directly linked to bookings)
CREATE TABLE IF NOT EXISTS "Payment" (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES "Booking"(booking_id) ON DELETE CASCADE,
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method NOT NULL
);

-- Create Review table with host_response column and linked to bookings
CREATE TABLE IF NOT EXISTS "Review" (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES "Booking"(booking_id) ON DELETE CASCADE,  -- Link to Booking
    property_id UUID REFERENCES "Property"(property_id) ON DELETE CASCADE,
    user_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
    comment TEXT NOT NULL,
    host_response TEXT,  -- Host's response to the review
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Message table
CREATE TABLE IF NOT EXISTS "Message" (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    recipient_id UUID REFERENCES "User"(user_id) ON DELETE CASCADE,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to update updated_at timestamp in Property table
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$ 
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP; 
    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_property_timestamp
BEFORE UPDATE ON "Property"
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
