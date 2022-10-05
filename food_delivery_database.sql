create database food_delivery;

use food_delivery;

create table partners (
	id int unsigned primary key auto_increment,
	title varchar(150) not null unique,
	description text,
	address varchar(255)
);

create table positions (
	id int unsigned primary key auto_increment,
	title varchar(255) not null unique,
	description text,
	price int not null default(0),
	photo_url varchar(255),
	partner_id int unsigned,
	foreign key (partner_id) references partners(id)
		on update cascade
		on delete restrict
);

create table clients(
	id int unsigned primary key auto_increment,
	phone char(12) not null unique,
	fullname varchar(255)
);

create table orders (
	id int unsigned primary key auto_increment,
	created_at timestamp not null default(now()),
	address varchar(255) default(0),
	latitude float default(0),
	longtitude float default(0), 
	status enum ("new order", "order accepted", "in progress", "completed"),
	client_id int unsigned not null,
	foreign key (client_id) references clients(id)
		on update cascade
		on delete restrict
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
		on delete restrict
);

-- 1
insert into partners (title, description, address) 
values 
 ("Kakao Dak", "Cafe", "Gagarin street 454"), 
 ("Chechil", "Pub", "Zharokov street 283"),
 ("Svet", "Restaurant", "Abylai Khan street 144");

insert into positions (title, description, price, photo_url, partner_id) values (
	"Kimpab", "Korean rolls", "1800", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Kakao Dak")
);

insert into positions (title, description, price, photo_url, partner_id) values (
	"Kimchi", "Peking cabbage in hot sauce", "700", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Kakao Dak")
);

insert into positions (title, description, price, photo_url, partner_id) values (
	"Kimchi-tige", "Korean spicy soup with rice and meat", "2800", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Kakao Dak")
);

insert into positions (title, description, price, photo_url, partner_id) values (
	"Sea snacks", "Sea snacks with dressing", "2200", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Chechil")
);

insert into positions (title, description, price, photo_url, partner_id) values (
	"'Shymkentskoe' beer", "Bottled beer", "550", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Chechil")
);

insert into positions (title, description, price, photo_url, partner_id) values (
	"Meat roast", "Grilled beef with vegetables", "2700", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Chechil")
);

insert into positions (title, description, price, photo_url, partner_id) values (
	"Healthy breakfast", "Toast with avocado and turkey", "2800", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Svet")
);

insert into positions (title, description, price, photo_url, partner_id) values (
	"Classic lemonade", "1 liter of classic lemonade with apple, lemon and ice", "2200", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Svet")
);

insert into positions (title, description, price, photo_url, partner_id) values (
	"Elsweyr Fondue", "Rich stew of vegetables and venison", "4500", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Svet")
);

insert into clients (phone, fullname) values (
	"+77771112233", "Raloph"
);

insert into clients (phone, fullname) values (
	"+7772223344", "Grelod the Kind"
);

insert into clients (phone, fullname) values (
	"+77773334455", "Ulfric Stormcloak"
);

insert into orders (address, latitude, longtitude, status, client_id) values (
	"Satpaev 22", "3.14", "3.14", "new order",
	(select id from clients where id = "1")
);

insert into orders (address, latitude, longtitude, status, client_id) values (
	"Auezov street 123", "3.14", "3.14", "order accepted",
	(select id from clients where id = "2")
);

insert into orders (address, latitude, longtitude, status, client_id) values (
	"Suinbay avenue", "3.14", "3.14", "in progress",
	(select id from clients where id = "3")
);

insert into orders (address, latitude, longtitude, status, client_id) values (
	"Suinbay avenue", "3.14", "3.14", "completed",
	(select id from clients where id = "3")
);

insert into positions_orders (position_id, order_id) values
(2, 1),
(3, 2),
(7, 3),
(8, 4),
(9, 4);

-- 2
select distinct orders.id, clients.phone, partners.title from clients
join orders on clients.id = orders.client_id
join positions_orders on orders.id = positions_orders.order_id
join positions on positions_orders.position_id = positions.id
join partners on positions.partner_id = partners.id

-- 3
insert into partners (title, description, address) values ("Urbo Coffee", "Coffee house", "Gagarin street 140");
insert into positions (title, description, price, photo_url, partner_id) values (
	"Latte", "100 percent arabica with foamed milk", "1400", "www.photoviewer.com/some_photo",
	(select id from partners where title = "Urbo Coffee")
);

select * from partners where partners.id not in 
(select partner_id from positions_orders
join positions on positions.id = positions_orders.position_id);

-- 4 
select clients.id, clients.fullname, orders.id, orders.status, positions.title from clients
join orders on clients.id = orders.client_id
join positions_orders on orders.id = positions_orders.order_id
join positions on positions_orders.position_id = positions.id;