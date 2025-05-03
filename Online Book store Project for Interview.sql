drop table if exists Books

Create Table Books(
	Book_ID	serial Primary key,
	Title varchar(100),
	Author varchar(100),
	Genre varchar(100),
	Published_Year int,
	Price Numeric (10,2),
	Stock int
	);

Select * from Books

Create Table Customers (
	Customer_ID serial primary key,
	Name varchar(100),
	Email varchar(100),
	Phone varchar(100),
	City varchar(50),
	Country Varchar(150)
	);

select * from Customers	

Create Table Orders (
	Order_ID serial primary key,
	Customer_ID int references Customers(Customer_ID),
	Book_ID int references Books(Book_ID),
	Order_Date date,
	Quantity int,
	Total_Amount Numeric(10,2)
	);

select * from orders	

-- Import data into Books table

Copy Books(Book_ID,	Title, Author, Genre, Published_Year, Price, Stock)
From 'D:\Coursess\SQL (OneShot) Course\SQL_Resume_Project-main\Books.csv'
CSV HEADER;

-- Import Data into Coustomers Table 

Copy Customers(Customer_ID, Name, Email, Phone, City, Country)
From 'D:\Coursess\SQL (OneShot) Course\SQL_Resume_Project-main\Customers.csv'
CSV HEADER;

-- Import Data into Orders Table 

Copy Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
From 'D:\Coursess\SQL (OneShot) Course\SQL_Resume_Project-main\Orders.csv'
CSV HEADER;

-- Retrieve all books in the "Fiction" genre

select * from books
where Genre='Fiction';

-- Find books published after the year 1950

select * from books 
where Published_Year>1950;

-- List all customers from the Canada

select * from Customers
where Country='Canada';

-- Show orders placed in November 2023

select * from orders
where Order_Date between '2023-11-01' and '2023-11-30';

-- Retrieve the total stock of books available

select sum(Stock) as Total_Stock
From Books;

-- Find the details of the most expensive book

select * from Books
order by Price desc
limit 1;

-- Show all customers who ordered more than 1 quantity of a book

select * from Orders
where Quantity>1;

-- Retrieve all orders where the total amount exceeds $20

select * from orders
where Total_Amount>20;

-- List all genres available in the Books table

select distinct Genre from Books;

-- Find the book with the lowest stock

select * from Books
order by Stock 
limit 1;

-- Calculate the total revenue generated from all orders

select sum(Total_Amount) as Revenue
from Orders;


-- ADVANCE QUESTIONS --

-- Retrieve the total number of books sold for each genre

select * From Books

select b.Genre, SUM(o.Quantity) as Total_Book_Sold
from Orders o Join Books b
on o.book_id = b.book_id
group by b.Genre;


-- Find the average price of books in the "Fantasy" genre

select avg(price) as avg_price
from books
where Genre = 'Fantasy';


-- List customers who have placed at least 2 orders
select * from orders

select Customer_Id, count(Order_ID) as Order_Count
from Orders
Group by Customer_ID
having Count(Order_ID) >=2;

-- with name 
select o.Customer_Id, c.Name, count(o.Order_ID) as Order_Count
from Orders o 
join Customers c
on o.Customer_Id = c.Customer_Id
Group by o.Customer_ID, c.name
having Count(Order_ID) >=2;


-- Find the most frequently ordered book

select * from Orders

select Book_id, count(Order_id) as Order_count
from Orders
Group by book_id
Order by Order_Count desc
limit 1;

-- With name 

select o.Book_id, b.Title, count(o.Order_id) as Order_count
from Orders o
join Books b
on o.Book_id = b.Book_id
Group by o.book_id, b.title
Order by Order_Count desc
limit 1;

-- Show the top 3 most expensive books of 'Fantasy' Genre

select * from books
where Genre = 'Fantasy'
order by price desc 
limit 3;

-- Retrieve the total quantity of books sold by each author

select b.Author, Sum(o.Quantity) as Total_Book_sold 
from Orders o 
join Books b
on o.Book_Id = b.Book_Id
Group by b.Author;

-- List the cities where customers who spent over $30 are located

select distinct c.city, total_amount
from Orders o join Customers C
on o.customer_id = c.customer_id
where o.total_amount >30;

-- Find the customer who spent the most on orders

select c.customer_id, c.name, sum(o.total_amount) as total_spent
from Orders o
join Customers c
on o.customer_id = c.customer_id
group by c.customer_id, c.name
order by total_spent desc;

-- Calculate the stock remaining after fulfilling all orders

select b.book_id, b.title, b.stock, coalesce(sum(o.quantity),0) as Order_quantity,
	b.stock- coalesce(sum(o.quantity),0) as Remaining_quantity
from Books b
left join Orders o
on b.book_id = o.book_id
group by b.book_id
order by b.book_id;

