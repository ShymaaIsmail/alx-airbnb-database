

-- 1. Insert Data into Location Table (Saudi Arabian Locations)
INSERT INTO "Location" (city, state, country)
VALUES
    ('Riyadh', 'Riyadh Province', 'Saudi Arabia'),
    ('Jeddah', 'Makkah Province', 'Saudi Arabia'),
    ('Mecca', 'Makkah Province', 'Saudi Arabia'),
    ('Medina', 'Medina Province', 'Saudi Arabia');

-- 2. Insert Data into User Table (Muslim Names)
INSERT INTO "User" (first_name, last_name, email, password_hash, phone_number, role)
VALUES
    ('Ahmed', 'Al-Farsi', 'ahmedalfarsi@example.com', 'hashed_password_1', '050-1234567', 'guest'),
    ('Fatimah', 'Al-Mahmood', 'fatimahalmahmood@example.com', 'hashed_password_2', '050-7654321', 'guest'),
    ('Ali', 'Al-Harbi', 'alialharbi@example.com', 'hashed_password_3', '050-9876543', 'host'),
    ('Aisha', 'Al-Shahrani', 'aishaalshahrani@example.com', 'hashed_password_4', '050-6549870', 'host'),
    ('Omar', 'Al-Mansoori', 'omarmansoori@example.com', 'hashed_password_5', '050-0000000', 'admin');

-- 3. Insert Data into Property Table
INSERT INTO "Property" (host_id, name, description, location_id, pricepernight, number_of_guests)
VALUES
    ((SELECT user_id FROM "User" WHERE first_name = 'Ali'), 'Luxury Villa in Riyadh', 'A spacious luxury villa in the heart of Riyadh', (SELECT location_id FROM "Location" WHERE city = 'Riyadh'), 1000.00, 6),
    ((SELECT user_id FROM "User" WHERE first_name = 'Aisha'), 'Cozy Apartment in Jeddah', 'A modern apartment located in the vibrant city of Jeddah', (SELECT location_id FROM "Location" WHERE city = 'Jeddah'), 500.00, 4),
    ((SELECT user_id FROM "User" WHERE first_name = 'Ali'), 'Beachfront Villa in Jeddah', 'A beautiful beachfront villa with sea views in Jeddah', (SELECT location_id FROM "Location" WHERE city = 'Jeddah'), 1500.00, 8),
    ((SELECT user_id FROM "User" WHERE first_name = 'Aisha'), 'Modern Studio in Mecca', 'A stylish and compact studio near the Haram in Mecca', (SELECT location_id FROM "Location" WHERE city = 'Mecca'), 700.00, 2);

-- 4. Insert Data into Booking Table
INSERT INTO "Booking" (property_id, user_id, start_date, end_date, total_price, status)
VALUES
    ((SELECT property_id FROM "Property" WHERE name = 'Luxury Villa in Riyadh'), (SELECT user_id FROM "User" WHERE first_name = 'Ahmed'), '2025-06-01', '2025-06-07', 6000.00, 'confirmed'),
    ((SELECT property_id FROM "Property" WHERE name = 'Cozy Apartment in Jeddah'), (SELECT user_id FROM "User" WHERE first_name = 'Fatimah'), '2025-06-10', '2025-06-12', 1000.00, 'pending'),
    ((SELECT property_id FROM "Property" WHERE name = 'Beachfront Villa in Jeddah'), (SELECT user_id FROM "User" WHERE first_name = 'Ali'), '2025-06-20', '2025-06-25', 7500.00, 'confirmed'),
    ((SELECT property_id FROM "Property" WHERE name = 'Modern Studio in Mecca'), (SELECT user_id FROM "User" WHERE first_name = 'Fatimah'), '2025-07-01', '2025-07-03', 1400.00, 'canceled');

-- 5. Insert Data into Payment Table
INSERT INTO "Payment" (booking_id, amount, payment_method)
VALUES
    ((SELECT booking_id FROM "Booking" WHERE property_id = (SELECT property_id FROM "Property" WHERE name = 'Luxury Villa in Riyadh')), 6000.00, 'credit_card'),
    ((SELECT booking_id FROM "Booking" WHERE property_id = (SELECT property_id FROM "Property" WHERE name = 'Cozy Apartment in Jeddah')), 1000.00, 'paypal'),
    ((SELECT booking_id FROM "Booking" WHERE property_id = (SELECT property_id FROM "Property" WHERE name = 'Beachfront Villa in Jeddah')), 7500.00, 'stripe');

-- 6. Insert Data into Review Table
INSERT INTO "Review" (property_id, user_id, rating, comment)
VALUES
    ((SELECT property_id FROM "Property" WHERE name = 'Luxury Villa in Riyadh'), (SELECT user_id FROM "User" WHERE first_name = 'Ahmed'), 5, 'Amazing experience, the villa is perfect!'),
    ((SELECT property_id FROM "Property" WHERE name = 'Cozy Apartment in Jeddah'), (SELECT user_id FROM "User" WHERE first_name = 'Fatimah'), 4, 'Very nice apartment, great location!'),
    ((SELECT property_id FROM "Property" WHERE name = 'Beachfront Villa in Jeddah'), (SELECT user_id FROM "User" WHERE first_name = 'Ali'), 5, 'Excellent property, wonderful sea views!'),
    ((SELECT property_id FROM "Property" WHERE name = 'Modern Studio in Mecca'), (SELECT user_id FROM "User" WHERE first_name = 'Fatimah'), 3, 'Nice but smaller than expected.');

-- 7. Insert Data into Message Table
INSERT INTO "Message" (sender_id, recipient_id, message_body)
VALUES
    ((SELECT user_id FROM "User" WHERE first_name = 'Ali'), (SELECT user_id FROM "User" WHERE first_name = 'Aisha'), 'Hi Aisha, I am interested in booking your villa in Riyadh. Could you tell me more about the facilities?'),
    ((SELECT user_id FROM "User" WHERE first_name = 'Aisha'), (SELECT user_id FROM "User" WHERE first_name = 'Ali'), 'Hi Ali, the villa has a private pool and a gym. Let me know if you need more details!');
