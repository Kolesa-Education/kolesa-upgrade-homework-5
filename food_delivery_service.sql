CREATE DATABASE food_delivery_service;

USE food_delivery_service;

CREATE TABLE partners (
	id int UNSIGNED PRIMARY KEY auto_increment,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE positions (
	id int UNSIGNED PRIMARY KEY auto_increment,
	title varchar(255) NOT NULL,
	description text NOT NULL,
	price int NOT NULL default(0),
	photo_url varchar(255),
	partner_id int UNSIGNED,
	FOREIGN KEY (partner_id) REFERENCES partners(id)
);

CREATE TABLE clients (
	id int UNSIGNED PRIMARY KEY auto_increment,
	phone char(12) NOT NULL,
	fullname varchar(255) NOT NULL
);

CREATE TABLE orders (
	id int UNSIGNED PRIMARY KEY auto_increment,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	address varchar(255) NOT NULL,
	latitude float NOT NULL,
	longitude float NOT NULL,
	status enum ('new', 'accepted', 'ongoing', 'completed'),
	client_id int UNSIGNED,
	FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE position_order (
	position_id int UNSIGNED,
	order_id int UNSIGNED,
	PRIMARY KEY (position_id, order_id),
	FOREIGN KEY (position_id) REFERENCES positions(id)
		ON UPDATE CASCADE 
		ON DELETE CASCADE,
	FOREIGN KEY (order_id) REFERENCES orders(id)
		ON UPDATE CASCADE 
		ON DELETE RESTRICT
);

/*1. Заполните базу тестовыми данными, не менее 3 партнеров, 
 * не менее 3 позиций для заказа у каждого из партнеров. 
 * 3 Пользователя, у каждого из которых от 1 до 5 заказов, 
 * в каждом из заказов от 1 до 3 позиций блюд*/

INSERT INTO partners(title, description, address) VALUES (
	"KFC", "A global chicken restaurant brand", "227 Tole bi street"
), (
	"Alazani", "Best kebab restaurant in Almaty", "320 Kabanbay batyr street"
), (
	"Dodo Pizza", "A worldwide chain of pizzerias", "105 Auezov street"
);

INSERT INTO positions(title, description, price, photo_url, partner_id) VALUES (
	"28 hot wings basket",
	"28 spicy chicken wings in branded breading",
	"7600",
	"https://www.kfc.kz/admin/files/4349.jpg",
	(SELECT id FROM partners WHERE title = "KFC")
), (
	"Boxmaster",
	"Сhicken fillet in unique breading, hash brown, cheese, salad, tomatoes and tender sauce",
	"1750",
	"https://www.kfc.kz/admin/files/medium/medium_4309.jpg",
	(SELECT id FROM partners WHERE title = "KFC")
), (
	"Pepsi 0.5L",
	"Carbonated soft drink",
	"500",
	"https://www.kfc.kz/admin/files/medium/medium_4301.jpg",
	(SELECT id FROM partners WHERE title = "KFC")
);

INSERT INTO positions(title, description, price, photo_url, partner_id) VALUES (
	"Lamb lula kebab",
	"Minced meat strung on a skewer and grilled on coals",
	"1500",
	"https://kartinkin.net/uploads/posts/2021-03/1617190035_42-p-lyulya-kebab-krasivo-48.jpg",
	(SELECT id FROM partners WHERE title = "Alazani")
), (
	"Adjarian Khachapuri",
	"Georgian Cheese Bread",
	"1300",
	"https://3ner1e34iilsjdn1qohanunu-wpengine.netdna-ssl.com/wp-content/uploads/2018/02/adjaruli_7.jpg",
	(SELECT id FROM partners WHERE title = "Alazani")
), (
	"Alazani Valley Wine",
	"It is a popular semi-sweet Georgian table wine",
	"2200",
	"https://alcogo.kz/image/cache/data/ayan%203/472f89a3496711e980f5a699d4a773c5_3c76ea414af911e980f6a699d4a773c5-651x800-1000x1000.jpg",
	(SELECT id FROM partners WHERE title = "Alazani")
);

INSERT INTO positions(title, description, price, photo_url, partner_id) VALUES (
	"Dodo Mix Pizza",
	"Signature pizza from Dodo",
	"2900",
	"https://cdn.dodostatic.net/static/Img/Products/40aa86a0942f4c44b8c287fdd89ae182_366x366.jpeg",
	(SELECT id FROM partners WHERE title = "Dodo Pizza")
), (
	"Dodster",
	"Legendary hot appetizer from Dodo",
	"1300",
	"https://cdn.dodostatic.net/static/Img/Products/1d30ab9bcfe54cf489cdd65a67998671_366x366.jpeg",
	(SELECT id FROM partners WHERE title = "Dodo Pizza")
), (
	"Mango milkshake",
	"Milkshake with mango puree",
	"1800",
	"https://cdn.dodostatic.net/static/Img/Products/655a965093144002b0193039d0cf1def_366x366.jpeg",
	(SELECT id FROM partners WHERE title = "Dodo Pizza")
);

INSERT INTO clients(phone, fullname) VALUES (
	"+77771234567", "Kairat Nurtas"
), (
	"+77471112233", "Ernar Aidar"
), (
	"+77023337799", "Toregali Toreali"
);

INSERT INTO orders(address, latitude, longitude, status, client_id) VALUES (
	"101 Remizovka street",
	43.204073,
	76.928634,
	"new",
	(SELECT id FROM clients WHERE fullname = "Kairat Nurtas")
), (
	"101 Remizovka street",
	43.204073,
	76.928634,
	"accepted",
	(SELECT id FROM clients WHERE fullname = "Kairat Nurtas")
), (
	"41 Samal-2 microdist, apt 56",
	43.231076,
	76.954117,
	"completed",
	(SELECT id FROM clients WHERE fullname = "Ernar Aidar")
), (
	"41 Samal-2 microdist, apt 56",
	43.231076,
	76.954117,
	"ongoing",
	(SELECT id FROM clients WHERE fullname = "Ernar Aidar")
), (
	"21/3 AFD plaza, apt 77",
	43.229311,
	76.942123,
	"new",
	(SELECT id FROM clients WHERE fullname = "Toregali Toreali")
), (
	"21/3 AFD plaza, apt 77",
	43.229311,
	76.942123,
	"ongoing",
	(SELECT id FROM clients WHERE fullname = "Toregali Toreali")
);

INSERT INTO position_order(position_id, order_id) VALUES
	(1, 3),
	(2, 4),
	(3, 4),
	(4, 1),
	(5, 2),
	(6, 1),
	(7, 5),
	(8, 5),
	(9, 6);

/*2. Напишите запрос, который будет выводить номера заказов (их ИД), 
 * номер телефонов клиентов, название партнера*/

SELECT orders.id AS orders_id, clients.phone, partners.title FROM clients 
JOIN orders ON clients.id = orders.client_id
JOIN position_order ON orders.id = position_order.order_id
JOIN positions ON position_order.position_id = positions.id
JOIN partners ON positions.partner_id = partners.id

/*3. Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы. 
 * Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа*/

INSERT INTO partners(title, description, address) VALUES (
	"Paradise", "Famous Almaty cafe with Euro-Asian cuisine", "519/1 Seifullin street"
);

INSERT INTO positions(title, description, price, photo_url, partner_id) VALUES (
	"Comyan",
	"Fried lagman",
	"1800",
	"https://static.1000.menu/img/content-v2/70/e3/49449/comyan-jarenyi-lagman-po-uigurski_1596611119_1_max.jpg",
	(SELECT id FROM partners WHERE title = "Paradise")
);

SELECT partners.title FROM partners WHERE partners.id NOT IN
(SELECT partner_id FROM position_order
JOIN positions ON positions.id = position_order.position_id
);

/*4. Напишите запрос, который по ID пользователя и ID заказа 
 * выведет названия всех позиций из этого заказа.*/

SELECT clients.id, clients.fullname, orders.id, orders.status, positions.title FROM clients
JOIN orders ON clients.id = orders.client_id
JOIN position_order ON orders.id = position_order.order_id
JOIN positions ON position_order.position_id = positions.id;