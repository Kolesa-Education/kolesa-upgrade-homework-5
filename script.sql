
CREATE TABLE Partners(
	id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE Positions(
	id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL default(0),
	photo_url varchar(255),
	partner_id int NOT NULL,
	FOREIGN KEY(partner_id) REFERENCES Partners(id) ON DELETE CASCADE
);

CREATE TABLE Orders(
	id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum('Новый', 'Принят рестораном', 'Доставляется', 'Завершён'),
	client_id int NOT NULL,
	FOREIGN KEY(client_id) REFERENCES Clients(id) ON DELETE CASCADE
);

CREATE TABLE Clients(
	id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	phone char(12),
	fullname varchar(255)
);

CREATE TABLE Positions_to_Orders(
	position_id int NOT NULL,
	order_id int NOT NULL,
	FOREIGN KEY(position_id) REFERENCES Positions(id) ON DELETE CASCADE,
	FOREIGN KEY(order_id) REFERENCES Orders(id) ON DELETE CASCADE
);

#2nd task
SELECT Orders.id, Clients.phone, Partners.title from Orders
inner join Clients on Clients.id = Orders.client_id
inner join Positions_to_Orders on Positions_to_Orders.order_id=Orders.id
inner join Positions on Positions.id=Positions_to_Orders.position_id
inner join Partners on Partners.id=Positions.partner_id;

#3rd task
select * from Partners;

insert into Partners(id, title, description, address) values (8,'Turandot','Ресторан китайской кухни', 'ул.Жарокова, 282');
insert into Positions(id, title, description, price, photo_url, partner_id) values (21,'Говядина в соевом соусе', 
'Удачно подобранный маринад к мясу может существенно поменять вкус привычного блюда. 
Соевый соус великолепно подчеркивает вкус говядины в данном блюде, делая ее не только пикантнее, но и мягче.',
2900,'https://turandot.kz/img/products/25.jpg',8);
insert into Positions(id, title, description, price, photo_url, partner_id) values(22,'Требуха','Это блюдо очень сытное, 
полезное и довольно дешёвое в приготовлении. ',2600,'https://turandot.kz/img/products/26.jpg',8);

select * from Partners
where Partners.id not in (select Partners.id from Orders
							inner join Positions_to_Orders as po on po.oider_id=Orders.id
							inner join Positions as p on p.id=po.position_id
							inner join Partners as Pa on Pa.id=p.partner_id); 

#4th task
SELECT Clients.id as 'Client id', Orders.id as 'Order id', Positions.title as 'Position title'  from Clients
inner join Orders on Orders.client_id = Clients.id
inner join Positions_to_Orders on Positions_to_Orders.order_id = Orders.id
inner join Positions on Positions.id = Positions_to_Orders.position_id;
