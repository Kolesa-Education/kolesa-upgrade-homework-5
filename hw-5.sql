CREATE DATABASE foodDelivery;

USE foodDelivery;
-- task 1
CREATE TABLE Partners(
	id int UNSIGNED NOT NULL primary key auto_increment,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE Positions(
	id int UNSIGNED NOT NULL primary key auto_increment,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL default(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES Partners (id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE Clients(
	id int UNSIGNED NOT NULL primary key auto_increment,
	phone char(12),
	fullname varchar(255)
);

CREATE TABLE Orders(
	id int UNSIGNED NOT NULL primary key auto_increment,
	created_at datetime default(NOW()),
	address varchar(255),
	latitude float,
	longitude float,
	status ENUM("delivered", "delivering" , "preparing", "waiting"),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY(client_id) REFERENCES Clients (id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE OrderedPositions(
	id int UNSIGNED NOT NULL primary key auto_increment,
	order_id int UNSIGNED NOT NULL,
	position_id int UNSIGNED NOT NULL,
	FOREIGN KEY(order_id) REFERENCES Orders (id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY(position_id) REFERENCES Positions (id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

INSERT INTO Partners (title, address) VALUES ("McDonalds", "Astana, Mega Silk Way");
INSERT INTO Partners (title, description, address) VALUES ("KFC", "the best fast-food restaurant", "Astana, Mega Silk Way");
INSERT INTO Partners (title, description, address) VALUES ("Hardees", "very expensive", "Astana, Mega Silk Way");

INSERT INTO Positions (title, price, partner_id) VALUES ("Big MAC", 5000, 1);
INSERT INTO Positions (title, price, partner_id) VALUES ("Ice Cream", 2000, 1);
INSERT INTO Positions (title, price, partner_id) VALUES ("Cocktail", 2000, 1);

INSERT INTO Positions (title, price, partner_id) VALUES ("Basket", 5650, 2);
INSERT INTO Positions (title, price, partner_id) VALUES ("Twister", 2500, 2);
INSERT INTO Positions (title, price, partner_id) VALUES ("Burger", 3000, 2);

INSERT INTO Positions (title, price, partner_id) VALUES ("Burger", 3000, 3);
INSERT INTO Positions (title, price, partner_id) VALUES ("Cola", 500, 3);
INSERT INTO Positions (title, price, partner_id) VALUES ("Doner", 1500, 3);

INSERT INTO Clients (phone, fullname) VALUES ("+7777777777", "Michael Jordan");
INSERT INTO Clients (phone, fullname) VALUES ("+7123456789", "Carl Johnson");
INSERT INTO Clients (phone, fullname) VALUES ("+7888888888", "Tommy Vercetti");

INSERT INTO Orders (address, status, client_id) SELECT "Astana, Ak-Orda", "waiting", id FROM Clients WHERE id = 1 LIMIT 1;
INSERT INTO Orders (address, status, client_id) SELECT "Astana, Ak-Orda", "preparing", id FROM Clients WHERE id = 1 LIMIT 1;
INSERT INTO Orders (address, status, client_id) SELECT "Astana, Ak-Orda", "delivered", id FROM Clients WHERE id = 1 LIMIT 1;
INSERT INTO Orders (address, status, client_id) SELECT "Almaty, Shevchenko 157/4", "delivered", id FROM Clients WHERE id = 2 LIMIT 1;
INSERT INTO Orders (address, status, client_id) SELECT "Almaty, Shevchenko 157/4", "waiting", id FROM Clients WHERE id = 3 LIMIT 1;
INSERT INTO Orders (address, status, client_id) SELECT "Almaty, Shevchenko 157/4", "waiting", id FROM Clients WHERE id = 3 LIMIT 1;

INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 1 AND Positions.id = 1;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 2 AND Positions.id = 2;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 3 AND Positions.id = 3;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 4 AND Positions.id = 4;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 5 AND Positions.id = 3;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 6 AND Positions.id = 7;

SELECT Orders.id, Clients.phone, Partners.title FROM Orders 
	INNER JOIN Clients ON Orders.client_id = Clients.id 
	INNER JOIN OrderedPositions ON Orders.id = OrderedPositions.order_id 
	INNER JOIN Positions ON OrderedPositions.position_id = Positions.id
	INNER JOIN Partners ON Positions.partner_id = Partners.id;

-- task 2
INSERT INTO Partners (title, address) VALUES ("Turchanka", "Astana, Nazarbayev University");
INSERT INTO Positions (title, price, partner_id) SELECT "Plov", 1200, id FROM Partners WHERE title = "Turchanka";

SELECT * FROM Partners WHERE Partners.id NOT IN ( SELECT Positions.partner_id FROM Positions INNER JOIN OrderedPositions ON OrderedPositions.position_id = Positions.id );

-- task 3
SELECT Positions.title FROM Positions 
	INNER JOIN OrderedPositions ON OrderedPositions.position_id = Positions.id 
	INNER JOIN Orders ON OrderedPositions.order_id = Orders.id 
	INNER JOIN Clients ON Orders.client_id = Clients.id
	WHERE Clients.id = 2 AND Orders.id = 4