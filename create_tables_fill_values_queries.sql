CREATE DATABASE food_order;

USE food_order;

CREATE TABLE partners (
	id int UNSIGNED primary key auto_increment,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE clients (
	id int UNSIGNED primary key auto_increment,
	phone char(12),
	fullname varchar(255)
);

CREATE TABLE positions (
	id int UNSIGNED primary key auto_increment,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES partners(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

CREATE TABLE orders (
	id int UNSIGNED primary key auto_increment,
	address varchar(255),
	latitude float,
	longtitude float,
	status ENUM("new", "accepted_by_the_restaurant", "on_delivery", "finished"),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES clients(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE position_orders(
	position_id int UNSIGNED NOT NULL,
	order_id int UNSIGNED NOT NULL,
	PRIMARY KEY (position_id, order_id),
	FOREIGN KEY (position_id) REFERENCES positions(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	FOREIGN KEY (order_id) REFERENCES orders(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

SHOW TABLES;

--Заполните базу тестовыми данными, не менее 3 партнеров, не менее 3 позиций для заказа у каждого из партнеров. 
--3 Пользователя, у каждого из которых от 1 до 5 заказов, в каждом из заказов от 1 до 3 позиций блюд

INSERT INTO partners (title, description, address)
VALUES ("Tau spa", "Находятся в горах", "г.Алматы, ул.Пушкина 10"),
		("abr", "Крупная сеть", "г.Астана, ул.Туран 5"),
		("Crudo", "Гриль на дровах", "г.Алматы, ул.Навои 104");

INSERT INTO positions (title, description, price, photo_url, partner_id)
VALUES ("Курица с овощами", "Курица с хрустящей корочкой, подается с овощами", 3500, "img/pic1.jpeg", 1),
		("Мятная форель", "Свежесловленная форель", 7500, "img/pic2.jpeg", 1),
		("Шашлыки из баранины", "Подается с лавашем и маринованным луком", 2500, "img/pic3.jpeg", 1),
		("Долма", "Слова излишни", 2400, "img/pic4.jpeg", 2),
		("Квас", "Ядренный квас - в самый раз в знойную жару", 1500, "img/pic5.jpeg", 2),
		("Филадельфия маки", "Девушки оценят", 4500, "img/pic6.jpeg", 2),
		("Дорадо на гриле", "Только вчера поймали", 8200, "img/pic7.jpeg", 3),
		("Тамогавк стейк", "Почувствуй себя Чунгачкуком", 10500, "img/pic8.jpeg", 3),
		("Рибай стейк", "Класика!", 6500, "img/pic9.jpeg", 3);

INSERT INTO clients (fullname, phone)
VALUES ("Магрипа Харрипулаевна","+77015555501"),
		("Тони Старк","+77017777777"),
		("Маверик Смит","+77273100555");

INSERT INTO orders (address, latitude, longtitude, status, client_id)
VALUES ("ЖК Европолис, г.Алматы, ул.Омарова 25, кв. 1", 100.15, 84.33, "new", 1),
		("г.Астана, проспект Победы 47, кв. 15", 15.45, 49.18, "finished", 2),
		("г.Астана, проспект Победы 47, кв. 15", 124.15, 94.33, "accepted_by_the_restaurant", 2),
		("ЖК Apple Town, г.Алматы, Сайна 10, кв. 104", 111.11, 184.73, "finished", 3),
		("ЖК Apple Town, г.Алматы, Сайна 10, кв. 104", 190.15, 84.89, "on_delivery", 3),
		("ЖК Apple Town, г.Алматы, Сайна 10, кв. 104", 215.15, 184.33, "new", 3);
	
INSERT INTO position_orders(position_id, order_id)
VALUES (1, 1),
		(6, 1),
		(4, 2),
		(5, 3),
		(2, 4),
		(7, 4),
		(8, 4),
		(3, 5),
		(9, 6),
		(1, 6);
	
--Напишите запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера

SELECT orders.id, clients.phone, partners.title
FROM position_orders
JOIN orders ON position_orders.order_id = orders.id
JOIN clients ON orders.client_id = clients.id
JOIN positions ON position_orders.position_id = positions.id
JOIN partners ON positions.partner_id = partners.id;

--Добавьте еще одного партнера и минимум 1 позицию для него. 
--Но не создавайте заказы. Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа

INSERT INTO partners (title, description, address)
VALUES ("Бочонок","Пиво, крабы, колбасы и многое другое","г.Астана, ул. Абая 58");

INSERT INTO positions (title, description, price, photo_url, partner_id)
VALUES ("Пиво", "Освежись нашим пивом!", 1500, "img/pic10.jpeg", 4);

SELECT partners.title, partners.description, partners.address
FROM positions
JOIN partners ON positions.partner_id = partners.id
WHERE positions.id NOT IN (SELECT position_orders.position_id FROM position_orders);

--Напишите запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа.

SELECT positions.title as "Название позиций"
FROM position_orders
JOIN orders ON position_orders.order_id = orders.id
JOIN clients ON orders.client_id = clients.id
JOIN positions ON position_orders.position_id = positions.id
WHERE clients.id = 1 AND orders.id = 1;