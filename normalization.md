### **Key Normalization Changes & Justifications**

---

### **1. Location Normalization**:

**Change Applied**:

* The `Location` column was removed from the `Property` table and moved to a separate `Location` table, with a foreign key reference (`location_id`) in the `Property` table.

**Justification**:

* **Redundancy Removal**: Before normalization, properties with the same location (city, state, country) would store duplicate data for each property. For example, if two properties are in the same city, storing the city, state, and country for each would lead to unnecessary duplication.
* **Data Integrity**: By isolating location information into its own table, we ensure that locations are stored once, making the database more efficient and reducing the chance of inconsistencies (e.g., multiple representations of the same location).

---

### **2. Review-Booking Link**:

**Change Applied**:

* The `Review` table now has a direct relationship with the `Booking` table, ensuring that reviews are only associated with specific bookings. This is accomplished by linking the `Review` table to the `Booking` table via a `booking_id` foreign key.

**Justification**:

* **Preventing Abuse**: Without this change, there was a risk of users leaving reviews for properties they had not booked or stayed in, leading to potential misuse. By ensuring that a review is tied to an actual booking, we maintain the integrity of the review system.
* **Ensuring Relevance**: Reviews are now only tied to completed stays, ensuring that feedback is given based on real experiences. This change encourages authenticity and trust in the review system.

