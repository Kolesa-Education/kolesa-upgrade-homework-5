-- Напишите скрипт, который создаст базу данных по приведенной схеме

CREATE DATABASE homework5;

USE homework5;

CREATE TABLE partners (
id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(150) NOT NULL,
description TEXT,
address VARCHAR(255) NOT NULL
);

CREATE TABLE positions (
id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
description TEXT,
price INT NOT NULL DEFAULT(0),
photo_url VARCHAR(255),
partner_id BIGINT UNSIGNED,
FOREIGN KEY (partner_id) REFERENCES partners(id)
);

CREATE TABLE clients (
id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
phone CHAR(12),
fullname VARCHAR(255)
);

CREATE TABLE orders (
id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
created_at DATETIME,
address VARCHAR (255),
latitude FLOAT,
longitude FLOAT,
status ENUM ("new", "accepted", "delivered", "completed"),
client_id BIGINT UNSIGNED,
FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE position_to_order (
position_id BIGINT REFERENCES orders(id),
order_id BIGINT REFERENCES positions(id),
CONSTRAINT position_to_order_pkey PRIMARY KEY (position_id, order_id)
);

-- 1. Заполните базу тестовыми данными, не менее 3 партнеров,
-- не менее 3 позиций для заказа у каждого из партнеров.
-- 3 Пользователя, у каждого из которых от 1 до 5 заказов,
-- в каждом из заказов от 1 до 3 позиций блюд

INSERT INTO partners (title, description, address) VALUES 
("partner 1", "description 1", "address 1"),
("partner 2", "description 2", "address 2"),
("partner 3", "description 3", "address 3");

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES
("title 1", "decription 1", 100, "https://www.food1.kz/1.jpg", 1),
("title 2", "decription 2", 200, "https://www.food1.kz/2.jpg", 1),
("title 3", "decription 3", 300, "https://www.food1.kz/3.jpg", 1),
("title 1", "decription 1", 100, "https://www.food2.kz/1.jpg", 2),
("title 2", "decription 2", 200, "https://www.food2.kz/2.jpg", 2),
("title 3", "decription 3", 100, "https://www.food2.kz/3.jpg", 2),
("title 1", "decription 1", 200, "https://www.food3.kz/1.jpg", 3),
("title 2", "decription 2", 300, "https://www.food3.kz/2.jpg", 3),
("title 3", "decription 3", 300, "https://www.food3.kz/3.jpg", 3);

INSERT INTO clients (phone, fullname) VALUES 
("+70111111111", "full name one"),
("+70222222222", "full name two"),
("+70777777777", "full name three");

INSERT INTO orders (id, created_at, address, latitude, longitude,status, client_id) VALUES
 (1, NOW(), "address 1", "11.1", "-11.1", "new", 1),
 (2, NOW(), "address 1", "11.1", "-11.1", "accepted", 1),
 (3, NOW(), "address 1", "11.1", "-11.1", "delivered", 1),
 (4, NOW(), "address 1", "11.1", "-11.1", "completed", 1),
 (5, NOW(), "address 1", "11.2", "-11.1", "new", 1),
 (6, NOW(), "address 2", "22.2", "-22.2", "completed", 2),
 (7, NOW(), "address 2", "22.2", "-22.2", "completed", 2),
 (8, NOW(), "address 2", "22.2", "-22.2", "completed", 2),
 (9, NOW(), "address 3", "33.3", "-33.3", "delivered", 3),
 (10, NOW(), "address 3", "33.3", "-33.3", "delivered", 3),
 (11, NOW(), "address 3", "33.3", "-33.3", "delivered", 3),
 (12, NOW(), "address 3", "33.3", "-33.3", "new", 3);

INSERT INTO (position_id, order_id) VALUES 
(1,1), 
(2,2),
(3,3),
(1,4),
(2,5),
(3,6),
(1,7),
(2,8),
(3,9),
(1,10),
(2,11),
(3,12);

-- Напишите запрос, который будет выводить номера заказов (их ИД),
-- номер телефонов клиентов, название партнера

SELECT orders.id, clients.phone, partners.title FROM orders 
JOIN clients ON orders.client_id =clients.id
JOIN position_to_order ON orders.id = position_to_order.order_id
JOIN positions ON positions.id = position_to_order.position_id
JOIN partners ON partners.id = partners.id;

-- Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы. 

INSERT INTO partners (title, description,address) VALUES
("partner 4","description 4","adddress 4");

 INSERT INTO positions (title, description,price, photo_url, partner_id) VALUES
 ("title 4","description 4", 400, "https://www.food4.kz/4.jpg", 4);

-- Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа.

SELECT * FROM partners WHERE partners.id NOT IN 
(SELECT partner_id FROM position_to_order JOIN positions ON positions.id = position_to_order.position_id);

-- Напишите запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа.
 
SELECT positions.title FROM orders, positions, position_to_order WHERE position_to_order.order_id = orders.id
 	AND position_to_order.position_id = positions.id 
 	AND orders.id = 3
 	AND orders.client_id = 1;

