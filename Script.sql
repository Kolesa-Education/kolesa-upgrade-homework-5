create database delivery

use delivery

create table partners (
	id int unsigned primary key auto_increment,
	title varchar(150) not null,
	description text,
	address varchar(255) not null
)	

create table positions (
	id int unsigned primary key auto_increment,
	title varchar(255) not null,
	description text,
	price int unsigned not null default(0),
	photo_url varchar(255),
	partner_id int unsigned,
	foreign key (partner_id) references partners(id)
		on update cascade
		on delete cascade
)

create table clients (
	id int unsigned primary key auto_increment,
	phone char(12),
	fullname varchar(255)
)
	
create table orders (
	id int unsigned primary key auto_increment,
	created_at datetime not null,
	address varchar(255) not null,
	latitude float not null,
	longitude float not null,
	status enum('�����', '������ ����������', '������������', '��������'),
	client_id int unsigned,
	foreign key (client_id) references clients(id)
		on update cascade
		on delete cascade
)

create table orders_positions (
	order_id int unsigned not null,
	position_id int unsigned not null,
	primary key(order_id, position_id),
	foreign key (order_id) references orders(id)
		on update cascade
		on delete restrict,
	foreign key (position_id) references positions(id)
		on update cascade
		on delete cascade
)

show tables
	
select * from clients;
select * from orders;
select * from orders_positions;
select * from positions;
select * from partners;

# 1) ��������� ���� ��������� �������, �� ����� 3 ���������, �� ����� 3 ������� ��� ������ � ������� �� ���������. 3 ������������, � ������� �� ������� �� 1 �� 5 �������, � ������ �� ������� �� 1 �� 3 ������� ����
insert into partners (title, description, address) values 
	('KFC', 'spicy chicken', '������ ����� ���������� 42/10� KFC Atakent'),
	('Burger King', 'burgers', '������ ?�������� ����, 89'),
	('Shoq doner', 'doners', '������ ??����� ����������, 21')
	
insert into positions (title, description, price, photo_url, partner_id) values 
	('Nuggets', null, 950, 'https://www.kfc.kz/admin/files/4282.jpg', 1),
	('Boxmaster', 'spicy', 1750, 'https://www.kfc.kz/admin/files/4309.jpg', 1),
	('Bucket Duet', '2 drumsticks, 4 spicy wings, 4 strips, 2 french fries S', 4000, 'https://www.kfc.kz/admin/files/4315.jpg', 1),
	('Whopper', 'burger', 2000, 'https://burgerking.kz/uploads/menuproducts/image/big_1628580583.png', 2),
	('Onion rings', null, 950, 'https://burgerking.kz/uploads/menuproducts/image/big_1628581737.png', 2),
	('King Box 1', '������ ����� (2 ��.), ���������, ������ ����, ���� ����� ���, ������� ������ (8 ��.), �������� (6 ��.), ������, ������ ����, Coca-Cola (1 �)', 7200, null, 2),
	('Doner', 'Mix', 1650, 'https://sc01.chocofood.kz/hermes/food_new/4/41198170-339e-4c1c-a9f8-c95399ad7126.jpeg', 3),
	('Airan', null, 300, null, 3),
	('Cheesburger', null, 1800, 'https://sc01.chocofood.kz/hermes/food_new/7/7006e589-62e0-46b6-b7d9-823c62225d96.jpeg', 3)	
	
insert into clients (phone, fullname) values 
	('+77010002233', 'Aigul Toktassynova'),
	('+77470004455', 'Anton Epaneshnikov'),
	('+77770006677', 'Moldakimov Rasul')	
	
insert into orders (created_at, address, latitude, longitude, status, client_id) values 
	('2022-10-01 14:10:37', '������, ���������� �����-2 111', '43.233690', '76.956440', '��������', 1),
	('2022-10-01 16:33:22', '������, ?����� ��������, 90/5', '43.238549', '76.945441', '��������', 3),
	('2022-10-01 20:31:08', '������, ?����� �����������, 247�', '43.209911', '76.893552', '��������', 2),
	('2022-10-02 18:05:56', '������, ���������� �����-2 111', '43.233690', '76.956440', '��������', 1),
	('2022-10-01 19:01:08', '������, ?����� �����������, 247�', '43.209911', '76.893552', '��������', 2),
	('2022-10-04 16:33:22', '������, ?����� ��������, 90/5', '43.238549', '76.945441', '������������', 3),
	('2022-10-04 18:19:23', '������, ���������� �����-2 111', '43.233690', '76.956440', '������ ����������', 1),
	('2022-10-04 22:15:48', '������, ?����� �����������, 247�', '43.209911', '76.893552', '�����', 2)	
	
insert into orders_positions (order_id, position_id) values 
	(1, 3),
	(2, 4),
	(2, 5),
	(3, 7),
	(3, 8),
	(4, 8),
	(4, 9),
	(5, 6),
	(6, 1),
	(6, 2),
	(6, 3),
	(7, 4),
	(7, 5),
	(7, 6),
	(8, 7),
	(8, 8),
	(8, 9)	

# 2) �������� ������, ������� ����� �������� ������ ������� (�� ��), ����� ��������� ��������, �������� ��������
select orders.id, clients.phone, partners.title
from clients
join orders on clients.id = orders.client_id
join orders_positions on orders.id = orders_positions.order_id
join positions on orders_positions.position_id = positions.id
join partners on positions.partner_id = partners.id

# 3) �������� ��� ������ �������� � ������� 1 ������� ��� ����. �� �� ���������� ������. �������� ������, ������� ������� ����� ���������, � ������� ��� �� ���� �� ������ ������
insert into partners (title, address) values ('Pizza Hut', '������, ?����� �����������, 247�')
insert into positions (title, description, price, partner_id) values ('Margarita', 'pizza', 3500, 4)

select partners.title, orders.id
from partners
left join positions on positions.partner_id = partners.id
left join orders_positions on orders_positions.position_id = positions.id
left join orders on orders.id = orders_positions.order_id
where orders.id is null

# 4) �������� ������, ������� �� ID ������������ � ID ������ ������� �������� ���� ������� �� ����� ������.
select clients.id, clients.fullname, orders.id, orders.status, positions.title 
from clients
join orders on clients.id = orders.client_id
join orders_positions on orders.id = orders_positions.order_id
join positions on orders_positions.position_id = positions.id
