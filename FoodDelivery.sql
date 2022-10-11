CREATE DATABASE FoodDelivery;

USE FoodDelivery;

CREATE TABLE Partners (
id int UNSIGNED primary key auto_increment NOT NULL,
title varchar(150) NOT NULL,
description text,
address varchar(255) NOT NULL
);

CREATE TABLE Positions (
id int UNSIGNED primary key auto_increment NOT NULL,
title varchar(255) NOT NULL,
description text,
price int NOT NULL DEFAULT(0),
photo_url varchar(255),
partner_id int UNSIGNED NOT NULL,
FOREIGN KEY (partner_id) REFERENCES Partners (id) 
	ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Clients (
id int UNSIGNED primary key auto_increment NOT NULL,
phone char(12),
fullname varchar(255)
);

CREATE TABLE Orders (
id int UNSIGNED primary key auto_increment NOT NULL,
created_at DATETIME,
address varchar(255) NOT NULL,
latitude float NOT NULL,
longtitude float NOT NULL,
status enum("accepted","in_progress","delivery","done") NOT NULL,
client_id int UNSIGNED NOT NULL,
FOREIGN KEY (client_id) REFERENCES Clients (id)
	ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE PositionsToOrders (
position_id int UNSIGNED NOT NULL,
FOREIGN KEY (position_id) REFERENCES Positions (id),
order_id int UNSIGNED NOT NULL,
FOREIGN KEY (order_id) REFERENCES Orders (id)
);
