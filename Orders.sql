CREATE DATABASE order_food_service;
USE order_food_service;

#ЗАДАНИЕ 1
#Заполните базу тестовыми данными, не менее 3 партнеров, 
#не менее 3 позиций для заказа у каждого из партнеров. 
#3 Пользователя, у каждого из которых от 1 до 5 заказов, 
#в каждом из заказов от 1 до 3 позиций блюд

CREATE TABLE Partners(
	id int unsigned primary key auto_increment,
	title varchar(150) not null unique,
	description text,
	address varchar(255) not null
);

INSERT  Partners (title,description,address)
	VALUES ("Wolt","Good service","Abay 55"),("Glovo","Bad service","Zhandosov 77"),
	("Chocofood","Medium service","Gagarin 19")

CREATE TABLE Positions(
	id int unsigned primary key auto_increment,
	title varchar(255) not null,
	description text,
	price decimal(20,0) not null default 0,
	photo_url varchar(255),
	partner_id int unsigned not null,
	foreign key (partner_id) references Partners(id)
		on UPDATE cascade
		on DELETE restrict
)

INSERT Positions (title, description,price,partner_id) values
 ("Japan bowl","fish,rice,salat","1500",(SELECT id FROM Partners WHERE title = "Wolt")),
 ("Soup","Chicken,tomato","1300",(SELECT id FROM Partners WHERE title = "Wolt")),
 ("Doner","Doner","1500",(SELECT id FROM Partners WHERE title = "Wolt")),
 ("Burger","chicken,cheese","1100",(SELECT id FROM Partners WHERE title = "Glovo")),
 ("Fried chicken","chicken,rice","1700",(SELECT id FROM Partners WHERE title = "Glovo")),
 ("Japan bowl","fish,rice,salat","1300",(SELECT id FROM Partners WHERE title = "Glovo")),
 ("Sushi","fish,rice,souce","2000",(SELECT id FROM Partners WHERE title = "Chocofood")),
 ("beer","miller","800",(SELECT id FROM Partners WHERE title = "Chocofood")),
 ("Hotdog","bread,sausage","1400",(SELECT  id FROM Partners WHERE title = "Chocofood"))

CREATE TABLE Clients(
	id int unsigned primary key auto_increment,
	phone char(12),
	fullname varchar(255)
)

CREATE TABLE Orders(
	id int unsigned primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum("open","closed"),
	client_id int unsigned not null,
	foreign key (client_id) references Clients(id)
		on UPDATE cascade
		on DELETE restrict
)

CREATE TABLE Order_positions(
	order_id int unsigned not null,
	position_id int unsigned not null,
	primary key (order_id,position_id),
	foreign key (order_id) references Orders(id)
		on UPDATE CASCADE
		on DELETE restrict,
	foreign key (position_id) references Positions(id)
		on UPDATE cascade
		on DELETE cascade
)

 INSERT clients (phone,fullname) values
 ("+77071112321","John Jones"),
 ("+77071114321","Jack Miller"),
 ("+77071132123","Tom Noble")

 INSERT orders (created_at,address,status,client_id) values
(CURTIME(),"Gagarin 99","open",(SELECT id FROM Clients WHERE fullname = "John Jones")),
(CURTIME(),"Dostik 10","closed",(SELECT id FROM Clients WHERE fullname = "Jack Miller")),
(CURTIME(),"Dostik 10","open",(SELECT id FROM Clients WHERE fullname = "Jack Miller")),
(CURTIME(),"Abay 54","closed",(SELECT id FROM Clients WHERE fullname = "Tom Noble")),
(CURTIME(),"Abay 54","open",(SELECT id FROM Clients WHERE fullname = "Tom Noble")),
(CURTIME(),"Zholdasbekov 69","closed",(SELECT id FROM Clients WHERE fullname = "Tom Noble"))

INSERT Order_positions(order_id,position_id) values
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positions WHERE title = "Hotdog")),
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positions WHERE title = "Doner")),
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positions WHERE title = "fried chicken")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM positions WHERE title = "Doner")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM positions WHERE title = "Soup")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positions WHERE title = "Beer")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positions WHERE title = "Sushi")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positions WHERE title = "Soup")),
((SELECT id FROM Orders WHERE id = 4),(SELECT id FROM positions WHERE title = "Soup")),
((SELECT id FROM Orders WHERE id = 4),(SELECT id FROM positions WHERE title = "Hotdog")),
((SELECT id FROM Orders WHERE id = 4),(SELECT id FROM positions WHERE title = "Doner")),
((SELECT id FROM Orders WHERE id = 5),(SELECT id FROM positions WHERE title = "Hotdog")),
((SELECT id FROM Orders WHERE id = 6),(SELECT id FROM positions WHERE title = "Hotdog"))

#ЗАДАНИЕ 2
#Напишите запрос, который будет выводить 
#номера заказов (их ИД), 
#номер телефонов клиентов, 
#название партнера

SELECT
 	Orders.id, Clients.phone, Partners.title
FROM Orders 
JOIN Clients on Orders.client_id = Clients.id
JOIN Order_positions on Orders.id = Order_positions.order_id
JOIN Positions on Positions.id = Order_positions.position_id
JOIN Partners ON Partners.id = positions.partner_id

#ЗАДАНИЕ 3
#Добавьте еще одного партнера и минимум 1 позицию для него. 
#Но не создавайте заказы. Сделайте запрос, 
#который выведет таких партнеров, у которых еще не было ни одного заказа

INSERT Partners (title, description,address) values
("Yevgeniy","Only burgers","Zharokov 99")

 INSERT Positions (title, description,price,partner_id) values
 ("Big burger","meat, fish, chicken, mayo","4000",(select id from Partners where title = "Yevgeniy"))

 SELECT * FROM Partners
 WHERE partners.id not in
 (select partner_id FROM order_positions
 JOIN positions on Positions.id = Order_positions.position_id)


 #ЗАДАНИЕ 4
 #Напишите запрос, который по ID пользователя и ID заказа 
 #выведет названия всех позиций из этого заказа.

  SELECT positions.title FROM orders, positions, Order_positions
 	WHERE Order_positions.order_id = Orders.id
 	AND Order_positions.position_id = positions.id 
 	AND orders.id = 1
 	AND orders.client_id = 1
