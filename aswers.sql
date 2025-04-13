-- Create the database
CREATE DATABASE BookStore;
USE BookStore;
-- Book Language
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_code CHAR(2) NOT NULL,
    language_name VARCHAR(50) NOT NULL
);

-- Publisher
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(100) NOT NULL,
    established_date DATE,
    website VARCHAR(255)
);

-- Author
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50)
);

-- Book
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publisher_id INT,
    language_id INT,
    num_pages INT,
    publication_date DATE,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Book-Author Relationship (Many-to-Many)
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
-- Country
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(50) NOT NULL,
    country_code CHAR(3) NOT NULL
);

-- Address
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street_number VARCHAR(10),
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    postal_code VARCHAR(20),
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Address Status
	CREATE TABLE address_status (
		status_id INT PRIMARY KEY AUTO_INCREMENT,
		status_value VARCHAR(20) NOT NULL
	);

-- Customer
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Customer Address
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);
-- Order Status
CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_value VARCHAR(20) NOT NULL
);

-- Shipping Method
CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    delivery_time_days INT
);

-- Customer Order
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    address_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Order Line
CREATE TABLE order_line (
    line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Order History
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
 -------------------------------------------------------------
 
 -- Insert data into book_language
INSERT INTO book_language (language_code, language_name) VALUES 
('EN', 'English'),
('FR', 'French'),
('ES', 'Spanish'),
('DE', 'German'),
('KE', 'Kenya'),
('TZ', 'Tanzania'),
('IT', 'Italian');

-- Insert data into country
INSERT INTO country (country_name, country_code) VALUES
('United States', 'USA'),
('United Kingdom', 'GBR'),
('France', 'FRA'),
('Germany', 'DEU'),
('Kenya', 'KEN'),
('Tanzania', 'TZN'),
('Spain', 'ESP');

-- Insert data into address_status
INSERT INTO address_status (status_value) VALUES
('Current'),
('Previous'),
('Billing'),
('Shipping');

-- Insert data into order_status
INSERT INTO order_status (status_value) VALUES
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled');

-- Insert data into shipping_method
INSERT INTO shipping_method (method_name, cost, delivery_time_days) VALUES
('Standard', 5.99, 5),
('Express', 12.99, 2),
('Overnight', 24.99, 1),
('International', 29.99, 7);

-- Insert data into publisher
INSERT INTO publisher (publisher_name, established_date, website) VALUES
('Penguin Random House', '2013-07-01', 'https://www.penguinrandomhouse.com/'),
('HarperCollins', '1817-03-06', 'https://www.harpercollins.com/'),
('Simon & Schuster', '1924-01-02', 'https://www.simonandschuster.com/'),
('Macmillan', '1843-11-10', 'https://us.macmillan.com/'),
('Hachette Livre', '1826-01-01', 'https://www.hachette.com/');

-- Insert data into author
INSERT INTO author (first_name, last_name, birth_date, nationality) VALUES
('George', 'Orwell', '1903-06-25', 'British'),
('J.K.', 'Rowling', '1965-07-31', 'British'),
('Stephen', 'King', '1947-09-21', 'American'),
('Agatha', 'Christie', '1890-09-15', 'British'),
('Ernest', 'Hemingway', '1899-07-21', 'American');

-- Insert data into book
INSERT INTO book (title, isbn, publisher_id, language_id, num_pages, publication_date, price, stock_quantity) VALUES
('1984', '9780451524935', 1, 1, 328, '1950-06-08', 9.99, 50),
('Animal Farm', '9780451526342', 1, 1, 112, '1945-08-17', 7.99, 35),
('Harry Potter and the Philosopher''s Stone', '9780747532743', 2, 1, 223, '1997-06-26', 12.99, 100),
('The Shining', '9780307743657', 3, 1, 447, '1977-01-28', 14.99, 30),
('Murder on the Orient Express', '9780062073501', 2, 1, 256, '1934-01-01', 10.99, 25);

-- Insert data into book_author (many-to-many relationship)
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), -- 1984 by George Orwell
(2, 1), -- Animal Farm by George Orwell
(3, 2), -- Harry Potter by J.K. Rowling
(4, 3), -- The Shining by Stephen King
(5, 4); -- Murder on the Orient Express by Agatha Christie

-- Insert data into address
INSERT INTO address (street_number, street_name, city, postal_code, country_id) VALUES
('123', 'Main Street', 'New York', '10001', 1),
('456', 'Oak Avenue', 'London', 'SW1A 1AA', 2),
('789', 'Rue de Rivoli', 'Paris', '75001', 3),
('10', 'Friedrichstraße', 'Berlin', '10117', 4),
('25', 'Gran Vía', 'Madrid', '28013', 5);

-- Insert data into customer
INSERT INTO customer (first_name, last_name, email, phone, registration_date) VALUES
('John', 'Doe', 'john.doe@example.com', '555-0101', '2023-01-15 10:30:00'),
('Jane', 'Smith', 'jane.smith@example.com', '555-0202', '2023-02-20 14:45:00'),
('Robert', 'Johnson', 'robert.j@example.com', '555-0303', '2023-03-05 09:15:00'),
('Emily', 'Davis', 'emily.d@example.com', '555-0404', '2023-04-10 16:20:00'),
('Michael', 'Brown', 'michael.b@example.com', '555-0505', '2023-05-25 11:00:00');

-- Insert data into customer_address
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1), -- John Doe's current address
(1, 2, 3), -- John Doe's billing address
(2, 3, 1), -- Jane Smith's current address
(3, 4, 1), -- Robert Johnson's current address
(4, 5, 1); -- Emily Davis's current address

-- Insert data into cust_order
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, address_id) VALUES
(1, '2023-06-01 09:30:00', 1, 1),
(2, '2023-06-02 14:15:00', 2, 3),
(3, '2023-06-03 11:20:00', 3, 4),
(4, '2023-06-04 16:45:00', 1, 5),
(1, '2023-06-05 10:10:00', 2, 2);

-- Insert data into order_line
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 1, 9.99),  -- Order 1: 1984
(1, 3, 2, 12.99), -- Order 1: Harry Potter (2 copies)
(2, 2, 1, 7.99),  -- Order 2: Animal Farm
(3, 4, 1, 14.99), -- Order 3: The Shining
(4, 5, 3, 10.99), -- Order 4: Murder on the Orient Express (3 copies)
(5, 1, 1, 9.99);  -- Order 5: 1984

-- Insert data into order_history
INSERT INTO order_history (order_id, status_id, status_date) VALUES
(1, 1, '2023-06-01 09:30:00'), -- Pending
(1, 2, '2023-06-01 12:45:00'), -- Processing
(1, 3, '2023-06-02 10:15:00'), -- Shipped
(1, 4, '2023-06-05 14:30:00'), -- Delivered
(2, 1, '2023-06-02 14:15:00'), -- Pending
(2, 2, '2023-06-02 16:20:00'), -- Processing
(3, 1, '2023-06-03 11:20:00'), -- Pending
(4, 1, '2023-06-04 16:45:00'), -- Pending
(5, 1, '2023-06-05 10:10:00'); -- Pending


