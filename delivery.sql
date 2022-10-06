CREATE DATABASE homework5;
USE homework5;

#Задание 1

CREATE TABLE Partners(
	id int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);
SELECT * FROM Partners;

INSERT INTO Partners (title, description, address) 
VALUES ("Dodo", "Пиццерия для всех и вся", "ул. Байтурсынова 44");

INSERT INTO Partners (title, description, address) 
VALUES ("KFC", "Международная сеть ресторанов общественного питания, специализирующаяся на блюдах из курицы", "пр-т. Абая 44 ");

INSERT INTO Partners (title, description, address) 
VALUES ("McDonald's", "американская корпорация, работающая в сфере общественного питания, крупнейшая в мире сеть ресторанов быстрого питания, работающая по системе франчайзинга", "ул. Толе би 41 ");

CREATE TABLE Positions(
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	description text,
	price int UNSIGNED NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED  NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES Partners (id)
		ON UPDATE CASCADE 
		ON DELETE RESTRICT 
);


INSERT INTO Positions (title, description, price, photo_url, partner_id) VALUES
("Ветчина и грибы", "Ветчина из цыпленка, шампиньоны, моцарелла, томатный соус", 2400, "https://kuponoed.ru/wp-content/uploads/2020/03/5d93bdf.png",
(SELECT id FROM Partners WHERE title = "Dodo")),
("Пепперони", "Пепперони из цыпленка, увеличенная порция моцареллы, томатный соус", 2400, "https://www.gorodtaraz.kz/upload/000/u1/9f/59/pepperoni-photo-normal.jpg",
(SELECT id FROM Partners WHERE title = "Dodo")),
("Маргарита", "Увеличенная порция моцареллы, томаты, итальянские травы, томатный соус", 2100, "https://menu2go.ru/images/food/146/146_20210603151250_9645.jpeg",
(SELECT id FROM Partners WHERE title = "Dodo")),
("Дабл шефбургер комбо", "Дабл Шефбургер, картофель фри большой, Pepsi 0,5L, кетчуп", 3050, "https://eda.yandex.ru/images/3805363/f48108dc87ee44db2aad6d55e680c2d2-680x500.jpg",
(SELECT id FROM Partners WHERE title = "KFC")),
("Боксмастер комбо", "Боксмастер, картофель фри большой, Pepsi 0,5L, кетчуп", 2800, "https://www.kfc.kz/admin/files/medium/medium_4311.jpg",
(SELECT id FROM Partners WHERE title = "KFC")),
("Баскет 28 крыльев комбо", "Баскет 28 острых крыльев, Pepsi 2L, баскет фри, 3 сырных соуса, 2 кетчупа", 10350, "https://www.kfc.kz/admin/files/medium/medium_4352.jpg",
(SELECT id FROM Partners WHERE title = "KFC")),
("Биг Тейсти", "Аппетитный сандвич с рубленным бифштексом из 100% из говядины на большой и свежей булочке с кунжутом. Кусочки сыра, свежие овощи и пряный соус «Гриль»", 2700, "https://mcdonalds.kz/storage/2537/ebd2fc30c08f31b8a05224083501cb46ed0fe8cb.png",
(SELECT id FROM Partners WHERE title = "McDonald's")),
("Двойной чизбургер", "Два сочных бифштекса из натуральной цельной говядины с кусочками сыра на специальной булочке, заправленной горчицей, кетчупом, луком и кусочком маринованного огурчика", 1800, "https://mcdonalds.kz/storage/2524/673ad1201e4f4d00b82e3104f3bbd23a5fdcecc1.png",
(SELECT id FROM Partners WHERE title = "McDonald's")),
("Чикен Тейсти", "Cандвич с большой куриной котлетой, панированной в сухарях на большой булочке с кунжутом. Три кусочка сыра, два ломтика помидора, свежий салат, свежий лук и пикантный соус «Гриль».", 2500, "https://mcdonalds.kz/storage/2540/190cca100e0c151cc688e53899ac69829931ca02.png",
(SELECT id FROM Partners WHERE title = "McDonald's"));

SELECT * FROM Positions;

CREATE TABLE Clients(
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	phone char(12),
	fullname varchar(255)
);

SELECT * FROM Clients;

INSERT INTO Clients (phone, fullname) VALUES 
("+77771234567", "Иван Иванов"),
("+78005553535", "Валерий Жмыщенко"),
("+74732263317", "Михаил Шуфутинский");

CREATE TABLE Orders(
	id int UNSIGNED PRIMARY KEY NOT NULL , 
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum("Новый", "Принят рестораном", "Доставляется", "Завершен"),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES Clients (id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);

ALTER TABLE Orders
MODIFY COLUMN id int UNSIGNED NOT NULL AUTO_INCREMENT;

SELECT * FROM Orders;

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES
(NOW(), "Розыбакиева 163", 43.2, 76.8, "Принят рестораном", (SELECT id FROM Clients WHERE fullname = "Иван Иванов")),
(NOW(), "Толе Би 67", 41.5, 52.5, "Новый", (SELECT id FROM Clients WHERE fullname = "Валерий Жмыщенко")),
(NOW(), "Абая 44", 49.3, 72.1, "Принят рестораном", (SELECT id FROM Clients WHERE fullname = "Михаил Шуфутинский"));

CREATE TABLE Orders_positions (
	order_id int UNSIGNED NOT NULL,
	position_id int UNSIGNED NOT NULL,
	PRIMARY KEY (order_id, position_id),
	FOREIGN KEY (order_id) REFERENCES Orders (id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT,
	FOREIGN KEY (position_id) REFERENCES Positions (id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

SELECT * FROM Orders_positions;

INSERT INTO Orders_positions (order_id, position_id) VALUES 
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM Positions WHERE title = "Ветчина и грибы")),
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM Positions WHERE title = "Маргарита")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM Positions WHERE title = "Дабл шефбургер комбо")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM Positions WHERE title = "Баскет 28 крыльев комбо")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM Positions WHERE title = "Двойной чизбургер")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM Positions WHERE title = "Биг Тейсти"));

#Задание 2

SELECT Orders.id, Clients.phone, Partners.title FROM Orders 
INNER JOIN Orders_positions ON Orders.id = Orders_positions.order_id
INNER JOIN Positions ON Positions.id = Orders_positions.position_id
INNER JOIN Clients ON Orders.client_id = Clients.id
INNER JOIN Partners ON Partners.id = Positions.partner_id

#Задание 3

INSERT INTO Partners (title, description, address) 
VALUES ("Bahandi", "Гамбургерная", "ул. Масанчи 96");

INSERT INTO Positions (title, description, price, photo_url, partner_id) VALUES
("Menu Cheese Burger говяжий х2", "Бургер с двойной говяжей котлетой с сыром, порция картошки фри, напиток на выбор, соус на выбор.", 2700, "https://102922.selcdn.ru/nomenclature_images/ba34c832-bace-11ea-aa5c-0025906bfe47/f4338b5e-55ba-4c75-abf3-715b0a5dde21.jpg",
(SELECT id FROM Partners WHERE title = "Bahandi"));

SELECT Partners.title FROM Partners WHERE Partners.id NOT IN 
(SELECT partner_id FROM Orders_positions
JOIN Positions ON Positions.id = Orders_positions.position_id);

#Задание 4 

SELECT Positions.title FROM Orders, Positions, Orders_positions
WHERE Orders_positions.order_id = Orders.id
AND Orders_positions.position_id = Positions.id 
AND Orders.id = 2
AND Orders.client_id = 2;







