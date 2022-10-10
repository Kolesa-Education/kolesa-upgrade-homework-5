CREATE DATABASE homework_5;

USE homework_5;

CREATE TABLE Partners (
	id int NOT NULL PRIMARY KEY auto_increment,
	title varchar(150) NOT NULL,
	description varchar(255) NOT NULL
);

CREATE TABLE Positions (
	id int NOT NULL PRIMARY KEY auto_increment,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES Partners (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Clients (
	id int NOT NULL PRIMARY KEY auto_increment,
	phone char(12),
	fullname varchar(255)
);

CREATE TABLE Orders (
	id int NOT NULL PRIMARY KEY auto_increment,
	created_at time,
	address varchar(255),
	latitude float,
	longitude float,
	status enum('new', 'accepted', 'is delivered', 'done'),
	client_id int NOT NULL,
	FOREIGN KEY (client_id) REFERENCES Clients (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Positions_Orders (
	position_id int,
	order_id int,
	FOREIGN KEY (position_id) REFERENCES Positions (id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (order_id) REFERENCES Orders (id) ON UPDATE CASCADE ON DELETE CASCADE
);


# Задане 1

INSERT INTO Partners (title, description) VALUES 
('DoDo Pizza', 'Pizza restaurant'),
('Salam Bro', 'Burgers'), 
('Samurai Sushi', 'Sushi & rolls restaurant');

INSERT INTO Positions (title, description, price, photo_url, partner_id) VALUES
('Margarita', '30 см, традиционное тесто, 620 г,увеличенная порция моцареллы, томаты, итальянские травы, томатный соус', 2500 , '', (SELECT id FROM Partners WHERE title = 'DoDo Pizza')),
('Peperoni', '30 см, традиционное тесто, 490 г, пикантная пепперони из цыпленка, соус альфредо, моцарелла', 3500 , 'https://dve-palochky.kz/wp-content/uploads/2020/05/piczcza-pepperoni.png', (SELECT id FROM Partners WHERE title = 'DoDo Pizza')),
('4 Cheeses', '30 см, традиционное тесто, 490 г, увеличенная порция моцареллы, сыры чеддер и пармезан, соус альфредо', 3000 , 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSedq-sbo9lakhfPdz5j0pyExMjtBsniMSDA&usqp=CAU', (SELECT id FROM Partners WHERE title = 'DoDo Pizza')),
('Hamburger', 'Гамбургер куриный/говяжий', 990 , 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSKw4WJJn-93N_yg-R-azXv1F1Gm6Y5LOD-w&usqp=CAU', (SELECT id FROM Partners WHERE title = 'Salam Bro')),
('Cheeseburger', 'Гамбургер с сыром', 1090 , 'https://imageproxy.wolt.com/menu/menu-images/62738729c899a81590151cab/03135514-d053-11ec-9542-a6bf8c533053_whatsapp_image_2022_04_28_at_14.43.46.jpeg', (SELECT id FROM Partners WHERE title = 'Salam Bro')),
('Combo', 'Гамбургер/чизбургер + coca-cola 0,5л + картошка фри', 1690 , '', (SELECT id FROM Partners WHERE title = 'Salam Bro')),
('Nigiri', 'Сяке нежный лосось', 499 , '', (SELECT id FROM Partners WHERE title = 'Samurai Sushi')),
('Filadelfia', 'Pолл с сыром филадельфия и филе лосося', 1999 , 'https://www.samurai-sushi.kz/upload/resize_cache/iblock/77f/220_172_1/77f33226e943b1059eb6342891749c9a.jpg', (SELECT id FROM Partners WHERE title = 'Samurai Sushi')),
('Bonito Maki', 'ролл с лососем обжаренным в соусе терияки под стружкой тунца', 600 , '', (SELECT id FROM Partners WHERE title = 'Samurai Sushi')); 

INSERT INTO Clients (phone, fullname) VALUES 
('87477093388', 'Andrey Shapalov'),
('87773456785', 'Sonya Mashkina'),
('87753432278', 'Erbol Nazim');

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES 
('10:15:24', 'улица Жарокова 39', '43.244914', '76.898700', 'accepted', (SELECT id FROM Clients WHERE fullname = 'Andrey Shapalov')),
('12:21:30', 'улица Масанчи 76/98', '43.246821', '76.930372', 'is delivered' , (SELECT id FROM Clients WHERE fullname = 'Andrey Shapalov')),
('13:11:12', 'улица Жамбыла 205' , '43.244477', '76.897971', 'done', (SELECT id FROM Clients WHERE fullname = 'Andrey Shapalov')),
('23:24:11', 'улица Карасу 159', '43.237851', '76.886931', 'new', (SELECT id FROM Clients WHERE fullname = 'Sonya Mashkina')),
('16:45:32', 'улица Жандосова 36', '43.232974', '76.903238', 'accepted', (SELECT id FROM Clients WHERE fullname = 'Erbol Nazim')),
('18:54:59', 'ул. Шарипова 141/115', '43.245026', '76.922915', 'done', (SELECT id FROM Clients WHERE fullname = 'Sonya Mashkina'));

INSERT INTO Positions_Orders (position_id, order_id) VALUES
	((SELECT id FROM Positions WHERE title = 'Peperoni'), (SELECT id FROM Orders WHERE address = 'улица Жарокова 39' AND created_at = '10:15:24')),
	((SELECT id FROM Positions WHERE title = 'Margarita'), (SELECT id FROM Orders WHERE address = 'улица Жамбыла 205' AND created_at = '13:11:12')),
	((SELECT id FROM Positions WHERE title = 'Hamburger'), (SELECT id FROM Orders WHERE address = 'улица Жамбыла 205' AND created_at = '13:11:12')),
	((SELECT id FROM Positions WHERE title = 'Filadelfia'), (SELECT id FROM Orders WHERE address = 'улица Жамбыла 205' AND created_at = '13:11:12')),
	((SELECT id FROM Positions WHERE title = 'Filadelfia'), (SELECT id FROM Orders WHERE address = 'ул. Шарипова 141/115' AND created_at = 'ул. Шарипова 141/115')),
	((SELECT id FROM Positions WHERE title = 'Nigiri'), (SELECT id FROM Orders WHERE address = 'улица Жандосова 36' AND created_at = '16:45:32')),
	((SELECT id FROM Positions WHERE title = 'Filadelfia'), (SELECT id FROM Orders WHERE address = 'улица Жарокова 39' AND created_at = '10:15:24')),
	((SELECT id FROM Positions WHERE title = '4 Cheeses'), (SELECT id FROM Orders WHERE address = 'ул. Шарипова 141/115' AND created_at = 'ул. Шарипова 141/115')),
	((SELECT id FROM Positions WHERE title = 'Cheeseburger'), (SELECT id FROM Orders WHERE address = 'улица Жандосова 36' AND created_at = '16:45:32')),
	((SELECT id FROM Positions WHERE title = 'Cheeseburger'), (SELECT id FROM Orders WHERE address = 'улица Масанчи 76/98' AND created_at = '12:21:30')),
	((SELECT id FROM Positions WHERE title = 'Peperoni'), (SELECT id FROM Orders WHERE address = 'улица Карасу 159' AND created_at = '23:24:11'));


# Задание 2

SELECT DISTINCT Orders.id, Clients.phone, Partners.title FROM Clients
	LEFT JOIN Orders ON Clients.id = Orders.client_id
	LEFT JOIN Positions_Orders ON Orders.id = Positions_Orders.order_id
	LEFT JOIN Positions ON Positions_Orders.position_id = Positions.id
	LEFT JOIN Partners ON Positions.partner_id = Partners.id; 
    
# Задание 3

INSERT INTO Partners (title, description) VALUES ('Bahandi', 'Burgers and meals');

INSERT INTO Positions (title, description, price, photo_url, partner_id) VALUES 
('Double cheeseburger', 'Бургер с двойной говяжей котлетой и с сыром.', 1800, 'https://res.cloudinary.com/glovoapp/w_96,h_96,c_thumb,f_auto,q_auto:best/dpr_auto/Products/fve9cagiryg7wnq8wa2r', (SELECT id FROM Partners WHERE title = 'Bahandi'));

SELECT title FROM Partners
WHERE id NOT IN (
SELECT Partners.id FROM Positions_Orders
INNER JOIN Positions ON Positions_Orders.position_id = Positions.id
INNER JOIN Partners ON Positions.partner_id = Partners.id);

# Задание 4  

SET @client_id = 1;
SET @order_id = 7;

SELECT Positions.title FROM Positions
	LEFT JOIN Positions_Orders ON Positions_Orders.position_id = Positions.id
	LEFT JOIN Orders ON Positions_Orders.order_id = Orders.id
	LEFT JOIN Clients ON Orders.client_id = Clients.id
	WHERE Clients.id = @client_id AND Orders.id = @order_id;  