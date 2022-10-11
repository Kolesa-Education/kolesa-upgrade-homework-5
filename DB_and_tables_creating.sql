CREATE DATABASE food_delivery_service;

USE food_delivery_service;

drop database food_delivery_service;

CREATE TABLE partners (
	id int UNSIGNED primary key auto_increment,
	title varchar(50) NOT NULL UNIQUE,
	description text(255),
	address varchar(255) NOT NULL
);

CREATE TABLE positions (
	id int UNSIGNED primary key auto_increment,
	title varchar(255) NOT NULL UNIQUE,
	description text,
	price int NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED,
	FOREIGN KEY (partner_id) REFERENCES partners(id)
		ON UPDATE CASCADE
);

CREATE TABLE clients (
	id int UNSIGNED primary key auto_increment,
	phone char(12) NOT NULL UNIQUE,
	name varchar(255) NOT NULL,
	surname varchar(255) NOT NULL
);

CREATE TABLE orders (
	id int UNSIGNED primary key auto_increment,
	create_at DATETIME NOT NULL,
	address varchar(255) NOT NULL,
	latitude float,
	longitude float,
	status enum('new', 'in_processing', 'delivered', 'completed') NOT NULL,
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES clients(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

CREATE TABLE positions_orders (
	order_id int UNSIGNED NOT NULL,
	position_id int UNSIGNED NOT NULL,
	PRIMARY KEY (order_id, position_id),
	FOREIGN KEY (position_id) REFERENCES positions(id),
	FOREIGN KEY (order_id) REFERENCES orders(id)
);