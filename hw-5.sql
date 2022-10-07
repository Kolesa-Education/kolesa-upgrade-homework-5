CREATE DATABASE food_delivery;

USE food_delivery;

CREATE TABLE partners (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(150) NOT NULL UNIQUE,
	description text,
	address varchar(255) NOT NULL 
);

CREATE TABLE positions (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(255) NOT NULL UNIQUE,
	description text,
	price int UNSIGNED NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES partners(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE clients (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	phone char(12),
	fullname varchar(255) NOT NULL
);

CREATE TABLE orders (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum('forming','in progress','done'),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE CASCADE ON DELETE RESTRICT
);	

CREATE TABLE orders_positions (
	order_id int UNSIGNED NOT NULL,
	position_id int UNSIGNED NOT NULL,
	PRIMARY KEY (order_id, positions_id),
	FOREIGN KEY (order_id) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (position_id) REFERENCES positions(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO partners (title, description, address) VALUES ('Kakaodak','корейская кухня', 'Байтурсынова 5');
INSERT INTO partners (title, description, address) VALUES ('KFC','фаст фуд', 'Республика 7');
INSERT INTO partners (title, description, address) VALUES ('Whoopie Cakes','десерты и завтраки', 'Улы Дала 7/2');

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Янгнем чикен','курица в традиционном корейском соусе',3850,'url-kakaodak1',1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Рамен','пшеничная лапша с бульоном',2000,'url-kakaodak2',1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Куксу','лапша с овощами и мясом',1700,'url-kakaodak3',1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Чикен пита комбо','Чикен Пита, картофель фри большой, Pepsi 0,5L, кетчуп',2450,'url-kfc1',2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Баскет дуэт','2 ножки, 4 острых крыла, 4 стрипса, 2 маленьких картофеля фри',4000,'url-kfc2',2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Стрипсы','Острые или оригинальные стрипсы',1400,'url-kfc3',2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Love&Croissant Breakfast','Домашний круассан с кремом на маскарпоне и сливках, конфитюром и ягодой',2990,'url-whoopie1',3);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Escimo pie','Шоколадный бисквит с кремчизом и молочным шоколадом',1800,'url-whoopie2',3);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Whoopie pie','Бисквит с фирменным кремом на маскарпоне и сливках',1200,'url-whoopie3',3);

INSERT INTO clients (phone, fullname) VALUES ('+77019831245','Асель Асхарова');
INSERT INTO clients (phone, fullname) VALUES ('+77784569812','Мария Борисова');
INSERT INTO clients (phone, fullname) VALUES ('+77751342567','Алмаз Бакытов');

INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2022-09-29 20:13:11','Республика 12', 8.8, 12.8, 'done',1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2022-07-10 09:50:11','Республика 12', 8.8, 12.8, 'in progress',1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2022-07-10 12:37:11','Республика 12', 8.8, 12.8, 'forming',1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2021-10-21 00:20:10','Богенбай батыра 25/3', 12.3, 2.5, 'done',2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2022-06-16 17:15:58','Богенбай батыра 25/3', 12.3, 2.5, 'done',2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2022-07-10 11:20:18','Богенбай батыра 25/3', 12.3, 2.5, 'in progress',2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2022-07-10 12:39:30','Богенбай батыра 25/3', 12.3, 2.5, 'forming',2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2020-08-02 18:40:31','Иманова 18', 15.9, 16.8, 'done',3);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES ('2022-07-10 10:57:59','Иманова 18', 15.9, 16.8, 'in progress',3);

INSERT INTO orders_positions (order_id, position_id) VALUES (1,2);
INSERT INTO orders_positions (order_id, position_id) VALUES (1,7);
INSERT INTO orders_positions (order_id, position_id) VALUES (1,8);
INSERT INTO orders_positions (order_id, position_id) VALUES (2,2);
INSERT INTO orders_positions (order_id, position_id) VALUES (3,4);
INSERT INTO orders_positions (order_id, position_id) VALUES (3,6);
INSERT INTO orders_positions (order_id, position_id) VALUES (4,2);
INSERT INTO orders_positions (order_id, position_id) VALUES (4,8);
INSERT INTO orders_positions (order_id, position_id) VALUES (4,7);
INSERT INTO orders_positions (order_id, position_id) VALUES (5,1);
INSERT INTO orders_positions (order_id, position_id) VALUES (6,5);
INSERT INTO orders_positions (order_id, position_id) VALUES (6,8);
INSERT INTO orders_positions (order_id, position_id) VALUES (7,3);
INSERT INTO orders_positions (order_id, position_id) VALUES (7,4);
INSERT INTO orders_positions (order_id, position_id) VALUES (8,7);
INSERT INTO orders_positions (order_id, position_id) VALUES (8,1);
INSERT INTO orders_positions (order_id, position_id) VALUES (8,4);
INSERT INTO orders_positions (order_id, position_id) VALUES (9,3);

SELECT DISTINCT ord.id, cln.phone, part.title 
FROM orders ord, clients cln, partners part, positions pos, orders_positions op
WHERE part.id = pos.partner_id AND pos.id = op.position_id AND op.order_id = ord.id AND ord.client_id = cln.id

INSERT INTO partners (title, description, address) VALUES ('Crepe cafe','сладкие и сытные крепы', 'Кунаева 12/1');
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('Запеченная Филадельфия','Ломтики запеченной семга со сливочным сыром и свежим огурцом',2590,'url-crepe1',4);

SELECT part.title FROM partners part
WHERE part.id NOT IN (SELECT pos.partner_id FROM orders_positions op, positions pos WHERE op.position_id = pos.id)

SELECT pos.title 
FROM orders ord, positions pos, orders_positions op 
WHERE ord.id = 1 AND ord.client_id = 1 AND op.order_id = ord.id AND pos.id = op.position_id

