create database foodOrderingService;

use foodOrderingService;

create table partners (
	id int unsigned primary key auto_increment,
	title varchar(150) not null unique,
	description text,
	adress varchar(255) not null
);

insert into partners(title, description, adress) 
values
	("Zhekas", "doner house", "Abaya 150"),
	("Gippo", "burgers", "Satpayeva 45"),
	("Ozyurt", "turkish food", "Atakent");

select * from partners;

create table clients (
	id int unsigned primary key auto_increment,
	phone char(12),
	fullname varchar(255)
);

insert into clients(phone, fullname)
values
	("+77055555555", "Ivan Ivanov"),
	("+77011111111", "Petr Petrov"),
	("+77066666666", "Anuar Nurgozin");

select * from clients;

create table positions(
	id int unsigned primary key auto_increment,
	title varchar(255) not null,
	description text,
	price int not null default(0),
	photo_url varchar(255),
	partner_id int unsigned not null,
	foreign key(partner_id) references partners(id)
		on update cascade
		on delete restrict
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Chicken doner",
	"doner with chicken",
	1200,
	"https://www.instagram.com/zhekas_doner_house/",
	(select id from partners where title="Zhekas")
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Kombo doner",
	"doner, cola, fries",
	2000,
	"https://www.instagram.com/zhekas_doner_house/",
	(select id from partners where title="Zhekas")
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Plov",
	"plov with meat",
	1600,
	"https://www.instagram.com/zhekas_doner_house/",
	(select id from partners where title="Zhekas")
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Sandwich",
	"9 mini sandwiches",
	1000,
	"https://gippo.kz/",
	(select id from partners where title="Gippo")
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Burger",
	"burger",
	800,
	"https://gippo.kz/",
	(select id from partners where title="Gippo")
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Combo burger",
	"burger with cola",
	1800,
	"https://gippo.kz/",
	(select id from partners where title="Gippo")
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Salad",
	"Salad with chicken",
	1000,
	"https://ozyurt.kz/en/menu",
	(select id from partners where title="Ozyurt")
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Kebab",
	"Kebab with meat",
	1500,
	"https://ozyurt.kz/en/menu",
	(select id from partners where title="Ozyurt")
);

insert into positions(title, description, price, photo_url, partner_id) values(
	"Pide",
	"Cheese pide",
	2500,
	"https://ozyurt.kz/en/menu",
	(select id from partners where title="Ozyurt")
);

select * from positions;

create table orders (
	id int unsigned primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum ("new", "adopted", "delivered", "completed"),
	client_id int unsigned not null,
	foreign key (client_id) references clients(id)
		on update cascade
		on delete cascade
);

create table positions_orders (
	position_id int unsigned not null,
	order_id int unsigned not null,
	primary key (position_id, order_id),
	foreign key (position_id) references positions(id)
		on update cascade
		on delete cascade,
	foreign key (order_id) references orders(id)
		on update cascade
		on delete cascade
)

insert into orders(created_at, address, latitude, longitude, status, client_id)
values 
	("2022-10-01 13:59:59", "Zharokova 252", 55.7, 35.7, "completed", 1),
	("2022-10-07 11:59:59", "Zharokova 252", 55.7, 35.7, "adopted", 1),
	("2022-09-01 17:59:59", "Zharokova 252", 55.7, 35.7, "completed", 1),
	("2022-09-05 16:35:39", "Al-farabi 71", 30.7, 60.7, "completed", 2),
	("2022-10-07 11:35:39", "Al-farabi 71", 30.7, 60.7, "new", 2),
	("2022-09-08 20:20:29", "Tole bi 55", 100.7, 85.7, "completed", 3),
	("2022-10-07 10:10:29", "Tole bi 55", 100.7, 85.7, "delivered", 3),
	("2022-10-05 20:10:29", "Tole bi 55", 100.7, 85.7, "adopted", 3);

select * from orders;

insert into positions_orders(position_id, order_id) select 1, id from orders where id=2;
insert into positions_orders(position_id, order_id) select 2, id from orders where id=3 or id=4;
insert into positions_orders(position_id, order_id) select 3, id from orders where id=5;
insert into positions_orders(position_id, order_id) select 2, id from orders where id=5;
insert into positions_orders(position_id, order_id) select 4, id from orders where id=1 or id=8;
insert into positions_orders(position_id, order_id) select 7, id from orders where id=7;
insert into positions_orders(position_id, order_id) select 8, id from orders where id=7;
insert into positions_orders(position_id, order_id) select 9, id from orders where id=6;

select * from positions_orders;

select orders.id, clients.phone, partners.title
from orders
inner join clients on orders.client_id=clients.id
inner join positions_orders on orders.id=positions_orders.order_id
inner join positions on positions_orders.position_id=positions.id
inner join partners on positions.partner_id=partners.id

insert into partners(title, description, adress) 
values("Nandoo", "korean food", "Altynsarina 88")

insert into positions(title, description, price, photo_url, partner_id) values(
	"Ramen",
	"Ramen with chicken",
	1000,
	"https://nandoo.kz/",
	(select id from partners where title="Nandoo")
);

select partners.title, count(order_id) as count_order
from partners
left join positions on partners.id=positions.partner_id
left join positions_orders on positions.id=positions_orders.position_id
group by partners.title
having count_order=0

select positions.title
from positions
inner join positions_orders on positions.id=positions_orders.position_id
inner join orders on positions_orders.order_id=orders.id
where client_id=1 and order_id=2




