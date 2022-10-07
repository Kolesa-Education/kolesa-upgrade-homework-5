-- Creating database kolesa-5
DROP DATABASE IF EXISTS `kolesa-upgrade-homework-5`;
CREATE DATABASE `kolesa-upgrade-homework-5`;

USE `kolesa-upgrade-homework-5`;

-- Task 0
-- Creating tables
CREATE TABLE Partners (
    id int NOT NULL AUTO_INCREMENT,
    title varchar(150) NOT NULL,
    description text,
    address varchar(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Positions (
    id int NOT NULL AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    description text,
    price int NOT NULL DEFAULT 0,
    photo_url varchar(255),
    partner_id int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (partner_id) REFERENCES Partners (id)
);

CREATE TABLE Clients (
    id int NOT NULL AUTO_INCREMENT,
    phone char(12),
    fullname varchar(255),
    PRIMARY KEY (id)
);

CREATE TABLE Orders (
    id int NOT NULL AUTO_INCREMENT,
    created_at datetime NOT NULL,
    address varchar(255) NOT NULL,
    latitude float NOT NULL,
    longitude float NOT NULL,
    status enum ('in_progress', 'done', 'canceled') NOT NULL DEFAULT 'in_progress',
    client_id int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (client_id) REFERENCES Clients (id)
);

CREATE TABLE OrdersPositions (
    order_id int NOT NULL,
    position_id int NOT NULL,
    PRIMARY KEY (order_id, position_id),
    FOREIGN KEY (order_id) REFERENCES Orders (id),
    FOREIGN KEY (position_id) REFERENCES Positions (id)
);

-- Task 1
-- Filling tables
INSERT INTO
    Partners (title, description, address)
VALUES
    ('KFC', 'The best fried chicken in the world', 'Moscow, Lenina 1'),
    ('Burger King', 'The best burgers in the world', 'Moscow, Lenina 3'),
    ('Pizza Hut', 'The best pizza in the world', 'Moscow, Lenina 4');

-- Filling KFC positions
INSERT INTO
    Positions (title, price, partner_id) VALUES
    ('Fried chicken', 100, (SELECT id FROM Partners WHERE title = 'KFC')),
    ('Fried chicken with potatoes', 150, (SELECT id FROM Partners WHERE title = 'KFC')),
    ('Fried chicken with potatoes and drink', 200, (SELECT id FROM Partners WHERE title = 'KFC'));

-- Filling Burger King positions
INSERT INTO
    Positions (title, price, partner_id) VALUES
    ('Burger', 100, (SELECT id FROM Partners WHERE title = 'Burger King')),
    ('Burger with potatoes', 150, (SELECT id FROM Partners WHERE title = 'Burger King')),
    ('Burger with potatoes and drink', 200, (SELECT id FROM Partners WHERE title = 'Burger King'));

-- Filling Pizza Hut positions
INSERT INTO
    Positions (title, price, partner_id) VALUES
    ('Pizza', 100, (SELECT id FROM Partners WHERE title = 'Pizza Hut')),
    ('Pizza with potatoes', 150, (SELECT id FROM Partners WHERE title = 'Pizza Hut')),
    ('Pizza with potatoes and drink', 200, (SELECT id FROM Partners WHERE title = 'Pizza Hut'));

-- Creating clients
INSERT INTO
    Clients (phone, fullname) VALUES
    ('+77075553355', 'Ivan Ivanov'),
    ('+77075556688', 'Petr Petrov'),
    ('+77075550011', 'Sidor Sidorov');

-- Create order for each client
INSERT INTO
    Orders (created_at, address, latitude, longitude, client_id) VALUES
    (NOW(), 'Kremlevskaya 1', 55.755826, 37.6173, (SELECT id FROM Clients WHERE fullname = 'Ivan Ivanov')),
    (NOW(), 'Kremlevskaya 2', 55.755826, 37.6173, (SELECT id FROM Clients WHERE fullname = 'Petr Petrov')),
    (NOW(), 'Kremlevskaya 3', 55.755826, 37.6173, (SELECT id FROM Clients WHERE fullname = 'Sidor Sidorov'));

-- Create order positions for each order
INSERT INTO
    OrdersPositions (order_id, position_id) VALUES
    ((SELECT id FROM Orders WHERE client_id = (SELECT id FROM Clients WHERE fullname = 'Ivan Ivanov')), (SELECT id FROM Positions WHERE title = 'Fried chicken with potatoes and drink')),
    ((SELECT id FROM Orders WHERE client_id = (SELECT id FROM Clients WHERE fullname = 'Petr Petrov')), (SELECT id FROM Positions WHERE title = 'Burger with potatoes and drink')),
    ((SELECT id FROM Orders WHERE client_id = (SELECT id FROM Clients WHERE fullname = 'Sidor Sidorov')), (SELECT id FROM Positions WHERE title = 'Pizza with potatoes and drink'));

-- Task 2
-- Write a query that will return order numbers (their ID), customer phone number, partner name
SELECT
    Orders.id AS order_id,
    Clients.phone AS client_phone,
    Partners.title AS partner_title
FROM
    Orders
INNER JOIN
    Clients ON Orders.client_id = Clients.id
INNER JOIN
    OrdersPositions ON Orders.id = OrdersPositions.order_id
INNER JOIN
    Positions ON OrdersPositions.position_id = Positions.id
INNER JOIN
    Partners ON Positions.partner_id = Partners.id;

-- Task 3
-- Add another partner and at least 1 position for him. But dont create orders. Write a query that will display such partners who have not had any orders yet
INSERT INTO
    Partners (title, description, address) VALUES
    ('Subway', 'The best sandwiches in the world', 'Moscow, Lenina 5');

INSERT INTO
    Positions (title, price, partner_id) VALUES
    ('Sandwich', 100, (SELECT id FROM Partners WHERE title = 'Subway'));

SELECT
    Partners.title AS partner_title
FROM
    Partners
LEFT JOIN
    Positions ON Partners.id = Positions.partner_id
LEFT JOIN
    OrdersPositions ON Positions.id = OrdersPositions.position_id
WHERE
    OrdersPositions.position_id IS NULL;

-- Task 4
-- Write a query that, based on the user ID and order ID, will output the names of all items from this order
SELECT
    Positions.title AS position_title
FROM
    Orders
INNER JOIN
    OrdersPositions ON Orders.id = OrdersPositions.order_id
INNER JOIN
    Positions ON OrdersPositions.position_id = Positions.id
WHERE
    Orders.id = 1;