CREATE DATABASE IF NOT EXISTS food_delivery;
USE food_delivery;
CREATE TABLE IF NOT EXISTS Partners (
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	`title` VARCHAR(150) NOT NULL,
	`description` TEXT,
	`address` VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Clients (
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`phone` CHAR(12),
	`fullname` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Orders (
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	`created_at` DATETIME,
	`address` VARCHAR(255),
	`latitude` FLOAT,
	`longitude` FLOAT,
	`status` ENUM('new','accepted','delivering','finished'),
	`client_id` INT UNSIGNED,
	FOREIGN KEY (`client_id`) REFERENCES Clients(`id`)
);
CREATE TABLE IF NOT EXISTS Positions (
	`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`title` VARCHAR(255) NOT NULL,
	`description` TEXT,
	`price` INT NOT NULL DEFAULT(0),
	`photo_url` VARCHAR(255),
	`partner_id` INT UNSIGNED,
	FOREIGN KEY (`partner_id`) REFERENCES Partners(`id`)
);

CREATE TABLE IF NOT EXISTS OrderPositions (
	`order_id` INT UNSIGNED,
	`position_id` INT UNSIGNED,
	FOREIGN KEY (`order_id`) REFERENCES Orders(`id`),
	FOREIGN KEY (`position_id`) REFERENCES Positions(`id`)
);

INSERT INTO `Partners` 
    (`title`, `description`, `address`) 
VALUES 
    ('McDonalds', 'Фаст-Фуд', 'Сыганак'),
    ('Del Papa', 'Ресторан', 'Кабанбай батыр'),
    ('COFFEEDAY', 'Кофейня', 'Туран');

INSERT INTO `Clients` 
    (`phone`, `fullname`) 
VALUES 
    ('87084561232', 'Иван Быков'),
    ('87774561239', 'Темирлан Шалкаров'),
    ('87871234578', 'Патрик Бейтман');
    
INSERT INTO `Orders`
	(`created_at`,`address`,`latitude`,`longitude`,`status`,`client_id`)
VALUES
	(SYSDATE(), "Туран", "70.3464" , "50.145615", "new", 1),
	(SYSDATE(), "Кабанбай батыра", "72.51515" , "55.124124","accepted", 1),
	(SYSDATE(), "Улы дала", "71.34634" , "47.12512", "new", 3),
	(SYSDATE(), "Шевченко", "75.34634" , "45.345345","finished", 3),
	(SYSDATE(), "Сауран", "71.51515" , "54.65567","delivering", 2),
	(SYSDATE(), "Алматы", "80.535212" , "50.235235", "new", 2);

INSERT INTO Positions
	(`title`,`description`,`price`,`photo_url`,`partner_id`)
VALUES
	('Бургер', 'Бургер — это блюдо, обычно состоящее из котлеты из измельченного мяса, как правило, говядины, помещенной внутрь нарезанной булочки.', 890,'burger.png', (SELECT `id` from Partners WHERE `title`='McDonalds')),
	('Цезарь ролл', '100% белое куриное мясо в хрустящей панировке, ломтик помидора, листья салата и ломтики твёрдого сыра, заправленные специальным соусом и завёрнутые в пшеничную лепешку.', 1250,'roll.png', (SELECT `id` from Partners WHERE `title`='McDonalds')),
	('Пирожок чёрная смородина', 'Горячий пирожок из хрустящего теста с аппетитной начинкой из черной смородины. ', 500,'pirozhok.png', (SELECT `id` from Partners WHERE `title`='McDonalds')),
	('Спагетти Болоньезе', 'Густой мясной соус с томатами,пармезаном, зеленью и маслом чили', 2199,'lapsha1.png', (SELECT `id` from Partners WHERE `title`='Del Papa')),
	('Пенне Арабьята', 'Классическая острая паста с томатным соусом, чили и базиликом', 1899,'penne.png', (SELECT `id` from Partners WHERE `title`='Del Papa')),
	('Ризотто с грибами', 'Традиционный рис карнароли с лесными грибами, шафраном и пармезаном', 1999,'Rizotto.png', (SELECT `id` from Partners WHERE `title`='Del Papa')),
	('Капучино', 'Эспрессо, взбитое молоко (забота бариста о вас)', 690,'capuccino.png', (SELECT `id` from Partners WHERE `title`='COFFEEDAY')),
	('Латте', 'Эспрессо, взбитое молоко (забота бариста о вас)', 690,'Rizotto.png', (SELECT `id` from Partners WHERE `title`='COFFEEDAY')),
	('Американо', 'Двойной эспрессо, горячая вода (забота бариста о вас)', 590,'americano.png', (SELECT `id` from Partners WHERE `title`='COFFEEDAY'));

INSERT INTO OrderPositions
	(`order_id`,`position_id`) 
VALUES
	((SELECT `id` FROM Orders WHERE `id` = 1),(SELECT `id` FROM Positions WHERE `title` = 'Бургер')),
	((SELECT `id` FROM Orders WHERE `id` = 1),(SELECT `id` FROM Positions WHERE `title` = 'Пенне Арабьята')),
	((SELECT `id` FROM Orders WHERE `id` = 1),(SELECT `id` FROM Positions WHERE `title` = 'Капучино')),
	((SELECT `id` FROM Orders WHERE `id` = 2),(SELECT `id` FROM Positions WHERE `title` = 'Спагетти Болоньезе')),
	((SELECT `id` FROM Orders WHERE `id` = 2),(SELECT `id` FROM Positions WHERE `title` = 'Ризотто с грибами')),
	((SELECT `id` FROM Orders WHERE `id` = 3),(SELECT `id` FROM Positions WHERE `title` = 'Латте')),
	((SELECT `id` FROM Orders WHERE `id` = 3),(SELECT `id` FROM Positions WHERE `title` = 'Цезарь ролл')),
	((SELECT `id` FROM Orders WHERE `id` = 4),(SELECT `id` FROM Positions WHERE `title` = 'Тирамису')),
	((SELECT `id` FROM Orders WHERE `id` = 4),(SELECT `id` FROM Positions WHERE `title` = 'Матча чай')),
	((SELECT `id` FROM Orders WHERE `id` = 4),(SELECT `id` FROM Positions WHERE `title` = 'Американо')),
	((SELECT `id` FROM Orders WHERE `id` = 5),(SELECT `id` FROM Positions WHERE `title` = 'Американо')),
	((SELECT `id` FROM Orders WHERE `id` = 6),(SELECT `id` FROM Positions WHERE `title` = 'Пирожок чёрная смородина')),
	((SELECT `id` FROM Orders WHERE `id` = 6),(SELECT `id` FROM Positions WHERE `title` = 'Спагетти Болоньезе'));


SELECT Orders.`id` AS 'Номер заказа', Clients.`phone` AS 'Номер телефона клиента', Partners.`title` AS 'Партнер'
FROM Orders
	JOIN OrderPositions  
		ON Orders.`id` = OrderPositions.`order_id`
	JOIN Positions 
		ON Positions.`id` = OrderPositions.`position_id`
	JOIN Clients
		ON Orders.`client_id` = Clients.`id`
	JOIN Partners
		ON Partners.`id` = Positions.`partner_id`;

		

INSERT INTO `Partners` 
    (`title`, `description`, `address`) 
VALUES 
    ('Burger King', 'Фаст-Фуд', 'Кабанбай батыра');

INSERT INTO Positions 
	(`title`, `description`,`price`,`partner_id`)
VALUES
 	("ВОППЕР",'Фирменный, сытный бургер с овощами, со 100% говядиной, приготовленной на открытом огне',1500,(SELECT id FROM Partners WHERE title = "Burger King"));

SELECT * FROM Partners
	WHERE Partners.`id` NOT IN (
		 (
			SELECT `partner_id` FROM Positions
		 		JOIN OrderPositions
					ON Positions.`id` = OrderPositions.`position_id` 
						WHERE Positions.`id` = OrderPositions.`position_id`
		 ) 
	);





SELECT o.`id` AS 'Номер Заказа' ,p.`id` 'Номер позиции',p.`title` FROM Orders AS o, Positions AS p, OrderPositions
 	WHERE OrderPositions.`order_id` = o.`id`
 	AND OrderPositions.`position_id` = p.`id` ;