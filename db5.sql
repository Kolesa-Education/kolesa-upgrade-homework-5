CREATE DATABASE db5;

USE db5;

CREATE TABLE partners (
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
   title varchar(150) NOT NULL,
   description text,
   address varchar(255) NOT NULL
);

CREATE TABLE positions (
   id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
   title varchar(255) NOT NULL,
   description text,
   price int NOT NULL DEFAULT(0),
   photo_url varchar(255),
   partner_id int UNSIGNED NOT NULL,
   FOREIGN KEY (partner_id) REFERENCES partners(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

CREATE TABLE clients (
   id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
   phone char(12),
   fullname varchar(255)
);

CREATE TABLE orders (
   id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
   created_at datetime,
   address varchar(255),
   latitude float,
   longitude float,
   status enum ('new', 'accepted', 'delivering', 'close'),
   client_id int UNSIGNED NOT NULL,
   FOREIGN KEY (client_id) REFERENCES clients(id)
   	ON UPDATE CASCADE
   	ON DELETE RESTRICT
);

CREATE TABLE orders_positions (
   order_id int UNSIGNED NOT NULL,
   position_id int UNSIGNED NOT NULL,
   PRIMARY KEY (order_id, position_id),
   FOREIGN KEY (order_id) REFERENCES orders(id)
   	ON UPDATE CASCADE
   	ON DELETE CASCADE,
   FOREIGN KEY (position_id) REFERENCES positions(id)
   	ON UPDATE CASCADE
   	ON DELETE CASCADE
);

-- 1
INSERT INTO partners(title, description, address)
VALUES ('McDonalds', 'description1', 'address1'),
      ('KFC', 'description2', 'address2'),
      ('Burger King', 'description3', 'address3');

INSERT INTO positions(title, description, price, photo_url, partner_id)
VALUES ('Burger', 'description1', 100, 'url1', 1),
      ('Pasta', 'description2', 200, 'url2', 1),
      ('Soup', 'description3', 300, 'url3', 1),
      ('Noodle', 'description4', 400, 'url4', 2),
      ('Sandwich', 'description5', 500, 'url5', 2),
      ('Ice Cream', 'description6', 600, 'url6', 2),
      ('Bread', 'description7', 700, 'url7', 3),
      ('Pilaf', 'description8', 800, 'url8', 3),
      ('Kebab', 'description9', 900, 'url9', 3);

INSERT INTO clients(phone, fullname)
VALUES ('+7051111111', 'Almat'),
      ('+70522222222', 'Dastan'),
      ('+70533333333', 'Nazar');

INSERT INTO orders(created_at, address, latitude, longitude, status, client_id)
VALUES (now(), 'adr1', 1.1, 1.1, 'new', 1),
		(now(), 'adr2', 2.2, 2.2, 'accepted', 2),
		(now(), 'adr3', 3.3, 3.3, 'delivering', 2),
		(now(), 'adr4', 4.4, 4.4, 'close', 3),
		(now(), 'adr5', 5.5, 5.5, 'new', 3),
		(now(), 'adr6', 6.6, 6.6, 'accepted', 3);

INSERT INTO orders_positions (order_id, position_id)
VALUES (1, 1),
      (2, 2),
      (2, 3),
      (3, 4),
      (3, 5),
      (3, 6),
      (4, 7),
      (5, 8),
      (5, 9),
      (6, 1),
      (6, 2),
      (6, 3);

-- 2
SELECT DISTINCT orders.id, clients.phone, partners.title
FROM orders, clients, partners, positions, orders_positions
WHERE clients.id = orders.client_id
AND orders.id = orders_positions.order_id
AND orders_positions.position_id = positions.id
AND positions.partner_id = partners.id;

-- 3
INSERT INTO partners (title, description, address)
VALUES ('Pizza Hut', 'description3', 'address4');

INSERT INTO positions (title, description, price, photo_url, partner_id)
VALUES ('Cheeseburger', 'description10', 1000, 'url10', 4);

SELECT partners.id, partners.title
FROM partners
WHERE partners.id NOT IN (
	SELECT DISTINCT positions.partner_id
	FROM orders_positions, positions
	WHERE	orders_positions.position_id = positions.id);
	
-- 4
SELECT positions.title
FROM positions, orders, orders_positions
WHERE orders.id = 3
AND orders.client_id = 2
AND positions.id = orders_positions.position_id
AND orders.id = orders_positions.order_id;