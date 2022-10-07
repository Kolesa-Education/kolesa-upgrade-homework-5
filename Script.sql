CREATE DATABASE kolesa;

USE kolesa;

CREATE TABLE Partners (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);


CREATE TABLE Positions (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	description text,
	price int NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES Partners(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE
	
);

CREATE TABLE Clients (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	phone char(12),
	fullname varchar(255)
	
);

CREATE TABLE Orders (
	id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum("new","adopted","delivered","completed"),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES Clients(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
	
);

CREATE TABLE Positions_Orders (
	position_id int UNSIGNED NOT NULL,
	orders_id int UNSIGNED NOT NULL,
	PRIMARY KEY (position_id,orders_id),
	FOREIGN KEY (position_id) REFERENCES Positions(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (orders_id) REFERENCES Orders(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
	
);

#add partners

INSERT INTO Partners (title,description,address) 
VALUES ("Rumi","delicious pilaf and lagman center","Mega SilkWay"),
		("CofeeBoom","Delicious coffee and sweets","Mngilik El 47"),
		("Salam Bro","Insanely delicious burger","Kabanbay batyr 58");
	

#add positions
#Rumi	
INSERT INTO Positions (title,description,price,partner_id)
VALUES("Плов","Плов — блюдо восточной кухни, основу которого составляет варёный рис.",1890,(SELECT id FROM Partners WHERE title="Rumi")),
	("Манты","ма́нты — традиционное, преимущественно мясное блюдо народов Центральной Азии, Турции, Монголии, Кореи, Татарстана, Башкортостана, Крыма, Таджикистана, Киргизии, Казахстана, Узбекистана и Китая, состоящее из мелко нарубленного мяса в тонко раскатанном тесте, приготовленное на пару в мантоварке.",
	1500,(SELECT id FROM Partners WHERE title="Rumi")),
	("Лагман","Лагма́н — блюдо народов Центральной Азии. Корни происхождения лагмана уходят в Восточный Туркестан. ",1600,(SELECT id FROM Partners WHERE title="Rumi"));

#CofeeBoom
INSERT INTO Positions (title,description,price,partner_id)
VALUES("Кофе","Ко́фе — напиток из жареных и перемолотых зёрен кофейного дерева или кофейного куста.",700,(SELECT id FROM Partners WHERE title="CofeeBoom")),
		("Напалеон","Мильфей, известный под названиями «Наполеон», «ванильный слайс» и «кремовый слайс» — французский десерт на основе слоёного теста с кремом в виде пирожного или торта.",1300,
		(SELECT id FROM Partners WHERE title="CofeeBoom")),
		("Паста","Макаро́нные изде́лия — изделия различной формы из высушенного теста, замешанного из пшеничной муки и воды.",3200,(SELECT id FROM Partners WHERE title="CofeeBoom"));

#SalamBro
INSERT INTO Positions (title,description,price,partner_id)
VALUES("Бургер Говяжий",null,1200,(SELECT id FROM Partners WHERE title="Salam Bro")),
		("Мороженое","Моро́женое — пищевой продукт-десерт, представляющий собой замороженную в процессе непрерывного взбивания массу, содержащую в основе своей питательные, вкусовые, ароматические и эмульгирующие вещества. К мороженому нередко относят также фруктовый лёд, получаемый простым замораживанием фруктово-ягодных соков и пюре.",
		800,(SELECT id FROM Partners WHERE title="Salam Bro")),
		("Гамбургер","Га́мбургер — это блюдо, обычно состоящее из котлеты из измельченного мяса, как правило, говядины, помещенной внутрь нарезанной булочки.",
		1100,(SELECT id FROM Partners WHERE title="Salam Bro"));

#add clients
INSERT INTO Clients (phone, fullname) VALUES (87476711939, "Канатов Нуржас");
INSERT INTO Clients (phone, fullname) VALUES (87476568168, "Кожамуратова Манар");
INSERT INTO Clients (phone, fullname) VALUES (87771231234, "Жандосов Нуржан");

#add orders

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-04 14:05:00",
	"Кабанбай Батыр 13",
	12.34,
	14.56,
	"completed",
	1
);

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-05 16:05:00",
	"Кабанбай Батыр 13",
	12.34,
	14.56,
	"new",
	1
);

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-10-05 15:25:10",
	"Кабанбай Батыр 25/17 кв.1",
	32.567,
	143.56,
	"delivered",
	2
);

INSERT INTO Orders (address, latitude, longitude, status, client_id) VALUES (
	"Кабанбай Батыр 25/17 кв.1",
	32.567,
	143.56,
	"new",
	2
);


INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-09-17 18:21:19",
	"Кабанбай Батыр 25/17, кв.1",
	32.567,
	143.56,
	"adopted",
	2
);

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES (
	"2022-09-14 00:29:19",
	"Кошкарбаева 54, 6",
	145.567,
	36.56,
	"completed",
	3
);


#add positions_orders
INSERT INTO Positions_Orders (orders_id, position_id) SELECT 1, id FROM Positions WHERE title="Плов";
INSERT INTO Positions_Orders  (orders_id, position_id) SELECT 1, id FROM Positions WHERE title="Напалеон";

INSERT INTO Positions_Orders  (orders_id, position_id) SELECT 2, id FROM Positions WHERE title="Кофе";

INSERT INTO Positions_Orders (orders_id, position_id) SELECT 3, id FROM Positions WHERE title="Манты";
INSERT INTO Positions_Orders (orders_id, position_id) SELECT 3, id FROM Positions WHERE title="Бургер Говяжий";
INSERT INTO Positions_Orders (orders_id, position_id) SELECT 3, id FROM Positions WHERE title="Мороженое";


INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="new" AND client_id=2), 
	(SELECT id FROM Positions WHERE title="Лагман")
);

INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="delivered" AND client_id=2), 
	(SELECT id FROM Positions WHERE title="Паста")
);

INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="adopted" AND client_id=2), 
	(SELECT id FROM Positions WHERE title="Гамбургер")
);

INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="new" AND client_id=2), 
	(SELECT id FROM Positions WHERE title="Мороженое")
);

INSERT INTO Positions_Orders (orders_id, position_id) VALUES (
	(SELECT id FROM Orders WHERE status="completed" AND client_id=3), 
	(SELECT id FROM Positions WHERE title="Плов")
);

# 2. запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера

SELECT Orders.id, Clients.phone, Partners.title FROM Orders 
JOIN Clients ON Orders.client_id = Clients.id 
JOIN Positions_Orders ON Orders.id = Positions_Orders.orders_id  
JOIN Positions ON Positions_Orders.position_id = Positions.id 
JOIN Partners ON Positions.partner_id = Partners.id;

# 3. Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы. Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа
INSERT INTO Partners (title, address) VALUES ("KFS", "Mega SilkWay");

INSERT INTO Positions (title, price, partner_id) VALUES ("Куриные крылышки", 3500, 
	(SELECT id FROM Partners artners WHERE title="KFS")
);

SELECT * FROM Partners WHERE id NOT IN (
	SELECT partner_id FROM Positions_Orders JOIN Positions ON Positions.id = Positions_Orders.position_id 
);

# 4. запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа.
SELECT Positions.title 
FROM Orders, Positions_Orders, Positions 
WHERE Orders.client_id = 1 AND Orders.id = 1 AND Positions_Orders.orders_id  = Orders.id AND Positions_Orders.position_id = Positions.id;


















