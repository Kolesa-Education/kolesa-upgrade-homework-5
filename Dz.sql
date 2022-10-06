/*Создаём Бд и таблицы*/
CREATE DATABASE food_delivery;

use food_delivery;

CREATE TABLE Partners (
    id INT PRIMARY KEY auto_increment not NULL,
    title VARCHAR(150) NOT NULL,
    descriptiON TEXT,
    address varchar(255) not NULL
);

CREATE TABLE PositiONs(
id INT PRIMARY KEY auto_increment not null,
title VARCHAR(255) NOT null,
descriptiON TEXT,
price int not null default(0),
photo_url varchar(255),
partner_id int,
	foreign key (partner_id) references Partners(id)
		ON update cascade
		ON delete restrict
);

CREATE TABLE Clients (
    id INT PRIMARY KEY auto_increment not NULL,
	phONe char(12),
	fullname varchar(255)
);
CREATE TABLE Orders(
	id int primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	lONgitude float,
	status enum("new","accepted","in progress","dONe"),
	client_id int,
	foreign key (client_id) references Clients(id)
		ON update cascade
		ON delete restrict
)

 /*Спасибо обсуждению в телеге за эту таблицу :) */
CREATE TABLE positiON_orders(
	order_id int,
	positiON_id int,
	foreign key (order_id) references Orders(id)
		ON update cascade
		ON delete restrict,
	foreign key (positiON_id) references PositiONs(id)
		ON update cascade
		ON delete cascade	
)


/*Заполняем значениями*/

INSERT INTO Partners (title,descriptiON,address)
	values ("McDONald's","For junk food enjoyers","Tole-bi, 132"),("Nedelka","Eat&Chill","Abay, 77"),
	("Angel In Us","Coffee&Food after work","Nazarbayev, 226")
	
INSERT INTO PositiONs (title, descriptiON,price,partner_id) values
 ("BigMac","Average junk stuff","2000",(SELECT id FROM Partners WHERE title = "McDONald's")),
 ("Royal Cheesburger","More expensive junk stuff","2500",(SELECT id FROM Partners WHERE title = "McDONald's")),
 ("Fries","PotatoPotatooo","500",(SELECT id FROM Partners WHERE title = "McDONald's")),
 ("Цезарь с курицей","Куриное филе с тёртым сыром и обощами","2800",(SELECT id FROM Partners WHERE title = "Nedelka")),
 ("Облепиховый чай","Чёрный чай с облепихой","1800",(SELECT id FROM Partners WHERE title = "Nedelka")),
 ("Панини","Сэндвич с тунцом и овощами","1500",(SELECT id FROM Partners WHERE title = "Nedelka")),
 ("Раф медовый","Эспрессо со сливками и мёдом","1200",(SELECT id FROM Partners WHERE title = "Angel In Us")),
 ("Матча чай","Японский порошковый чай","1000",(SELECT id FROM Partners WHERE title = "Angel In Us")),
 ("Тирамису","Итальянское пирожное","2000",(SELECT id FROM Partners WHERE title = "Angel In Us"))
 
INSERT INTO clients (phONe,fullname) values
 ("+78005553535","Андрей Шабалин"),
 ("+77072119034","Gyro Zeppeli"),
 ("+77714010218","Ертай Сарбасов")
 
INSERT INTO orders (created_at,address,status,client_id) values
(SYSDATE(),"Nazarbayev, 228","new",(SELECT id FROM Clients WHERE fullname = "Андрей Шабалин")),
(SYSDATE(),"Abay 44, ","accepted",(SELECT id FROM Clients WHERE fullname = "Андрей Шабалин")),
(SYSDATE(),"Al-Farabi, 140","in progress",(SELECT id FROM Clients WHERE fullname = "Gyro Zeppeli")),
(SYSDATE(),"Abylai Khan, 1","dONe",(SELECT id FROM Clients WHERE fullname = "Gyro Zeppeli")),
(SYSDATE(),"Zhibek-Zholy, 70","dONe",(SELECT id FROM Clients WHERE fullname = "Ертай Сарбасов")),
(SYSDATE(),"Tole-bi, 10","in progress",(SELECT id FROM Clients WHERE fullname = "Ертай Сарбасов"))
 
INSERT INTO positiON_orders(order_id,positiON_id) values
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positiONs WHERE title = "Тирамису")),
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positiONs WHERE title = "Раф медовый")),
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM positiONs WHERE title = "Панини")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM positiONs WHERE title = "Панини")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM positiONs WHERE title = "Облепиховый чай")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positiONs WHERE title = "Цезарь с курицей")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positiONs WHERE title = "Матча чай")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM positiONs WHERE title = "Тирамису")),
((SELECT id FROM Orders WHERE id = 4),(SELECT id FROM positiONs WHERE title = "Матча чай")),
((SELECT id FROM Orders WHERE id = 4),(SELECT id FROM positiONs WHERE title = "BigMac")),
((SELECT id FROM Orders WHERE id = 5),(SELECT id FROM positiONs WHERE title = "Fries")),
((SELECT id FROM Orders WHERE id = 5),(SELECT id FROM positiONs WHERE title = "Royal Cheesburger")),
((SELECT id FROM Orders WHERE id = 6),(SELECT id FROM positiONs WHERE title = "Цезарь с курицей"))


/*
Задание 2
Запрос вывода номера заказов, телефона клиентов и названия партнеров
*/
SELECT
 	Orders.id as "Номер заказа", 
 	Clients.phONe as "Телефон клиента", 
 	Partners.title as "Партнёр"
FROM Orders,clients,positiON_orders,positiONs,partners
WHERE Orders.client_id = Clients.id
AND Orders.id = positiON_orders.order_id
AND PositiONs.id = positiON_orders.positiON_id
AND Partners.id = positiONs.partner_id

/*Можно ещё через джоины, но через WHERE мне кажется по красивее*/

SELECT
 	Orders.id as "Номер заказа",
 	Clients.phONe as "Телефон клиента",
 	Partners.title as "Партнёр"
FROM Orders
JOIN positiON_orders  
ON Orders.id = positiON_orders.order_id
JOIN PositiONs 
ON PositiONs.id = positiON_orders.positiON_id
JOIN clients
ON Orders.client_id = Clients.id
JOIN partners
ON Partners.id = positiONs.partner_id


/*
 Задание 3
 Создаю позицию с пустым заказом и вывожу его
 */
INSERT INTO Partners (title, descriptiON,address) values
("BahANDi","Better than McD","Abylai Khan, 80")

INSERT INTO PositiONs (title, descriptiON,price,partner_id) values
 ("Tasty Delicios Burger","suppose to be meat,salad, tomato,","2000",(SELECT id FROM Partners WHERE title = "BahANDi"))
 
 SELECT * FROM Partners
 WHERE partners.id not in 
 (SELECT partner_id FROM positiON_orders, positiONs WHERE PositiONs.id = positiON_orders.positiON_id)
 
 /*
  Задание 4
  Вывести названия всех позиций заказа 
  */
  SELECT positiONs.title FROM orders, positiONs, positiON_orders
 	WHERE positiON_orders.order_id = Orders.id
 	AND positiON_orders.positiON_id = positiONs.id 
 	AND orders.id = 1 /*Ввести id заказа*/
 	AND orders.client_id = 1 /*Ввести id клиента*/
 	