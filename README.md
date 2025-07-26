# 📘 LIBRARY MANAGEMENT SYSTEM
Objective: Digitize and manage book inventory, member registration, and loan tracking for a library.

## 📁Project Structure
🔹 1. Database Schema
Authors: Stores author information.

Books: Stores book details and copies.

Members: Stores registered users.

Loans: Tracks book borrow and return.
(Optional) BookAuthors: Handles many-to-many relationships if a book has multiple authors.

🔹 2. Views
BorrowedBooks: Shows currently borrowed books.

OverdueBooks: Displays overdue books and delays.

🔹 3. Triggers
Simulates overdue notifications by logging into a Notifications table.

🔹 4. Reports
SQL queries to show borrowed books, overdue items, popular books, and loan activity.

🔹 5. SQL Files
schema.sql — Tables and constraints.

sample_data.sql — Test data.

views_and_triggers.sql — Views and triggers.

report_queries.sql — Ready-to-run report queries.




# ✨ Key Features
Feature	Description
📚 Book Management	Add/update books, genres, and copies
👤 Member Management	Register and track library users
📖 Loan Tracking	Track borrow/return dates
⏰ Overdue Reporting	Detect and report overdue loans
🔍 Reports & Queries	Loan stats, top borrowers, book availability
👁️ Views	Simplified, pre-defined data summaries
🔔 Trigger Simulation	Logs due-date violations (future notification support)

# 🧠 SQL Highlights
✅ Normalization: Tables are normalized (1NF–3NF)

🔑 Primary & Foreign Keys: Ensures data consistency

⚙️ Views: Reusable virtual tables (OverdueBooks, BorrowedBooks)

🧪 Test Data: Sample data for quick prototyping

🔁 Triggers: Alert simulation for overdue loans

🧾 Aggregations & Joins: Generate business reports

⏱️ Date Functions: CURDATE(), DATEDIFF() for overdue logic

# 🛠️ How to Use
Step 1: Import Project
Open MySQL Workbench

Create a new schema (e.g., library_db)

Run schema.sql to create tables

Run sample_data.sql to populate test data

Step 2: Explore the Database
Use the Views to see borrowed or overdue books

Run the report queries for insights

Step 3: Add Your Own Data
Insert new books, members, and simulate loans

Step 4: Extend Features
Add more columns or tables as needed (e.g., categories, fines)

# 🚀 Future Improvements
Feature	Description
     💬 Email Notifications	Integrate with a mail server to send overdue alerts
     💸 Fine Tracking	Add fines for late returns and payment history
     📊 Dashboard UI	Build a web or desktop frontend
     🔐 User Roles	Admin vs Member privileges
     📈 Analytics	Loan trends, popular genres, inactive users
     📱 Mobile App Sync	Interface with mobile apps for real-time tracking
