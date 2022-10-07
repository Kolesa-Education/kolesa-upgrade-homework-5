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
	`order_id` INT UNSIGNED,
	FOREIGN KEY (`partner_id`) REFERENCES Partners(`id`),
	FOREIGN KEY (`order_id`) REFERENCES Orders(`id`)
);

INSERT INTO `Partners` 
    (`title`, `description`, `address`) 
VALUES 
    ('Mc Donalds', 'Фаст-Фуд', 'Сыганак'),
    ('Del papa', 'Ресторан', 'Кабанбай батыр'),
    ('COFFEEDAY', 'Кофейня', 'Туран');

INSERT INTO `Clients` 
    (`phone`, `fullname`) 
VALUES 
    ('87084561232', 'Иван Быков'),
    ('87774561239', 'Темирлан Шалкаров'),
    ('87871234578', 'Патрик Бейтман');
    
 