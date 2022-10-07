CREATE DATABASE wolt;

use wolt;

#Create Partners table

create table Partners (
id int UNSIGNED primary key not null auto_increment,
title varchar(150) not null,
description text,
address varchar(255) not null
);

#---------------------------------


#Create Positions table 

create table Positions (
id int unsigned primary key not null auto_increment,
title varchar(255) not null,
description text, 
price int not null default(0),
phto_url varchar (256),
partner_id int unsigned not null,
foreign key (partner_id) references Partners(id)
on update cascade
on delete cascade
);

#---------------------------------


#Create Clients table 

create table Clients (
	id int unsigned primary key not null auto_increment,
	phone char(12),
	fullname varchar(256)
);

#---------------------------------


#Create Orders table 

create table Orders (
id int unsigned primary key not null auto_increment,
created_at datetime,
address varchar(255),
latitude float,
longitude float,
status ENUM("new", "accepted", "delivered", "completed"),
client_id int unsigned,
foreign key (client_id) references Clients (id) 
on update cascade 
on delete set null
)

#---------------------------------


#Create PositionsOrders table 

create table PositionsOrders (
position_id int unsigned, 
foreign key (position_id) references Positions(id),
order_id int unsigned, 
foreign key (order_id) references Orders(id)
);

#---------------------------------

# 1-Задание

insert Partners (title, description, address) values 
("LAVASH Food", "You can also order through LAVASH Food own delivery", "Сарайшық, 11а"),
("SF Shaurma Food","Time to eat","Сарайшык 5"),
("Kebab Haus","Turkish cafe","Коргальжинское шоссе 1, ТРЦ Keruen City, 3 этаж")


insert Positions (title ,description, price, phto_url, partner_id) values
("Комбо Бургер №1","Комбо Бургер (говяжий бургер + картофель фри + напиток на выбор 400 мл)", 1830 , "https://imageproxy.wolt.com/menu/menu-images/6200ea3195884ea6a34544e5/3cc656d6-3e1b-11ed-bbf3-8e5170fda980_whatsapp_image_2022_09_23_at_13.28.34.jpeg", 1),
("Комбо Бургер №2", "Комбо Бургер (куриный бургер + картофель фри + напиток на выбор 400 мл)", 1750 , "https://imageproxy.wolt.com/menu/menu-images/6200ea3195884ea6a34544e5/5296db42-3e1c-11ed-a236-32beb7103fd3_whatsapp_image_2022_09_23_at_13.28.34.jpeg", 1),
("Острая пицца «Халапеньо»","Сыр гауда, сыр моцарелла, фарш говядины, соленые огурцы, халапеньо, соус томатный", 2390 ,"https://imageproxy.wolt.com/menu/menu-images/61e82d50398d2a14cb913f18/e4bd29f0-827d-11ec-bad0-3e590efdc26a_11_2.jpeg", 1),
("Комбо 1","Куриный донер, картофель фри, Pepsi",2150,"https://imageproxy.wolt.com/menu/menu-images/6282442da6b9d675dac65e9c/a33ee8c2-d5ae-11ec-815a-ae7d1773659f_______1_________________1.5_________________.jpeg", 2),
("Восточный сет 1","Босо лагман на томате, лепешка и чашка чая",1990,"https://imageproxy.wolt.com/menu/menu-images/6296140ba52237827a52f873/6bf51f3e-38b0-11ed-a172-92f30a2f7301_______.jpeg",2),
("Восточный сет 2","Босо лагман на сое, лепешка и чашка чая",1990,"https://imageproxy.wolt.com/menu/menu-images/6296140ba52237827a52f873/7453b38e-38b0-11ed-a571-22ce6adbc2f9____.jpeg",2),
("Ганбян цомян","жаренный лагман из свежесваренное тесто собственного приготовления, полугорький перец, джусай, специи и соус, говядина, нарезано соломкой(острый)", 1800, "https://imageproxy.wolt.com/menu/menu-images/3530e4f6-1644-11ea-a403-0a586468f43c______________________.jpeg",3),
("Гуйру ганфан", "рис на пару, полугорький перец, пекинская капуста, лук, сельдерей, специи и соус, на выбор говядина или курица, крупная нарезка (слабо острый)", 1700, "https://imageproxy.wolt.com/menu/menu-images/5de7391e5fe1470a185c97ba/33b6e832-35f6-11eb-84c3-be7721a27120_930a0554.jpeg",3),
("Пельмени китайские жареные", "с говядиной, соуса на выбор 20 шт. или 30 шт.", 1750, "https://imageproxy.wolt.com/menu/menu-images/fc76f14e-19ab-11ea-929c-0a586469d635_____________________________.jpeg", 3)


insert Clients (phone, fullname) values
("+77471471474", "Денис Карамышев"),
("+77776541474", "Максим Дорофеев"),
("+77861479545", "Алпамыс Жарасов")

# new accepted delivered completed

insert Orders (created_at, address, latitude, longitude, status, client_id) values
(now(), "улица Ахмет Байтурсынулы, 17/2", 51.124249, 71.477304, "new", 1 ),
(now(), "​проспект Тауелсиздик, 21​", 51.142192, 71.460115, "accepted", 2 ),
(now(), "улица Иманова, 26", 51.164226, 71.443966, "delivered", 3 ),
(now(), "улица Ахмет Байтурсынулы, 17/2", 51.124249, 71.477304, "completed", 1);


insert PositionsOrders (position_id, order_id) values
((select id from Positions where title = "Комбо Бургер №1"), (select id from Orders where id = 1)),
((select id from Positions where title = "Комбо Бургер №2"), (select id from Orders where id = 1)),
((select id from Positions where title = "Острая пицца «Халапеньо»"), (select id from Orders where id = 1)),
((select id from Positions where title = "Комбо Бургер №1"), (select id from Orders where id = 1)),
((select id from Positions where title = "Комбо 1"), (select id from Orders where id = 2)),
((select id from Positions where title = "Восточный сет 1"), (select id from Orders where id = 2)),
((select id from Positions where title = "Восточный сет 2"), (select id from Orders where id = 2)),
((select id from Positions where title = "Ганбян цомян"), (select id from Orders where id = 3)),
((select id from Positions where title = "Гуйру ганфан"), (select id from Orders where id = 3)),
((select id from Positions where title = "Пельмени китайские жареные"), (select id from Orders where id = 3)),
((select id from Positions where title = "Ганбян цомян"), (select id from Orders where id = 3)),
((select id from Positions where title = "Гуйру ганфан"), (select id from Orders where id = 3)),
((select id from Positions where title = "Пельмени китайские жареные"), (select id from Orders where id = 4)),
((select id from Positions where title = "Гуйру ганфан"), (select id from Orders where id = 4)); 


# 2-Задание
select Orders.id , Clients.phone, Partners.title
from Orders  
left join Clients on Orders.client_id = Clients.id
left join PositionsOrders on Orders.id = PositionsOrders.order_id
left join Positions on PositionsOrders.position_id = Positions.id
left join Partners on Positions.partner_id = Partners.id;

# 3-Задание
insert Partners (title, description, address) values 
("Wok Lagman","Новый формат подачи национальных блюд","Kunayeva 35/1")

insert Positions (title ,description, price, phto_url, partner_id) values
("Рамен с говядиной","классическая корейская лапша с говядиной, бульоном и яйцом, подается с салатом из белой редьки \"дайкон\" с добавлением перечного соуса", 2000 ,"https://imageproxy.wolt.com/menu/menu-images/5de7391e5fe1470a185c97ba/c8d67296-58ad-11eb-9b82-663f7f1287f0_930a0783.jpeg", 4)

select * from Partners where Partners.id not in (select partner_id from Positions, PositionsOrders where Positions.id = PositionsOrders.position_id);

# 4-Задание
select Orders.id, Positions.title from Orders, Positions, PositionsOrders
where Orders.id = PositionsOrders.order_id 
and PositionsOrders.position_id = Positions.id  
and Orders.id = 1 
and Orders.client_id = 1





