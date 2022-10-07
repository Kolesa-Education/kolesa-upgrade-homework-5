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

INSERT INTO Positions
	(`title`,`description`,`price`,`photo_url`,`partner_id`)
VALUES
	(`Бургер`, `Бургер — это блюдо, обычно состоящее из котлеты из измельченного мяса, как правило, говядины, помещенной внутрь нарезанной булочки.`, 890,`burger.png`, SELECT `id` from Partners WHERE `title`=`McDonalds`),
	(`Цезарь ролл`, `100% белое куриное мясо в хрустящей панировке, ломтик помидора, листья салата и ломтики твёрдого сыра, заправленные специальным соусом и завёрнутые в пшеничную лепешку.`, 1250,`roll.png`, SELECT `id` from Partners WHERE `title`=`McDonalds`),
	(`Пирожок чёрная смородина`, `Горячий пирожок из хрустящего теста с аппетитной начинкой из черной смородины. `, 500,`pirozhok.png`, SELECT `id` from Partners WHERE `title`=`McDonalds`),
	(`Спагетти Болоньезе`, `Густой мясной соус с томатами,
пармезаном, зеленью и маслом чили`, 2199,`lapsha1.png`, SELECT `id` from Partners WHERE `title`=`Del Papa`),
	(`Пирожок чёрная смородина`, `Горячий пирожок из хрустящего теста с аппетитной начинкой из черной смородины. `, 500,`pirozhok.png`, SELECT `id` from Partners WHERE `title`=`McDonalds`),
	(`Пирожок чёрная смородина`, `Горячий пирожок из хрустящего теста с аппетитной начинкой из черной смородины. `, 500,`pirozhok.png`, SELECT `id` from Partners WHERE `title`=`McDonalds`),

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

INSERT INTO 

INSERT INTO OrderPositions
	(`order_id`,`position_id`)
VALUES
	()
