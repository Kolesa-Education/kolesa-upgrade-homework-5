/*Создаём Бд и таблицы*/
CREATE DATABASE food_delivery;
use food_delivery;
CREATE TABLE Partners (
    id INT PRIMARY KEY auto_increment not NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    address varchar(255) not NULL
);
create table Positions(
id INT PRIMARY KEY auto_increment not null,
title VARCHAR(255) NOT null,
description TEXT,
price int not null default(0),
photo_url varchar(255),
partner_id int,
	foreign key (partner_id) references Partners(id)
		on update cascade
		on delete restrict
);
CREATE TABLE Clients (
    id INT PRIMARY KEY auto_increment not NULL,
	phone char(12),
	fullname varchar(255)
);
create table Orders(
	id int primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum("new","accepted","in progress","done"),
	client_id int,
	foreign key (client_id) references Clients(id)
		on update cascade
		on delete restrict
);
 /*Спасибо обсуждению в телеге за эту таблицу :) */
create table position_orders(
	order_id int,
	position_id int,
	foreign key (order_id) references Orders(id)
		on update cascade
		on delete restrict,
	foreign key (position_id) references Positions(id)
		on update cascade
		on delete cascade	
);
/*Заполняем значениями*/
insert into Partners (title,description,address)
	values ("McDonald's","For junk food enjoyers","Tole-bi, 132"),("Nedelka","Eat&Chill","Abay, 77"),
	("Angel In Us","Coffee&Food after work","Nazarbayev, 226");	
insert into Positions (title, description,price,partner_id) values
 ("BigMac","Average junk stuff","2000",(select id from Partners where title = "McDonald's")),
 ("Royal Cheesburger","More expensive junk stuff","2500",(select id from Partners where title = "McDonald's")),
 ("Fries","PotatoPotatooo","500",(select id from Partners where title = "McDonald's")),
 ("Цезарь с курицей","Куриное филе с тёртым сыром и обощами","2800",(select id from Partners where title = "Nedelka")),
 ("Облепиховый чай","Чёрный чай с облепихой","1800",(select id from Partners where title = "Nedelka")),
 ("Панини","Сэндвич с тунцом и овощами","1500",(select id from Partners where title = "Nedelka")),
 ("Раф медовый","Эспрессо со сливками и мёдом","1200",(select id from Partners where title = "Angel In Us")),
 ("Матча чай","Японский порошковый чай","1000",(select id from Partners where title = "Angel In Us")),
 ("Тирамису","Итальянское пирожное","2000",(select id from Partners where title = "Angel In Us"));
 insert into Clients (phone,fullname) values
 ("+78005553535","Андрей Шабалин"),
 ("+77072119034","Gyro Zeppeli"),
 ("+77714010218","Ертай Сарбасов");
 insert into Orders (created_at,address,status,client_id) values
(SYSDATE(),"Nazarbayev, 228","new",(select id from Clients where fullname = "Андрей Шабалин")),
(SYSDATE(),"Abay 44, ","accepted",(select id from Clients where fullname = "Андрей Шабалин")),
(SYSDATE(),"Al-Farabi, 140","in progress",(select id from Clients where fullname = "Gyro Zeppeli")),
(SYSDATE(),"Abylai Khan, 1","done",(select id from Clients where fullname = "Gyro Zeppeli")),
(SYSDATE(),"Zhibek-Zholy, 70","done",(select id from Clients where fullname = "Ертай Сарбасов")),
(SYSDATE(),"Tole-bi, 10","in progress",(select id from Clients where fullname = "Ертай Сарбасов"));
 insert into position_orders(order_id,position_id) values
((select id from Orders where id = 1),(select id from Positions where title = "Тирамису")),
((select id from Orders where id = 1),(select id from Positions where title = "Раф медовый")),
((select id from Orders where id = 1),(select id from Positions where title = "Панини")),
((select id from Orders where id = 2),(select id from Positions where title = "Панини")),
((select id from Orders where id = 2),(select id from Positions where title = "Облепиховый чай")),
((select id from Orders where id = 3),(select id from Positions where title = "Цезарь с курицей")),
((select id from Orders where id = 3),(select id from Positions where title = "Матча чай")),
((select id from Orders where id = 3),(select id from Positions where title = "Тирамису")),
((select id from Orders where id = 4),(select id from Positions where title = "Матча чай")),
((select id from Orders where id = 4),(select id from Positions where title = "BigMac")),
((select id from Orders where id = 5),(select id from Positions where title = "Fries")),
((select id from Orders where id = 5),(select id from Positions where title = "Royal Cheesburger")),
((select id from Orders where id = 6),(select id from Positions where title = "Цезарь с курицей"));


/*
Задание 2
Запрос вывода номера заказов, телефона клиентов и названия партнеров
*/
SELECT
 	Orders.id as "Номер заказа", 
 	Clients.phone as "Телефон клиента", 
 	Partners.title as "Партнёр"
from Orders,Clients,position_orders,Positions,partners
where Orders.client_id = Clients.id
and Orders.id = position_orders.order_id
and Positions.id = position_orders.position_id
and Partners.id = Positions.partner_id;
/*Можно ещё через джоины, но через where мне кажется по красивее*/
SELECT
 	Orders.id as "Номер заказа",
 	Clients.phone as "Телефон клиента",
 	Partners.title as "Партнёр"
from Orders
join position_orders  
on Orders.id = position_orders.order_id
join Positions 
on Positions.id = position_orders.position_id
join Clients
on Orders.client_id = Clients.id
join partners
on Partners.id = Positions.partner_id;
/*
 Задание 3
 Создаю позицию с пустым заказом и вывожу его
 */
insert into Partners (title, description,address) values
("Bahandi","Better than McD","Abylai Khan, 80");
insert into Positions (title, description,price,partner_id) values
 ("Tasty Delicios Burger","suppose to be meat,salad, tomato,","2000",(select id from Partners where title = "Bahandi"));
 select * from Partners
 where partners.id not in 
 (select partner_id from position_orders, Positions where Positions.id = position_orders.position_id);
 /*
  Задание 4
  Вывести названия всех позиций заказа 
  */
  select Positions.title from Orders, Positions, position_orders
 	where position_orders.order_id = Orders.id
 	and position_orders.position_id = Positions.id 
 	and Orders.id = 20 /*Ввести id заказа*/
 	and Orders.client_id = 1; /*Ввести id клиента*/
