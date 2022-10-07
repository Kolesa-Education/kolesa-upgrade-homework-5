CREATE DATABASE kolesa-homework;
USE kolesa-homework;

CREATE TABLE Partners(
     id int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
     title varchar(150) NOT NULL,
     description text,
     address varchar(255) NOT NULL
);

CREATE TABLE Positions(
    id int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    description text,
    price int UNSIGNED NOT NULL DEFAULT(0),
    photo_url varchar(255),
    partner_id int UNSIGNED  NOT NULL,
    FOREIGN KEY (partner_id) REFERENCES Partners (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Clients(
    id int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    phone char(12),
    fullname varchar(255)
);

CREATE TABLE Orders(
   id int UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
   created_at datetime,
   address varchar(255),
   latitude float,
   longitude float,
   status enum("Новый", "В процессе", "В доставке", "Завершен"),
   client_id int UNSIGNED NOT NULL,
   FOREIGN KEY (client_id) REFERENCES Clients (id)
       ON UPDATE CASCADE
       ON DELETE CASCADE
);

CREATE TABLE Orders_Positions (
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

#Task 1
INSERT INTO Partners (title, description, address)
VALUES ("Salam Bro", "Дешёво и сердито", "ул. Есенина 23");

INSERT INTO Partners (title, description, address)
VALUES ("Bahandi", "Недёшево и сердито", "ул. Каруселина 47/3");

INSERT INTO Partners (title, description, address)
VALUES ("Hardee's", "Недёшево и не сердито", "ул. Райымбека 77");

INSERT INTO Positions (title, description, price, photo_url, partner_id) VALUES
("Говяжий бургер", "Говяжий бургер из Салам бро", 1300, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Salam Bro")),
("Куриный бургер", "Куриный бургер из Салам бро", 1100, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Salam Bro")),
("Спать бургер", "Спать бургер из Салам бро", 1600, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Salam Bro")),
("Говяжий чизбургер", "Говяжий чизбургер из Баханди", 1400, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Bahandi")),
("Экстра бургер", "Экстра бургер из Баханди", 1700, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Bahandi")),
("Хот хот-дог", "Хот хот-дог из Баханди", 1200, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Bahandi")),
("Мощь бургер", "Мощь бургер из Хардис", 1800, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Hardee's")),
("Немощь бургер", "Немощь бургер из Хардис", 1799, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Hardee's")),
("Король бургеров", "Король бургеров из Хардис", 2000, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "Hardee's")),

INSERT INTO Clients (phone, fullname) VALUES
("+77007007070", "Марко Поло"),
("+78005553535", "Никола Тесла"),
("+77474700770", "Тестобек Тестов");

INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id) VALUES
(NOW(), "пр. Достык 123", 23.4, 6.44, "В процессе", (SELECT id FROM Clients WHERE phone = "+77007007070")),
(NOW(), "ул. Розыбакиева 78", 39.2, 42.9, "В доставке", (SELECT id FROM Clients WHERE phone = "+78005553535")),
(NOW(), "ул. Казыбек би 3", 24.2, 84.1, "Новый", (SELECT id FROM Clients WHERE phone = "+77474700770"));

INSERT INTO Orders_Positions (order_id, position_id) VALUES
((SELECT id FROM Orders WHERE id = 1),(SELECT id FROM Positions WHERE title = "Хот хот-дог")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM Positions WHERE title = "Спать бургер")),
((SELECT id FROM Orders WHERE id = 2),(SELECT id FROM Positions WHERE title = "Говяжий бургер")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM Positions WHERE title = "Говяжий бургер")),
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM Positions WHERE title = "Король бургеров"));
((SELECT id FROM Orders WHERE id = 3),(SELECT id FROM Positions WHERE title = "Мощь бургер"));

#Task 2
SELECT Orders.id, Clients.phone, Partners.title FROM Orders
    JOIN Clients ON Orders.client_id = Clients.id
    JOIN Orders_Positions ON Orders.id = Orders_Positions.order_id
    JOIN Positions ON Positions.id = Orders_Positions.position_id
    JOIN Partners ON Partners.id = Positions.partner_id

#Task 3
INSERT INTO Partners (title, description, address)
VALUES ("KFC", "Ки Эф Си - больше не слова", "ул. Правды 96");

INSERT INTO Positions (title, description, price, photo_url, partner_id) VALUES
("Бургер из Кентуки", "Американское противостояние с импортозамещением", 2222, "https://emosurff.com/i/0004R8005tf0/img_3911.jpg",
    (SELECT id FROM Partners WHERE title = "KFC"));

#Task 4
SELECT Positions.title FROM Orders, Positions, Orders_Positions
WHERE Orders.id = 1 AND Orders.client_id = 1
  AND Orders_Positions.order_id = Orders.id
  AND Orders_Positions.position_id = Positions.id;