create database order_food_service;
use order_food_service;

#ЗАДАНИЕ 1
#Заполните базу тестовыми данными, не менее 3 партнеров, 
#не менее 3 позиций для заказа у каждого из партнеров. 
#3 Пользователя, у каждого из которых от 1 до 5 заказов, 
#в каждом из заказов от 1 до 3 позиций блюд

create table Partners(
	id int unsigned primary key auto_increment,
	title varchar(150) not null unique,
	description text,
	address varchar(255) not null
);

insert into Partners (title,description,address)
	values ("Wolt","Good service","Abay 55"),("Glovo","Bad service","Zhandosov 77"),
	("Chocofood","Medium service","Gagarin 19")
	
	create table Positions(
	id int unsigned primary key auto_increment,
	title varchar(255) not null,
	description text,
	price decimal(20,0) not null default 0,
	photo_url varchar(255),
	partner_id int unsigned not null,
	foreign key (partner_id) references Partners(id)
		on update cascade
		on delete restrict
)	

insert into Positions (title, description,price,partner_id) values
 ("Japan bowl","fish,rice,salat","1500",(select id from Partners where title = "Wolt")),
 ("Soup","Chicken,tomato","1300",(select id from Partners where title = "Wolt")),
 ("Doner","Doner","1500",(select id from Partners where title = "Wolt")),
 ("Burger","chicken,cheese","1100",(select id from Partners where title = "Glovo")),
 ("Fried chicken","chicken,rice","1700",(select id from Partners where title = "Glovo")),
 ("Japan bowl","fish,rice,salat","1300",(select id from Partners where title = "Glovo")),
 ("Sushi","fish,rice,souce","2000",(select id from Partners where title = "Chocofood")),
 ("beer","miller","800",(select id from Partners where title = "Chocofood")),
 ("Hotdog","bread,sausage","1400",(select id from Partners where title = "Chocofood"))
 
 create table Clients(
	id int unsigned primary key auto_increment,
	phone char(12),
	fullname varchar(255)
)	

create table Orders(
	id int unsigned primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum("open","closed"),
	client_id int unsigned not null,
	foreign key (client_id) references Clients(id)
		on update cascade
		on delete restrict
)	

create table Order_positions(
	order_id int unsigned not null,
	position_id int unsigned not null,
	primary key (order_id,position_id),
	foreign key (order_id) references Orders(id)
		on update cascade
		on delete restrict,
	foreign key (position_id) references Positions(id)
		on update cascade
		on delete cascade	
)

 insert into clients (phone,fullname) values
 ("+77071112321","John Jones"),
 ("+77071114321","Jack Miller"),
 ("+77071132123","Tom Noble")
 
 insert into orders (created_at,address,status,client_id) values
(CURTIME(),"Gagarin 99","open",(select id from Clients where fullname = "John Jones")),
(CURTIME(),"Dostik 10","closed",(select id from Clients where fullname = "Jack Miller")),
(CURTIME(),"Dostik 10","open",(select id from Clients where fullname = "Jack Miller")),
(CURTIME(),"Abay 54","closed",(select id from Clients where fullname = "Tom Noble")),
(CURTIME(),"Abay 54","open",(select id from Clients where fullname = "Tom Noble")),
(CURTIME(),"Zholdasbekov 69","closed",(select id from Clients where fullname = "Tom Noble"))

insert into Order_positions(order_id,position_id) values
((select id from Orders where id = 1),(select id from positions where title = "Hotdog")),
((select id from Orders where id = 1),(select id from positions where title = "Doner")),
((select id from Orders where id = 1),(select id from positions where title = "fried chicken")),
((select id from Orders where id = 2),(select id from positions where title = "Doner")),
((select id from Orders where id = 2),(select id from positions where title = "Soup")),
((select id from Orders where id = 3),(select id from positions where title = "Beer")),
((select id from Orders where id = 3),(select id from positions where title = "Sushi")),
((select id from Orders where id = 3),(select id from positions where title = "Soup")),
((select id from Orders where id = 4),(select id from positions where title = "Soup")),
((select id from Orders where id = 4),(select id from positions where title = "Hotdog")),
((select id from Orders where id = 4),(select id from positions where title = "Doner")),
((select id from Orders where id = 5),(select id from positions where title = "Hotdog")),
((select id from Orders where id = 6),(select id from positions where title = "Hotdog"))

#ЗАДАНИЕ 2
#Напишите запрос, который будет выводить 
#номера заказов (их ИД), 
#номер телефонов клиентов, 
#название партнера

SELECT
 	Orders.id, Clients.phone, Partners.title
from Orders 
join Clients on Orders.client_id = Clients.id
join Order_positions on Orders.id = Order_positions.order_id
join Positions on Positions.id = Order_positions.position_id
join Partners on Partners.id = positions.partner_id

#ЗАДАНИЕ 3
#Добавьте еще одного партнера и минимум 1 позицию для него. 
#Но не создавайте заказы. Сделайте запрос, 
#который выведет таких партнеров, у которых еще не было ни одного заказа

insert into Partners (title, description,address) values
("Yevgeniy","Only burgers","Zharokov 99")

 insert into Positions (title, description,price,partner_id) values
 ("Big burger","meat, fish, chicken, mayo","4000",(select id from Partners where title = "Yevgeniy"))

  select * from Partners
 where partners.id not in 
 (select partner_id from order_positions
 join positions on Positions.id = Order_positions.position_id)

 
 #ЗАДАНИЕ 4
 #Напишите запрос, который по ID пользователя и ID заказа 
 #выведет названия всех позиций из этого заказа.
 
  select positions.title from orders, positions, Order_positions
 	where Order_positions.order_id = Orders.id
 	and Order_positions.position_id = positions.id 
 	and orders.id = 1
 	and orders.client_id = 1
 

