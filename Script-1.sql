create database restaurant;
use restaurant;

create table Partners ( 	
	id int unsigned  not null  primary key auto_increment,
	title varchar(150) not null,
	description text,
	address varchar(255) not null
);

insert into Partners (title, description, address) values ('KFC', 'fastfood', 'kfc street');
insert into Partners (title, description, address) values ('Mac', 'fastfood', 'mac street');
insert into Partners (title, description, address) values ('BK', 'fastfood', 'bk street');



create table Positions ( 	
	id int unsigned  not null  primary key auto_increment,
	title varchar(255) not null,
	description text,
	price int not null default(0),
	photo_url varchar(255),
	partner_id int unsigned not null,
	foreign key (partner_id) references Partners(id) on update cascade on delete restrict 
);

insert into Positions (title, description,price,photo_url,partner_id) values ('Bruger','meat burger',999,'http://google.com',1);
insert into Positions (title, description,price,photo_url,partner_id) values ('Cola','cold cold',999,'http://google.com',1);
insert into Positions (title, description,price,photo_url,partner_id) values ('Fires','fresh fries',599,'http://google.com',1);
insert into Positions (title, description,price,photo_url,partner_id) values ('Bruger','meat burger',199,'http://google.com',2);
insert into Positions (title, description,price,photo_url,partner_id) values ('Pepsi','cold Pepsi',299,'http://google.com',2);
insert into Positions (title, description,price,photo_url,partner_id) values ('Souse','some souse',399,'http://google.com',2);
insert into Positions (title, description,price,photo_url,partner_id) values ('Bruger','chiken burger',499,'http://google.com',3);
insert into Positions (title, description,price,photo_url,partner_id) values ('Juice','cold Juice',599,'http://google.com',3);
insert into Positions (title, description,price,photo_url,partner_id) values ('Sushi','fresh Sushi',699,'http://google.com',3);

create table Clients (
	id int unsigned not null primary key auto_increment,
	phone char(12),
	fullname varchar(255)
);

insert into Clients (fullname, phone) values ('Jhon Doe','1234567891');
insert into Clients (fullname, phone) values ('Kim Bro','1234567892');
insert into Clients (fullname, phone) values ('Mike Noe','1234567893');

create table Orders ( 	
	id int unsigned  not null primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum('new','approved','delivering','delivered'), 
	client_id int unsigned not null,
	foreign key (client_id) references Clients(id) on update cascade on delete restrict 
);

insert into Orders (created_at, address, latitude, longitude,status, client_id) values ('2022-10-07 12:12:12','Some address 1', 1,1,'approved',1);
insert into Orders (created_at, address, latitude, longitude,status, client_id) values ('2022-10-07 12:12:12','Some address 1', 1,1,'approved',1);
insert into Orders (created_at, address, latitude, longitude,status, client_id) values ('2022-10-07 13:13:13','Some address 2', 2,2,'delivering',2);
insert into Orders (created_at, address, latitude,longitude,status, client_id) values ('2022-10-07 13:13:13','Some address 2', 2,2,'delivering',2);
insert into Orders (created_at, address, latitude, longitude,status, client_id) values ('2022-10-07 14:14:14','Some address 3', 2,2,'delivered',3);
insert into Orders (created_at, address, latitude, longitude,status, client_id) values ('2022-10-07 14:14:14','Some address 3', 2,2,'delivered',3);

create table Order_Numbers (
	position_id int unsigned not null,
	order_id int unsigned not null,
	foreign key(position_id) references Positions(id) on update cascade on delete restrict, 
	foreign key(order_id) references Orders(id) on update cascade on delete restrict 
);

insert into Order_Numbers (position_id, order_id) values (1,1);
insert into Order_Numbers (position_id, order_id) values (2,2);
insert into Order_Numbers (position_id, order_id) values (3,3);
insert into Order_Numbers (position_id, order_id) values (4,4);
insert into Order_Numbers (position_id, order_id) values (5,5);
insert into Order_Numbers (position_id, order_id) values (6,6);

# task 2
insert into Partners (title, description, address) values ('ChickFilA', 'chicken', 'nyc street');

insert into Positions (title, description, price, photo_url, partner_id) values ('Chicken basket', 'Chicken basket', 15000, 'http://google.com', (select id from Partners where title = 'ChickFilA'));


# task 3
select Partners.title from Partners where Partners.id not in 
(select partner_id from Order_Numbers
join Positions on Positions.id = Order_Numbers.position_id);

# task 4
select Positions.title from Orders, Positions, Order_Numbers
where Order_Numbers.order_id = Orders.id and Order_Numbers.position_id = Positions.id  and Orders.id = 1 and Orders.client_id = 1;

# task 2
select Orders.id, Clients.phone, Partners.title from Orders 
inner join Order_Numbers on Orders.id = Order_Numbers.order_id
inner join Positions on Positions.id = Order_Numbers.position_id
inner join Clients on Orders.client_id = Clients.id
inner join Partners on Partners.id = Positions.partner_id




