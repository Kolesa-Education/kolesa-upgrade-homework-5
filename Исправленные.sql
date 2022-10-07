create database kolesaUpgrade;

use kolesaUpgrade;

create table partners (
	id int unsigned primary key auto_increment,
	title varchar(150) not null,
	description text,
	adress varchar(255) not null 
);

create table positions (
	id int unsigned primary key auto_increment,
	title varchar(255) not null,
	description text,
	price int not null default(0),
	photo_url varchar(255),
	partner_id int unsigned not null,
	foreign key (partner_id) references Partners(id)
		on update cascade
		on delete restrict
	
);

show tables;

create table clients (
	id int unsigned primary key auto_increment,
	phone char(12) not null,
	fullname varchar(255) not null
);

create table orders (
	id int unsigned primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum('new', 'adopted by the restaurant', 'delivered', 'completed'),
	client_id int unsigned not null,
	foreign key (client_id) references clients(id)
		on update cascade
		on delete restrict
);

create table manyman (
	position_id int unsigned not null,
	order_id int unsigned not null,
	constraint pk_manymanpk primary key(position_id, order_id),
	foreign key (order_id) references orders(id)
		on update cascade
		on delete restrict,
	foreign key (position_id) references positions(id)
		on update cascade
		on delete restrict
);

insert into partners (title, description, adress)
	values ("Apple", "smartphonemilk", "California"), 
	("Saudi Aramco", "oilmillionerspizza", "Dubai"),
	("Microsoft", "et etke sorpa betke", "Astana")
	
select * from partners;
	
insert into positions (title, description, price, photo_url, partner_id)
	values ("pirozhki", "posicia 1", 15000, "url1", 1),
	("pelmen", "posicia 2", 25000, "url2", 1),
	("mai", "posicia 3", 45000, "url3", 1),
	("sorpa", "posicia 4", 11000, "url2", 2),
	("kurt", "posicia 5", 12000, "url3", 2),
	("rice", "posicia 6", 300, "url3", 2),
	("doner", "posicia 7", 123, "url2", 3),
	("samsa", "posicia 8", 2666, "url3", 3),
	("plov", "posicia 9", 9999, "url3", 3)

select * from positions;

insert into clients (phone, fullname)
	values ("+777777777", "Timatiger"),
	("+707707777", "Abeke"),
	("+770770770", "Magadan")

select * from clients;

insert into orders (created_at, address, latitude, longitude, status, client_id)
	values (20220701, "Farabi", 15.2, 17.6, "new", 1),
	(20220101, "Abay", 15.2, 17.6, "adopted by the restaurant", 2),
	(20220401, "Shamshi", 15.2, 17.6, "adopted by the restaurant", 2),
	(20220301, "Turan", 15.2, 17.6, "delivered", 3),
	(20220501, "e35", 15.2, 17.6, "delivered", 3)

insert into manyman (position_id, order_id)
values (1, 1), (2, 1), (4, 2), (5, 2), (7, 3), (8, 3), (9, 4), (3, 5)

select * from orders;

SELECT o.id as order_id, max(c.phone), max(p.title) 
FROM orders o
INNER JOIN clients c on o.client_id = c.id
inner join manyman mm on o.id = mm.order_id 
inner join positions po on mm.position_id  = po.id 
inner join partners p on po.partner_id  = p.id 
group by o.id 

insert into partners (title, description, adress)
	values ("KolesaCore", "pelmen", "Almaty")

insert into positions (title, description, price, photo_url, partner_id)
	values ("pelmen", "posicia 77", 54000, "url123", 4)

select p.title  from partners p 
inner join positions p2 on p.id  = p2.partner_id
where p2.id not in (select position_id from manyman) 

select p.title from positions p 
inner join manyman m on p.id = m.position_id 
inner join orders o on m.order_id = o.id 
where o.client_id = 2 and o.id = 3 





