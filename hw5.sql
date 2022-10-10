CREATE DATABASE food_delivery;

use food_delivery;

CREATE TABLE Partners(
	id int auto_increment NOT NULL,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE Positions(
	id int auto_increment NOT NULL,
	title varchar(150),
	description text,
	price int NOT NULL default(0),
	photo_url varchar(255),
	partner_id int,
	PRIMARY KEY (id),
	FOREIGN KEY (partner_id) REFERENCES Partners(id) 
		ON update cascade 
		ON delete restrict 
		# if the PK is changed, then child too.
		# attempt to delete and/or update the parent will fail throwing an error
);

CREATE TABLE Clients (
    id int auto_increment NOT NULL,
	phone char(12),
	fullname varchar(255),
	PRIMARY KEY(id)
);

CREATE TABLE Orders(
	id int auto_increment NOT NULL,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum("new","accepted","in progress","done"),
	client_id int,
	PRIMARY KEY(id),
	FOREIGN KEY (client_id) REFERENCES Clients(id)
		ON update cascade
		ON delete restrict
);

CREATE TABLE OrderedPositions(
 	order_id int NOT NULL,
   	position_id int NOT NULL,
	PRIMARY KEY (order_id, position_id),
	FOREIGN KEY (order_id) REFERENCES Orders(id) 
		ON update cascade
		ON delete restrict,
	FOREIGN KEY (position_id) REFERENCES Positions(id) 
		ON update cascade
		ON delete restrict
);

INSERT INTO Partners(title,description,address) 
	VALUES ("Sushiman", "Sushi delivery","Astana Kubrina 16/1"),
		   ("Donerka", "Doner delivery","Astana Tarlova 22"),
		   ("Burger", "Burger delivery","Astana Koshkarbayeva 39");

INSERT INTO Positions(title, description,price,partner_id) VALUES
 ("Hosomaki","Лосось и рис с огурцом 12шт.","2000",(SELECT id FROM Partners WHERE title = "Sushiman")),
 ("Futomaki","Жаренные уромаки с авокадо 12шт.","2500",(SELECT id FROM Partners WHERE title = "Sushiman")),
 ("Uromaki","Cостоят из небольшого количества риса, нори и нескольких ломтиков красной рыбы","500",(SELECT id FROM Partners WHERE title = "Sushiman")),
 ("Цезарь","Куриное филе с тёртым сыром и овощами","2200",(SELECT id FROM Partners WHERE title = "Donerka")),
 ("Белый чай","Белый чай с облепихой 1л ","1800",(SELECT id FROM Partners WHERE title = "Donerka")),
 ("Панини","Сэндвич с курицей","1500",(SELECT id FROM Partners WHERE title = "Donerka")),
 ("Картошка фри","200гр","1000",(SELECT id FROM Partners WHERE title = "Burger")),
 ("Кофе","порошковый кофе","100",(SELECT id FROM Partners WHERE title = "Burger")),
 ("БигМак","Итальянское пирожное","2000",(SELECT id FROM Partners WHERE title = "Burger"));
 
 INSERT INTO Clients (phone,fullname) VALUES ("+87774543223","Atos");
 INSERT INTO Clients (phone,fullname) VALUES ("+87005330011","Partos");
 INSERT INTO Clients (phone,fullname) VALUES ("+87784203550","Aramis");

 
 INSERT INTO Orders(created_at,address,status,client_id) VALUES
	(SYSDATE(),"Пушкина, 14","new",(SELECT id FROM Clients WHERE fullname = "Atos")),
	(SYSDATE(),"Абая 40, ","new",(SELECT id FROM Clients WHERE fullname = "Atos")),
	(SYSDATE(),"Аль-Фараби, 75","done",(SELECT id FROM Clients WHERE fullname = "Partos")),
	(SYSDATE(),"Кошкарбаева, 21","done",(SELECT id FROM Clients WHERE fullname = "Partos")),
	(SYSDATE(),"Назарбаева, 70","in progress",(SELECT id FROM Clients WHERE fullname = "Aramis")),
	(SYSDATE(),"Толеби, 10","in progress",(SELECT id FROM Clients WHERE fullname = "Aramis"));
	
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 1 AND Positions.id = 1;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 2 AND Positions.id = 2;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 3 AND Positions.id = 3;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 4 AND Positions.id = 4;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 5 AND Positions.id = 6;
INSERT INTO OrderedPositions (order_id, position_id) SELECT Orders.id, Positions.id from Orders, Positions WHERE Orders.id = 6 AND Positions.id = 7;

SELECT Orders.id, Clients.phone, Partners.title FROM Orders 
	INNER JOIN Clients ON Orders.client_id = Clients.id 
	INNER JOIN OrderedPositions ON Orders.id = OrderedPositions.order_id 
	INNER JOIN Positions ON OrderedPositions.position_id = Positions.id
	INNER JOIN Partners ON Positions.partner_id = Partners.id;

INSERT INTO Partners (title, description,address) values
("Burger King","Better than McD","Abylai Khan,15");

INSERT INTO Positions (title, descriptiON,price,partner_id) values
 ("King Burger","bread, meat,salad, tomato,","1700",(SELECT id FROM Partners WHERE title = "Burger King"));
 
 SELECT * FROM Partners WHERE Partners.id not in 
 (SELECT partner_id FROM OrderedPositions, Positions WHERE Positions.id = OrderedPositions.position_id);
 

 SELECT Positions.title FROM Orders, Positions, OrderedPositions
 	WHERE OrderedPositions.order_id = Orders.id
 	AND OrderedPositions.position_id = Positions.id 
 	AND Orders.id = 1 
 	AND Orders.client_id = 1 ;


