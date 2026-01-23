# Project_Scenario

## Stage 1 - Setting up a working environment 
- Creating a database [X]
- Creating a GitHub repositoriu [X]
- Installing all necessary extensions [X]
    Beginning of the project was to create a cloud database using AWS services (free account).
    I have installed a program DBeaver to upload tables downloaded from Kaggle to my database. I had to learn how to operate DBeaver, how to upload tables, how to connect DBeaver to AWS Database etc. 
    Then, I decided that I will operate on VSCode (as I enjoy using that tool, and it is also working very well with GitHub Repo) - I installed a PostgreSQL extension to connect to AWS Database, and be able to write a querry and run it directly.

## Stage 2: Data cleaning and formatting.
[Primary Key code](/sql/01_add_primary_keys.sql)
[Foreign Key code](/sql/02_add_foreign_keys.sql)
[ERD Diagram](/docs/Diagram_ERD.png)
    I have checked every columns in every table to see if the data is formatted properly (DATE/DATETIME on date columns, INT on number columns, VARCHAR on text columns).
    I created a PRIMARY KEYS and relations (FOREIGN KEYS) between tables:

## Stage 3: Basic Queries
[SQL Code](/sql/03_basic_queries.sql)
- Query 1: Showing all clients with their contact details.
- Query 2: Showing all orders with data and a value (summary with Order_Items).
- Query 3: Showing all products within a specified price range.
- Query 4: Show the review for a specific product.

## Stage 4: Intermediate Queries
[SQL Code](/sql/04_intermediate_queries.sql)
- Query 1: A list of products with sold value and summarized income
- Query 2: Average and Maximum order value per client
- Query 3: Delayed orders (comparing order date and shipping date)
- Query 4: Best selling items within last month

## Stage 5: Advanced Queries
[SQL Code](/sql/05_advanced_queries.sql)
- Query 1: RFM Analyse
- Query 2: Suppliers rank based on delivery amount and average delivery time
- Query 3: Products with the worst reviews, which generates the biggest income
- Query 4: Monthly/Quarter sales trend
- Query 5: Number of orders per customer each month with a ranking of top customers.