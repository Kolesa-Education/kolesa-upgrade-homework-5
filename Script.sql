CREATE DATABASE delivery;

USE delivery;

CREATE TABLE Partners (
	id int UNSIGNED NOT NULL primary key auto_increment,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE Positions (
	id int UNSIGNED NOT NULL primary key auto_increment,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	foreign key (partner_id) references Partners(id) on update cascade on delete restrict
);

CREATE TABLE Clients (
	id int UNSIGNED NOT NULL primary key auto_increment,
	phone char(12),
	fullname varchar(255)
);

CREATE TABLE Orders (
	id int UNSIGNED NOT NULL primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum('new', 'approved', 'delivering', 'delivered'),
	client_id int UNSIGNED NOT NULL,
	foreign key (client_id) references Clients(id) on update cascade on delete restrict
);

# TASK 1
INSERT INTO Partners(title, description, address) VALUES ('Bahandi', 'great burgers', '255 bahandi st.');
INSERT INTO Partners(title, description, address) VALUES ('Burger King', 'best fastfood', '123 burger king st.');
INSERT INTO Partners(title, description, address) VALUES ('MacDonalds', 'good drinks and fastfood', '067 macdonalds st.');

INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Burger','standard',1200,'url',1);
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Fries','standard',500,'url',1);
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Drink','Pepsi',500,'url',1);
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Burger','big',1100,'url',2);
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Fries','small',400,'url',2);
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Drink','Coca-Cola',900,'url',2);
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Burger','small',900,'url',3);
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Fries','big',900,'url',3);
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('Drink','Apple Juice',450,'url',3);

INSERT INTO Clients(phone, fullname) VALUES ('87073887211','Adi Yeltay');
INSERT INTO Clients(phone, fullname) VALUES ('98765432100','Some Person');
INSERT INTO Clients(phone, fullname) VALUES ('12345678900','Name Surname');

INSERT INTO Orders(created_at, address, latitude, longitude, status, client_id) VALUES ('2022-10-06 11:00:00','myaddress 1',1,1,'delivered',1);
INSERT INTO Orders(created_at, address, latitude, longitude, status, client_id) VALUES ('2022-10-06 11:00:00','myaddress 1',1,1,'delivered',1);
INSERT INTO Orders(created_at, address, latitude, longitude, status, client_id) VALUES ('2022-10-06 11:00:00','myaddress 1',1,1,'delivered',1);
INSERT INTO Orders(created_at, address, latitude, longitude, status, client_id) VALUES ('2022-10-07 15:00:00','myaddress 2',2,2,'delivering',2);
INSERT INTO Orders(created_at, address, latitude, longitude, status, client_id) VALUES ('2022-10-07 15:00:00','myaddress 2',2,2,'delivering',2);
INSERT INTO Orders(created_at, address, latitude, longitude, status, client_id) VALUES ('2022-10-07 16:00:00','myaddress 3',3,3,'approved',3);

CREATE TABLE OrderAmount (
	position_id int UNSIGNED NOT NULL,
	order_id int UNSIGNED NOT NULL,
	foreign key (position_id) references Positions(id) on update cascade on delete restrict,
	foreign key (order_id) references Orders(id) on update cascade on delete restrict
);

INSERT INTO OrderAmount(position_id, order_id) VALUES (1, 1);
INSERT INTO OrderAmount(position_id, order_id) VALUES (2, 2);
INSERT INTO OrderAmount(position_id, order_id) VALUES (3, 3);
INSERT INTO OrderAmount(position_id, order_id) VALUES (4, 4);
INSERT INTO OrderAmount(position_id, order_id) VALUES (5, 5);
INSERT INTO OrderAmount(position_id, order_id) VALUES (6, 6);

# TASK 2
SELECT Orders.id, Clients.phone, Partners.title from Orders
INNER JOIN OrderAmount on Orders.id = OrderAmount.order_id
INNER JOIN Positions on Positions.id = OrderAmount.position_id
INNER JOIN Clients on Orders.client_id = Clients.id
INNER JOIN Partners on Partners.id = Positions.partner_id

# TASK 3
INSERT INTO Partners(title, description, address) VALUES ('6inch', 'sandwiches', '55 6inch st.');
INSERT INTO Positions(title, description, price, photo_url, partner_id) VALUES ('chicken grill', 'good sandwich', 1250, 'url', (SELECT id FROM Partners WHERE title='6inch'));

SELECT Partners.title FROM Partners WHERE Partners.id NOT IN (SELECT partner_id FROM OrderAmount JOIN Positions ON Positions.id = OrderAmount.position_id);

# TASK 4
SELECT Positions.title FROM Orders, Positions, OrderAmount WHERE OrderAmount.order_id = Orders.id AND OrderAmount.position_id = Positions.id  AND Orders.id = 1 AND Orders.client_id = 1;
