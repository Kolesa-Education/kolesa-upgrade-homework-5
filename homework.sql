CREATE DATABASE food_delivery;

use food_delivery;

CREATE TABLE Partners (
    id int primary key auto_increment not null ,
    title varchar(150) not null,
    description text,
    address varchar(255) not null
);

CREATE TABLE Positions(
    id int primary key auto_increment not null,
    title varchar(255) not null ,
    description text,
    price int not null default(0),
    photo_url varchar(255),
    partner_id int,
    foreign key (partner_id) references Partners(id)
        on update cascade
        on delete restrict
);

CREATE TABLE Clients (
    id int primary key auto_increment not null,
    phone char(12),
    lastname varchar(255)
);

CREATE TABLE Orders(
    id int primary key auto_increment,
    created_at datetime,
    address varchar(255),
    latitude float,
    longitude float,
    status enum("new","accepted","in progress","finished"),
    client_id int,
    foreign key (client_id) references Clients(id)
        ON update cascade
        ON delete restrict
);

CREATE TABLE Position_orders(
        order_id int,
        position_id int,
        foreign key (order_id) references Orders(id)
            ON update cascade
            ON delete restrict,
        foreign key (position_id) references Positions(id)
            ON update cascade
            ON delete cascade
);


INSERT INTO Partners (title,description,address) VALUES ("Title 1","Descr 1","Address 1"),("Title 2","Descr 2","Address 2"), ("Title 3","Descr 3","Address 3");
	
INSERT INTO Positions (title,description,price,partner_id) VALUES
    ("Title 1","Descr 1","100",(SELECT id FROM Partners WHERE title = "Title 1")),
    ("Title 2","Descr 2","200",(SELECT id FROM Partners WHERE title = "Title 2")),
    ("Title 3","Descr 3","300",(SELECT id FROM Partners WHERE title = "Title 3"));
 
INSERT INTO clients (phone,lastname) VALUES
    ("+77001234567","John Snow"),
    ("+77021234567","Deyneris Targarien"),
    ("+77051234567","Birzhan Ashim");
 
INSERT INTO orders (created_at,address,status,client_id) VALUES
    (SYSDATE(),"Address 1","new",(SELECT id FROM Clients WHERE lastname = "John Snow")),
    (SYSDATE(),"Address 2","accepted",(SELECT id FROM Clients WHERE lastname = "Deyneris Targarien")),
    (SYSDATE(),"Address 3","in progress",(SELECT id FROM Clients WHERE lastname = "Birzhan Ashim")),
    (SYSDATE(),"Address 4","finished",(SELECT id FROM Clients WHERE lastname = "John Snow"));
 
INSERT INTO Position_orders(order_id,position_id) VALUES
    ((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM Positions WHERE title = "Title 1")),
    ((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM Positions WHERE title = "Title 2")),
    ((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM Positions WHERE title = "Title 3")),
    ((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM Positions WHERE title = "Title 1")),
    ((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM Positions WHERE title = "Title 2")),
    ((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM Positions WHERE title = "Title 3"));

SELECT
    Orders.id as "# order",
    Clients.phone as "Phone",
    Partners.title as "Partner"
FROM Orders,Clients,Position_orders,Positions,Partners
WHERE Orders.client_id = Clients.id
  AND Orders.id = Position_orders.order_id
  AND Positions.id = Position_orders.positiON_id
  AND Partners.id = Positions.partner_id;

INSERT INTO Partners (title,description,address) VALUES ("New partner","New partner descr","New partner adress");

INSERT INTO Positions (title, description,price,partner_id) VALUES ("New position","New pos descr","400",(SELECT id FROM Partners WHERE title = "New partner"));

SELECT * FROM Partners WHERE partners.id NOT IN (SELECT partner_id FROM Position_orders, Positions WHERE Positions.id = Position_orders.positiON_id);

SELECT Positions.title FROM Orders, Positions, Position_orders WHERE Position_orders.order_id = Orders.id
  AND Position_orders.position_id = Positions.id
  AND Orders.id = 1 /*Ввести id заказа*/
  AND Orders.client_id = 1 /*Ввести id клиента*/