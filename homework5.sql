CREATE database kolesa;

USE kolesa;

CREATE TABLE partners (
	id bigint UNSIGNED NOT NULL primary key auto_increment, 
	title varchar(150) NOT NULL, 
	description text,
	address varchar(255) NOT NULL
);


CREATE TABLE positions (
	id bigint UNSIGNED NOT NULL primary key auto_increment,
	title varchar(255) NOT NULL,
	description text,
	price int not null default(0),
	photo_url varchar(255),
	partner_id bigint unsigned not null,
	FOREIGN KEY (partner_id) references partners(id)
		ON UPDATE cascade
		ON DELETE restrict
);


CREATE TABLE clients (
	id bigint UNSIGNED NOT NULL primary key auto_increment,
	phone char(12),
	fullname varchar(255)
);

CREATE TABLE orders (
	id bigint UNSIGNED NOT NULL primary key auto_increment,
	created_at DATETIME,
	address varchar(255),
	latitude float,
	longitude float,
	status ENUM("new", "accepted", "delivering", "completed"),
	client_id bigint unsigned not null,
	FOREIGN KEY (client_id) references clients (id)
		ON UPDATE cascade
		ON DELETE restrict
);

CREATE TABLE orders_positions (
	orders_id bigint UNSIGNED NOT NULL,
	positions_id bigint  UNSIGNED NOT NULL,
	PRIMARY KEY (orders_id, positions_id),
	FOREIGN KEY (orders_id) references orders(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (positions_id) references positions(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

-- 1. Заполните базу тестовыми данными, не менее 3 партнеров, не менее 3 позиций для заказа у каждого из партнеров. 3 Пользователя, у каждого из которых от 1 до 5 заказов, в каждом из заказов от 1 до 3 позиций блюд

INSERT INTO partners (title, description, address) 
VALUES 
	 ("MAKI MAKI", "Sushi place", "Almaty, 8-02-32"),
	 ("Pizza Hut", "Pizza Place", "Almaty, 22-32-03"),
	 ("Burger", "Burger Place", "Almaty, 23-23-23");

INSERT INTO positions (title, description, price, photo_url, partner_id) 
VALUES
	 ("100 Sushi", "Best 100 sushi", 100000, "https://media.istockphoto.com/photos/all-you-can-eat-sushi-picture-id1053854126", 1),
	 ("20 Sushi", "Best 20 sushi", 10000, "https://media.istockphoto.com/photos/all-you-can-eat-sushi-picture-id1053854126", 1),
	 ("10 Sushi", "Best 10 sushi", 1000, "https://media.istockphoto.com/photos/all-you-can-eat-sushi-picture-id1053854126", 1),
	 ("100 Pizza", "Best 100 pizza", 100000, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS__wdDNN3xROKuS6qG69X3NysCAPfQd6Y776QXQ6vV6Q&s", 2),
	 ("20 Pizza", "Best 20 sushi", 10000, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS__wdDNN3xROKuS6qG69X3NysCAPfQd6Y776QXQ6vV6Q&s", 2),
	 ("10 Pizza", "Best 10 sushi", 1000, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS__wdDNN3xROKuS6qG69X3NysCAPfQd6Y776QXQ6vV6Q&s", 2),
	 ("100 Burger", "Best 100 burger", 100000, "https://www.100burger.com/100burgers", 3),
	 ("20 Burger", "Best 20 burger", 10000, "https://www.100burger.com/100burgers", 3),
	 ("10 Burger", "Best 10 pizza", 1000, "https://www.100burger.com/100burgers", 3);

INSERT INTO clients (phone, fullname) 
VALUES 
	("87075566544", "Zhuldyz Namazbayeva"),
	("87077777777", "Alikhan Kaliyev"),
	("87077277777", "Rihanna Fenty");

INSERT INTO orders (created_at, address, latitude, longitude,status, client_id) 
VALUES
  (NOW(), "Almaty, 8-01-32", 0.1, 0.2, "new", 1),
  (NOW(), "Almaty, 8-22-32", 0.3, 0.4, "new", 2),
  (NOW(), "Almaty, 8-92-32", 0.5, 0.6, "new", 3);
 
INSERT INTO orders_positions (positions_id, orders_id) 
VALUES 
	(1,1), (1,2), (1,3),
	(2,1), (4,2), (3,3),
	(9,1), (2,2), (4,3),
	(8,1), (7,2), (5,3);

-- 2. Напишите запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера

select orders.id, clients.phone, partners.title 
from orders_positions
join orders on orders_positions.orders_id  = orders.id 
join positions on orders_positions.positions_id  = positions.id 
join clients on orders.client_id = clients.id
join partners on positions.partner_id = partners.id;

-- 3. Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы.

INSERT INTO partners (title, description, address)
VALUES 
	("Ramen", "Super ramens", "Almaty, 28-92-20");


 INSERT INTO positions (title, description, price, photo_url, partner_id)
 VALUES 
	("Ichigaku Ramen", "Naruto Ramen", 15000, "https://www.ramen.com/100ramen", 4);

--  Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа

 SELECT partners.id, partners.title, partners.description from partners 
 join positions on positions.partner_id = partners.id
 where positions.id not in 
 	(SELECT positions_id from orders_positions);
 	
-- 4. Напишите запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа.
 
SELECT positions.title from orders
join orders_positions on orders.id = orders_positions.orders_id
join clients on orders.client_id = clients.id
join positions on orders_positions.positions_id = positions.id
where clients.id = 1 and orders.id = 1;

