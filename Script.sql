create database kolesaUpgrade;

use kolesaUpgrade;

create table Partners (
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

create table Clients (
	id int unsigned primary key auto_increment,
	phone char(12),
	fullname varchar(255)
);

create table Orders (
	id int unsigned primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum('новый', 'принят рестораном', 'доставляется', 'завершен'),
	client_id int unsigned not null,
	foreign key (client_id) references Clients(id)
		on update cascade
		on delete restrict
);

create table Manyman (
	position_id int unsigned not null,
	order_id int unsigned not null,
	foreign key (order_id) references Orders(id)
		on update cascade
		on delete restrict,
	foreign key (position_id) references positions(id)
		on update cascade
		on delete restrict
);

insert into Partners (title, description, adress)
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

insert into Clients (phone, fullname)
	values ("+777777777", "Timatiger"),
	("+707707777", "Abeke"),
	("+770770770", "Magadan")

select * from Clients;

insert into Orders (created_at, address, latitude, longitude, status, client_id)
	values (20220701, "Farabi", 15.2, 17.6, "новый", 1),
	(20220101, "Abay", 15.2, 17.6, "принят рестораном", 2),
	(20220401, "Shamshi", 15.2, 17.6, "принят рестораном", 2),
	(20220301, "Turan", 15.2, 17.6, "доставляется", 3),
	(20220501, "e35", 15.2, 17.6, "доставляется", 3)

insert into Manyman (position_id, order_id)
values (1, 1), (2, 1), (4, 2), (5, 2), (7, 3), (8, 3)

select * from Manyman;

SELECT o.id, c.phone, p.title 
FROM Orders o
INNER JOIN Clients c on o.client_id = c.id
inner join Manyman mm on o.id = mm.order_id 
inner join positions po on mm.position_id  = po.id 
inner join partners p on po.partner_id  = p.id 

insert into Partners (title, description, adress)
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





