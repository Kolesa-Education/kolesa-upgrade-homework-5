CREATE DATABASE foodDelivery;

USE foodDelivery;

CREATE TABLE partners (
	id int UNSIGNED not null primary key auto_increment,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE positions(
	id int UNSIGNED NOT NULL primary key auto_increment,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES partners (id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE clients(
	id int UNSIGNED NOT NULL primary key auto_increment,
	phone char(12) NOT NULL UNIQUE,
	fullname varchar(255)
);

CREATE TABLE orders(
	id int UNSIGNED NOT NULL primary key auto_increment,
	created_at datetime NOT NULL DEFAULT(NOW()),
	address varchar(255) NOT NULL,
	latitude float NOT NULL,
	longitude float NOT NULL,
	status enum('new', 'accepted', 'delivering', 'done'),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES clients(id)
		ON UPDATE CASCADEа
		ON DELETE RESTRICT
);

CREATE TABLE orders_positions(
	order_id int UNSIGNED NOT NULL,
	position_id int UNSIGNED NOT NULL,
	PRIMARY KEY(order_id, position_id),
	FOREIGN KEY (order_id) REFERENCES orders (id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (position_id) REFERENCES positions (id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

# заполняю партнеров

INSERT INTO partners (title, description, address) VALUES (
	"Yakitoriya",
	"The legendary chain of Japanese cafes is now in Astana",
	"пр.Туран 21а"
), (
	"CrepeCafe",
	"Kunayeva 12/1"
), (
	"Boba",
	"Drinks that can brighten up any of your days",
	"Туркестан 16/5, офис 4"
), (
	"Lanzhou",
	"This place is filled with flavors of Chinese cuisine",
	"Пр.Бухар Жырау, 50а"
);

# заполняю позиции

# Lanzhou
INSERT INTO positions (title, description, price, partner_id) VALUES (
	"Гуйру",
	"Гуйру – в переводе с китайского «крупно нарезанный». Состав: говядина, пекинская капуста, полугорький перец, сельдерей, чеснок, имбирь, соус для лагмана.",
	1690,
	(SELECT id FROM partners WHERE title="Lanzhou")
), (
	"Цомян",
	"Жареный лагман, сочный и колоритный. Состав: говядина, тесто, пекинская капуста, полугорький перец, сельдерей, чеснок, имбирь, соус для лагмана, тесто для лагмана.",
	1900,
	(SELECT id FROM partners WHERE title="Lanzhou")
), (
	"Говядина с овощами",
	2100,
	(SELECT id FROM partners WHERE title="Lanzhou")
);

# Boba
INSERT INTO positions (title, price, partner_id) VALUES (
	"Улун",
	1400,
	(SELECT id FROM partners WHERE title="Boba")
), (
	"Матча",
	1400,
	(SELECT id FROM partners WHERE title="Boba")
), (
	"Банановый смузи",
	1600,
	(SELECT id FROM partners WHERE title="Boba")
);

# CrepeCafe
INSERT INTO positions (title, description, price, partner_id) VALUES (
	"Креп с бананом и шоколадом",
	"Кусочки свежих бананов с шоколадом Нутелла.",
	1870,
	(SELECT id FROM partners WHERE title="CrepeCafe")
), (
	"Креп с клубникой и шоколадом",
	"Клубника с шоколадом Нутелла.",
	1990,
	(SELECT id FROM partners WHERE title="CrepeCafe")
), (
	"Креп шоколадный брауни",
	"Кусочки шоколадного брауни с нотками миндаля в шоколаде Нутелла, грецкими орехами и заварным кремом.",
	1790,
	(SELECT id FROM partners WHERE title="CrepeCafe")
);

# Yakitoriya
INSERT INTO positions (title, description, price, partner_id) VALUES (
	"Сет Классик",
	"Классический сет: калифорния, филадельфия (фирменная), унаги рору, сякэ рору, каппа маки (34 шт.)",
	10000,
	(SELECT id FROM partners WHERE title="Yakitoriya")
), (
	"Сакура сет (47 шт)",
	"Калифорния, Айдахо маки, Бали маки, Филадельфия, Киото рору, Сяке Калифорния (47 шт)",
	18000,
	(SELECT id FROM partners WHERE title="Yakitoriya")
), (
	"Киото рору",
	"лосось, сливочный сыр, красная икра (8 шт.)",
	2700,
	(SELECT id FROM partners WHERE title="Yakitoriya")
);

# заполняю таблицу клиенты

INSERT INTO clients (phone, fullname) VALUES (87088251447, "Балнур Серик");
INSERT INTO clients (phone, fullname) VALUES (87754430453, "Асем Маликова");
INSERT INTO clients (phone, fullname) VALUES (87074845413, "Асанали Калел");

# заполняю таблицу заказов

INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-04 14:05:00",
	"Кабанбай Батыр 13",
	12.34,
	14.56,
	"done",
	1
);

INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-05 16:05:00",
	"Кабанбай Батыр 13",
	12.34,
	14.56,
	"accepted",
	1
);

INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-05 15:25:10",
	"Кабанбай Батыр 25/17 кв.1",
	32.567,
	143.56,
	"delivering",
	2
);

INSERT INTO orders (address, latitude, longitude, status, client_id) VALUES (
	"Кабанбай Батыр 25/17 кв.1",
	32.567,
	143.56,
	"new",
	2
);


INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-09-17 18:21:19",
	"Кабанбай Батыр 25/17, кв.1",
	32.567,
	143.56,
	"done",
	2
);

INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-09-14 00:29:19",
	"Кошкарбаева 54, 6",
	145.567,
	36.56,
	"done",
	3
);

# orders_positions

INSERT INTO orders_positions (order_id, position_id) SELECT 1, id FROM positions WHERE title="Гуйру";
INSERT INTO orders_positions (order_id, position_id) SELECT 1, id FROM positions WHERE title="Креп шоколадный брауни";

INSERT INTO orders_positions (order_id, position_id) SELECT 2, id FROM positions WHERE title="Матча";

INSERT INTO orders_positions (order_id, position_id) SELECT 3, id FROM positions WHERE title="Цомян";
INSERT INTO orders_positions (order_id, position_id) SELECT 3, id FROM positions WHERE title="Сет Классик";
INSERT INTO orders_positions (order_id, position_id) SELECT 3, id FROM positions WHERE title="Креп шоколадный брауни";

INSERT INTO orders_positions (order_id, position_id) VALUES (
	(SELECT id FROM orders WHERE status="new" AND client_id=2), 
	(SELECT id FROM positions WHERE title="Киото рору")
);


INSERT INTO orders_positions (order_id, position_id) VALUES (
	(SELECT id FROM orders WHERE status="done" AND client_id=2), 
	(SELECT id FROM positions WHERE title="Говядина с овощами")
);

INSERT INTO orders_positions (order_id, position_id) VALUES (
	(SELECT id FROM orders WHERE status="done" AND client_id=2), 
	(SELECT id FROM positions WHERE title="Киото рору")
);


INSERT INTO orders_positions (order_id, position_id) VALUES (
	(SELECT id FROM orders WHERE status="done" AND client_id=3), 
	(SELECT id FROM positions WHERE title="Говядина с овощами")
); 

INSERT INTO orders_positions (order_id, position_id) VALUES (
	(SELECT id FROM orders WHERE status="done" AND client_id=3), 
	(SELECT id FROM positions WHERE title="Банановый смузи")
); 

INSERT INTO orders_positions (order_id, position_id) VALUES (
	(SELECT id FROM orders WHERE status="done" AND client_id=3), 
	(SELECT id FROM positions WHERE title="Креп с клубникой и шоколадом")
); 


# 2. запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера

SELECT orders.id, clients.phone, partners.title FROM orders 
JOIN clients ON orders.client_id = clients.id 
JOIN orders_positions ON orders.id = orders_positions.order_id  
JOIN positions ON orders_positions.position_id = positions.id 
JOIN partners ON positions.partner_id = partners.id;

# 3. Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы. Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа

INSERT INTO partners (title, address) VALUES ("Burger King", "Абылайхан 45а");

INSERT INTO positions (title, price, partner_id) VALUES ("Чизбургер комбо", 1490, 
	(SELECT id FROM partners WHERE title="Burger King")
);

SELECT * FROM partners WHERE id NOT IN (
	SELECT partner_id FROM orders_positions JOIN positions ON positions.id = orders_positions.position_id 
);

# 4. запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа.

SELECT positions.title 
FROM orders, orders_positions, positions 
WHERE orders.client_id = 1 AND orders.id = 1 AND orders_positions.order_id  = orders.id AND orders_positions.position_id = positions.id;
