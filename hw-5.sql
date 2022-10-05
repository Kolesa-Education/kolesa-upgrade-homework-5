CREATE DATABASE kolesa_food;

USE kolesa_food;


CREATE TABLE partners (
	id int UNSIGNED PRIMARY KEY auto_increment,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE clients (
	id int UNSIGNED PRIMARY KEY auto_increment,
	phone char(12),
	fullname varchar(255)
);

CREATE TABLE positions (
	id int UNSIGNED PRIMARY KEY auto_increment,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL default(0),
	photo_url varchar(255),
	partner_id int UNSIGNED,
	FOREIGN KEY (partner_id) REFERENCES partners(id)
);

CREATE TABLE orders (
	id int UNSIGNED PRIMARY KEY auto_increment,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	address varchar(255) NOT NULL,
	latitude float NOT NULL,
	longtitude float NOT NULL,
	status enum ('new', 'accepted', 'on_the_way', 'completed'),
	client_id int UNSIGNED,
	partner_id int UNSIGNED,
	FOREIGN KEY (client_id) REFERENCES clients(id),
	FOREIGN KEY (partner_id) REFERENCES partners(id)
);

CREATE TABLE positions_orders (
	position_id int UNSIGNED,
	order_id int UNSIGNED,
	PRIMARY KEY (position_id, order_id),
	FOREIGN KEY (position_id) REFERENCES positions(id),
	FOREIGN KEY (order_id) REFERENCES orders(id)
);


INSERT INTO partners(title, description, address) VALUES (
	"McDonald's", "The largest American fast-food corporation.", "Timiryazev St. 38/3"
), (
	"Cafe Plus", "Almaty cafe with cozy atmosphere and democratic prices.", "Zheltoksan St. 144"
), (
	"Degirmen", "Turkish bakery. Works since 1986.", "Zhumaliyev St. 9"
);


INSERT INTO positions(
	title,
	description,
	price,
	photo_url,
	partner_id
) VALUES (
	"BigMac",
	"The most famous burger.",
	"1300",
	"https://s7d1.scene7.com/is/image/mcdonalds/t-mcdonalds-Big-Mac-1:1-3-product-tile-desktop?wid=830&hei=516&dpr=off",
	(SELECT id FROM partners WHERE title = "McDonald's")
), (
	"McFlurry",
	"Delicious flavoured ice-cream with and jam.",
	"780",
	"https://mcdonalds.kz/storage/1592/8320439e13c50192a648a48aae2f1f9139f1680b.png",
	(SELECT id FROM partners WHERE title = "McDonald's")
), (
	"Coca-Cola",
	"Coca-Cola, or Coke, is a carbonated soft drink manufactured by the Coca-Cola Company.",
	"300",
	"https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Coca-Cola_glass_bottle_%28Germany%29.jpg/800px-Coca-Cola_glass_bottle_%28Germany%29.jpg",
	(SELECT id FROM partners WHERE title = "McDonald's")
);

INSERT INTO positions(
	title,
	description,
	price,
	photo_url,
	partner_id
) VALUES (
	"Beef Pizza",
	"A pizza with tomato sauce, pepperoni & jalapeno peppers, beef and mozarella.",
	"2450",
	"https://api.papajohns.kz//images/catalog/thumbs/full/201ef262240853793cf4b953ccd96012.webp",
	(SELECT id FROM partners WHERE title = "Cafe Plus")
), (
	"Buckwheat Pancake",
	"Traditional French buckwheat pancakes. Stuffed with turkey/beacon and cheese.",
	"850",
	"https://kafeplus.kz/image/cache/catalog/blinchik_bez_nachinki-850x567.jpg",
	(SELECT id FROM partners WHERE title = "Cafe Plus")
), (
	"Orange Fresh",
	"Orange fresh - sweet, invigorating juice filled with vitamin C! That's what your immune system needs!",
	"1750",
	"https://kafeplus.kz/image/cache/catalog/%20фреш%20маленький-850x567.jpg",
	(SELECT id FROM partners WHERE title = "Cafe Plus")
);

INSERT INTO positions(
	title,
	description,
	price,
	photo_url,
	partner_id
) VALUES (
	"Cherry Casserole",
	"Classic delicate dessert",
	"900",
	"https://degirmenkaz.kz/wp-content/uploads/2018/08/Zapekanka-s-vishnej.jpg",
	(SELECT id FROM partners WHERE title = "Degirmen")
), (
	"Baguette",
	"One of the typical products of French cuisine and a kind of symbol of France.",
	"350",
	"https://degirmenkaz.kz/wp-content/uploads/2018/08/Baget.jpg",
	(SELECT id FROM partners WHERE title = "Degirmen")
), (
	"Peasant Bread",
	"Traditional rye flour bread (wholemeal, peeled and seeded).",
	"250",
	"https://degirmenkaz.kz/wp-content/uploads/2018/08/Krestjanskij-hleb.jpg",
	(SELECT id FROM partners WHERE title = "Degirmen")
);


INSERT INTO clients(phone, fullname) VALUES (
	"+77779998877", "Kudaibergen Ahat"
), (
	"+77081112233", "Anton Nazarov"
), (
	"+77751005050", "Linus Torvalds"
);


INSERT INTO orders(
	client_id,
	partner_id,
	address,
	latitude,
	longtitude,
	status
) VALUES (
	(SELECT id FROM clients WHERE fullname = "Kudaibergen Ahat"),
	(SELECT id FROM partners WHERE title = "McDonald's"),
	"Shahristan microdist. 14/1",
	76.884695,
	43.207313,
	"new"
), (
	(SELECT id FROM clients WHERE fullname = "Kudaibergen Ahat"),
	(SELECT id FROM partners WHERE title = "Cafe Plus"),
	"Shahristan microdist. 14/1",
	76.884695,
	43.207313,
	"on_the_way"
), (
	(SELECT id FROM clients WHERE fullname = "Kudaibergen Ahat"),
	(SELECT id FROM partners WHERE title = "Cafe Plus"),
	"Shahristan microdist. 14/1",
	76.884695,
	43.207313,
	"completed"
), (
	(SELECT id FROM clients WHERE fullname = "Anton Nazarov"),
	(SELECT id FROM partners WHERE title = "Degirmen"),
	"Gagarin St. 309",
	76.898588,
	43.202675,
	"completed"
), (
	(SELECT id FROM clients WHERE fullname = "Anton Nazarov"),
	(SELECT id FROM partners WHERE title = "McDonald's"),
	"Gagarin St. 309",
	76.898588,
	43.202675,
	"accepted"
), (
	(SELECT id FROM clients WHERE fullname = "Linus Torvalds"),
	(SELECT id FROM partners WHERE title = "Cafe Plus"),
	"Kazakhfilm microdist. 22",
	76.905745,
	43.196234,
	"completed"
), (
	(SELECT id FROM clients WHERE fullname = "Linus Torvalds"),
	(SELECT id FROM partners WHERE title = "McDonald's"),
	"Kazakhfilm microdist. 22",
	76.905745,
	43.196234,
	"on_the_way"
);


INSERT INTO positions_orders(position_id, order_id) VALUES (
	(SELECT id FROM positions WHERE title = "BigMac"),
	1
), (
	(SELECT id FROM positions WHERE title = "McFlurry"),
	5
), (
	(SELECT id FROM positions WHERE title = "Coca-Cola"),
	7
);

INSERT INTO positions_orders(position_id, order_id) VALUES (
	(SELECT id FROM positions WHERE title = "Coca-Cola"),
	1
);

INSERT INTO positions_orders(position_id, order_id) VALUES (
	(SELECT id FROM positions WHERE title = "Beef Pizza"),
	2
), (
	(SELECT id FROM positions WHERE title = "Buckwheat Pancake"),
	3
), (
	(SELECT id FROM positions WHERE title = "Orange Fresh"),
	6
);

INSERT INTO positions_orders(position_id, order_id) VALUES (
	(SELECT id FROM positions WHERE title = "Cherry Casserole"),
	4
);


SELECT orders.id, clients.phone, partners.title FROM orders 
LEFT JOIN clients ON orders.client_id = clients.id 
LEFT JOIN partners ON orders.partner_id = partners.id;


INSERT INTO partners(title, description, address) VALUES (
	"KFC", "The Harland Sanders' Kentucky Fried Chicken made with secret recipe.", "Gogol St. 44-51"
);

INSERT INTO positions(
	title,
	description,
	price,
	photo_url,
	partner_id
) VALUES (
	"Chicken Bucket",
	"A big bucket of branded chicken strips, bites & wings.",
	"4200",
	"https://kfcnamibia.com/wp-content/uploads/2021/10/21-piece-Bucket-1024x1024.jpg",
	(SELECT id FROM partners WHERE title = "KFC")
);


SELECT partners.title FROM partners
LEFT JOIN orders ON partners.id = orders.partner_id
WHERE partners.id NOT IN (SELECT partner_id FROM orders);

SELECT positions.title FROM positions
LEFT JOIN positions_orders ON positions_orders.position_id = positions.id
LEFT JOIN orders ON positions_orders.order_id = orders.id
LEFT JOIN clients ON orders.client_id = clients.id
WHERE clients.id = 1 AND orders.id = 1;

