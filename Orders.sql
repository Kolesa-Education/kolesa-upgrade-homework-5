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
	VALUES ("Wolt","Неплохой сервис и доставка","Аблайхана 100"),
    ("Glovo","Ниже среднего","Саина 290"),
	("Chocofood","Пойдет иногда","Гага 2020")

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
 ("Лепешка","Плов, салат","1500",(SELECT id FROM Partners WHERE title = "Wolt")),
 ("Суп","Овощи,рис","1300",(SELECT id FROM Partners WHERE title = "Wolt")),
 ("Донер","Донер, айран","1500",(SELECT id FROM Partners WHERE title = "Wolt")),
 ("Бургер","Хот дог","1100",(SELECT id FROM Partners WHERE title = "Glovo")),
 ("Хот дог","хлеб, лук","1700",(SELECT id FROM Partners WHERE title = "Glovo")),
 ("Суп","Картошка фри","1300",(SELECT id FROM Partners WHERE title = "Glovo")),
 ("Суши","Рыба,рис","2000",(SELECT id FROM Partners WHERE title = "Chocofood")),
 ("Коктейль","Водка с пивом","800",(SELECT id FROM Partners WHERE title = "Chocofood")),
 ("Коктейль","Пиво без водки","1400",(SELECT  id FROM Partners WHERE title = "Chocofood"))

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
 ("+77071112321","Артур Пирогов"),
 ("+77071114321","Насыр Булат"),
 ("+77071132123","Хабиб Нурма")

 INSERT orders (created_at,address,status,client_id) values
(CURTIME(),"Гагарин Парк 200","open",(SELECT id FROM Clients WHERE fullname = "Артур Пирогов")),
(CURTIME(),"Мега Парк 100","closed",(SELECT id FROM Clients WHERE fullname = "Хабиб Нурма")),
(CURTIME(),"Абай 500","open",(SELECT id FROM Clients WHERE fullname = "Артур Пирогов")),
(CURTIME(),"Саина 290","closed",(SELECT id FROM Clients WHERE fullname = "Хабиб Нурма")),
(CURTIME(),"Дом с бассейном 22","open",(SELECT id FROM Clients WHERE fullname = "Насыр Булат")),
(CURTIME(),"Саина 122","closed",(SELECT id FROM Clients WHERE fullname = "Насыр Булат"))

INSERT Order_positions(order_id,position_id) values
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positions WHERE title = "Хот дог")),
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positions WHERE title = "Донер")),
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positions WHERE title = "Суп")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM positions WHERE title = "Донер")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM positions WHERE title = "Суп")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positions WHERE title = "Коктейль")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positions WHERE title = "Суши")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positions WHERE title = "Бургер")),
((SELECT id FROM Orders WHERE id = 4),(SELECT id FROM positions WHERE title = "Суп")),
((SELECT id FROM Orders WHERE id = 4),(SELECT id FROM positions WHERE title = "Хот дог")),
((SELECT id FROM Orders WHERE id = 4),(SELECT id FROM positions WHERE title = "Донер")),
((SELECT id FROM Orders WHERE id = 5),(SELECT id FROM positions WHERE title = "Хот дог")),
((SELECT id FROM Orders WHERE id = 6),(SELECT id FROM positions WHERE title = "Хот дог"))

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
("Джон","Хот дог","Гоголь 22")

 INSERT Positions (title, description,price,partner_id) values
 ("Бургер","салат с мясомgi","4000",(select id from Partners where title = "Джон"))

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
