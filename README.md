Library Management System

Overview
The Library Management System is a SQL-based database project designed to efficiently manage library operations. It provides functionality for managing members, books, e-books, borrowing records, fines, and book orders while ensuring data integrity through relational database concepts.

Features
- Member registration and management
- Physical book inventory management
- E-book collection management
- Borrowing and return tracking
- Automatic fine calculation for overdue books
- Book order and arrival tracking
- Stored procedures for common operations
- Complex queries using joins and subqueries
- Sample data for testing and demonstration

Database Structure
Tables
- **Members** – Stores member information
- **Books** – Stores physical book details
- **BorrowingLogs** – Tracks borrowing and return activities
- **Ebooks** – Stores digital book information
- **Current_Orders** – Tracks ordered books and arrivals

Relationships
- A member can borrow multiple books.
- A book can be borrowed by multiple members over time.
- Borrowing records are maintained through foreign key relationships.

Technologies Used
- MySQL
- SQL
- Stored Procedures
- Joins
- Subqueries
- Aggregate Functions

Stored Procedures
The project includes stored procedures for:
1. Adding new members
2. Borrowing books
3. Returning books
4. Viewing member borrowing history
5. Updating available book copies
6. Retrieving overdue books

Sample Queries
- Most borrowed books
- Total fines collected
- Members with e-book access
- Overdue books report
- Books never borrowed
- Genre-wise book statistics
- Active borrowing records

Learning Outcomes
This project demonstrates:
- Relational database design
- Primary and foreign key implementation
- Data normalization concepts
- Stored procedure development
- Query optimization using joins and subqueries
- Database management and reporting
