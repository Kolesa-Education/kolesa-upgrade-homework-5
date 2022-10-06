create database hw;

use hw;

create table Partners(
id int primary key auto_increment not null,
title varchar(150) not null, 
description text, 
address varchar(255) not null
)

create table Positions(
id int primary key auto_increment not null,
description text, 
price int  not null  default(0),
photo_url varchar(255), 
partner_id int, 
foreign key(partner_id) references Partners(id)
)


create table Clients(
id int primary key not null auto_increment, 
phone char(12), 
full_name varchar(255)
)

create table Orders(
id int primary key not null, 
created_at datetime, 
address varchar(255), 
latitude float, 
longitude float,
status enum('NEW','ACCEPTED',  'READY', 'COMPLETED'), 
client_id int,
foreign key (client_id) references Clients(id)
)


insert into orders (id, created_at, address, latitude, longitude, status, client_id) values (3, '2022-10-6-22-18-30', 'косынова 77', 10, 8, 'READY', 3)

select (partners.title ),(orders.id), (clients.phone), (positions.id) from orders, clients, partners, positions where positions.id = orders.id  and positions.partner_id = partners.id 

insert into partners(title, description, address) values ("KFC", 'фаст-фуд', 'садвакасова 78');

select (partners.title), count(positions.partner_id)=0  from positions, partners  

select (clients.id),(orders.id), (positions.description) from orders,clients, positions where orders.id =positions.id









