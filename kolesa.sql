create database Kolesa_homework_5;

use Kolesa_homework_5;

CREATE TABLE Partners (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title varchar(150) NOT NULL,
    description text,
    address varchar(255) NOT NULL
);
    
CREATE TABLE Positions (
	id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	description text,
    price int NOT NULL default 0,
	photo_url varchar(255),
    partner_id int,
    FOREIGN KEY (partner_id) REFERENCES Partners(id)
);

CREATE TABLE Clients (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    phone char(12),
    fullname varchar(255)
); 

CREATE TABLE Orders (
	id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    created_at datetime,
    address varchar(255),
    latitude float,
    longitude float,
    status ENUM('open','close'),
    client_id int,
    FOREIGN KEY (client_id) REFERENCES Clients(id)
);
    
    
    
CREATE TABLE Orders_Positions (
    order_id int,
    position_id int, 
    PRIMARY KEY (order_id, position_id),
    FOREIGN KEY (order_id) REFERENCES Orders(id),
	FOREIGN KEY (position_id) REFERENCES Positions(id)
); 

/*Заполните базу тестовыми данными, не менее 3 пользователей, 3 партнеров, не менее 3 позиций для заказа у каждого из партнеров. 

3 Пользователя, у каждого из которых от 1 до 5 заказов, в каждом из заказов от 1 до 3 позиций блюд */

INSERT INTO 
	partners (title, description, address) 
VALUES
    (
        'McDonald`s',
        'fast food restaurant',
        'Beauty World 45'
    ),
    (
        'KFC',
        'fast food restaurant',
        'Downtown 54A'
    ),
    (
        'Eat',
        'foodcourt',
        'Segar 33B'
    );

SELECT
    *
FROM
    partners;

INSERT INTO
    clients (phone, fullname)
VALUES
    ('+6598765345', 'Alex'),
    ('+6578964536', 'Ricky'),
    ('+6578973452', 'Sun');

SELECT
    *
FROM
    clients;





INSERT INTO 
	Positions (title, description, price, photo_url, partner_id) 
VALUES
    (
        'Cheeseburger',
        'Sometimes you just want to reach for a classic. A classic 100% beef patty, and cheese; with onions, pickles, mustard and a dollop of tomato ketchup, in a soft bun. Delicious.',
        12,
        'https://www.mcdonalds.com.sg/sites/default/files/2021-06/product-cheeseburger-350x350.png',
        1
    ),(
        'Double Cheeseburger', 
     	'Love our Cheeseburger? Double it! Think two 100% beef patties with cheese, onions, pickles, mustard and a dollop of tomato ketchup, all in a perfectly soft bun.', 
    	 15, 
     	'https://www.mcdonalds.com.sg/sites/default/files/2021-06/product-double-cheeseburger-350x350.png', 
     	1
    ),(
        'McSpicy',
        'If you’re big on hot chilli spice, this is the sandwich for you. A thick, juicy cutlet of chicken thigh sits fiery hot on a bed of crunchy lettuce between toasted sesame seed buns – shiok!',
        13,
        'https://www.mcdonalds.com.sg/sites/default/files/2021-09/McSpicy.png',
        1
    ),
    (
        '2pcs Chicken Box',
        '- 2 pcs Chicken (Original Recipe / Hot & Crispy)
- 1 reg Fries
- 1 reg Whipped Potato
- 1 reg Coca-Cola® Zero Sugar',
        16,
        'https://www.kfc.com.sg//Content/OnlineOrderingImages/Menu/Items/item.png',
        2
    ),
    (
        'Original Recipe Burger Meal',
        '- 1 Original Recipe Burger
- 1 med Fries
- 1 reg Coca-Cola® Zero Sugar.',
        20,
        'https://www.kfc.com.sg//Content/OnlineOrderingImages/Menu/Items/item.png',
        2
    ),
    (
        'Mac&N Cheese Bowl Box',
        '- 1 Mac&N Cheese Bowl
- 1 pc Chicken (Original Recipe / Hot & Crispy)
- 1 reg Fries
- 1 reg Whipped Potato
- 1 reg Coca-Cola® Zero Sugar',
        10,
        'https://www.kfc.com.sg//Content/OnlineOrderingImages/Menu/Items/item.png',
        2
    ),(
        'Minced Meat Noodle',
        'Teochew-style bak chor mee (minced meat noodles) tossed in a vinegar and soy sauce mix plus specially-made sambal, paired with soft minced pork, sliced lean pork, fishball, crispy pork lard, and topped with stewed mushrooms.',
        12,
        'https://eat.com.sg/images/2018/10/31/mmnoodles.png',
        3
    ),
    (
        'Laksa',
        'Thick bee hoon in a mildly spicy broth made with creamy coconut milk and dried shrimp, complimented with ingredients like fresh cockles, fishcake, fried beancurd puffs and crispy beancurd rolls which absorb the fragrant broth.',
        15,
        'https://eat.com.sg/images/2018/11/01/laksa.png',
        3
    ),
    (
        'Fishball Noodles',
        'Well-seasoned egg noodles with a good texture, accompanied with flavourful hand-made Teochew fishballs and fishcake made with yellowtail fish.',
        14,
        'https://eat.com.sg/images/2018/11/01/fishballnoodles.png',
        3
    );

SELECT
    *
FROM
    Positions;

INSERT INTO
    orders (
        created_at,
        address,
        latitude,
        longitude,
        STATUS,
        client_id
    )
VALUES
    (
        '2022-10-01 13:54:00',
        'Segar 459',
        '1.3879402095498015',
        '103.77179903472138',
        'open',
        1
    ),
    (
        '2022-10-01 21:42:00',
        'Block 523 HDB Jelapang',
        '1.3872752167928828',
        '103.7653724625627',
        'close',
        1
    ),
    (
        '2022-10-06 20:31:00',
        'Block 104 HDB Teck Whye',
        '1.3771761008872525',
        '103.75294250343428',
        'open',
        1
    ),
    (
        '2022-10-04 14:04:00',
        'Hillsta',
        '1.3769535146188396',
        '103.75649696088878',
        'open',
        2
    ),
    (
        '2022-10-22 01:00:00',
        'Hillsta',
        '1.3769535146188396',
        '103.75649696088878',
        'open',
        2
    ),
    (
        '2022-10-02 12:02:00',
        'Segar 459',
        '1.3879402095498015',
        '103.77179903472138',
        'close',
        3
    );

SELECT
    *
FROM
    orders;


INSERT INTO
    Orders_Positions (order_id, position_id)
VALUES
    (1, 9),
    (1, 3),
    (2, 3),
    (2, 5),
    (1, 6),
    (3, 8),
    (2, 1),
    (3, 9),  
    (1, 1),
    (4, 9),
    (4, 3),
    (5, 5),
    (5, 6),
    (5, 8),
    (6, 9),  
    (6, 1)
;

SELECT * FROM orders_positions ORDER BY `order_id` ASC;


/*Task 2
Напишите запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера*/

SELECT orders.id, clients.phone, partners.title FROM orders

    JOIN clients ON orders.client_id = clients.id
    JOIN orders_positions ON orders.id = orders_positions.order_id
    JOIN positions ON orders_positions.position_id = positions.id
    JOIN partners ON positions.partner_id = partners.id;




/*			Task 3
Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы. */

INSERT INTO partners(title, description, address) VALUES 
(
	'Drink', 'Beverage shop', 'Fajar 45'
);

INSERT INTO positions(title, description, price, photo_url, partner_id) VALUES 
(
	'Bubble tea',
	'Image result for bubble tea. An incredibly unique looking beverage, Bubble tea is a Taiwanese recipe made by blending a tea base with milk, fruit and fruit juices, then adding the signature “bubbles” - yummy tapioca pearls that sit at the bottom.',
	'10',
	'https://cdn.shopify.com/s/files/1/0533/6743/9558/t/5/assets/pf-b8f4703d--featurepanelearlgreybubbletea.jpg?v=1628515523',
	(SELECT id FROM partners WHERE title = "Drink")
);

/*			Task 4
Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа*/

SELECT * FROM Partners WHERE Partners.id not in 
	(SELECT partner_id FROM Orders_Positions
	join Positions on Positions.id = Orders_Positions.position_id);





/* 			Task 5
Напишите запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа. */

SELECT Clients.id, Clients.fullname, Orders.id, Positions.title FROM Clients
JOIN Orders on Clients.id = Orders.client_id
JOIN Orders_Positions on Orders.id = Orders_Positions.Order_id
JOIN Positions on Orders_Positions.Position_id = Positions.id;
