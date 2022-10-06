CREATE DATABASE food_order;

USE food_order;

CREATE TABLE partners (
	id int UNSIGNED primary key auto_increment,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE clients (
	id int UNSIGNED primary key auto_increment,
	phone char(12),
	fullname varchar(255)
);

CREATE TABLE positions (
	id int UNSIGNED primary key auto_increment,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES partners(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

CREATE TABLE orders (
	id int UNSIGNED primary key auto_increment,
	address varchar(255),
	latitude float,
	longtitude float,
	status ENUM("new", "accepted_by_the_restaurant", "on_delivery", "finished"),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES clients(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

CREATE TABLE position_orders(
	position_id int UNSIGNED NOT NULL,
	order_id int UNSIGNED NOT NULL,
	PRIMARY KEY (position_id, order_id),
	FOREIGN KEY (position_id) REFERENCES positions(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	FOREIGN KEY (order_id) REFERENCES orders(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

SHOW TABLES;