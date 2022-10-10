/* CREATE DB STRUCTURE */
CREATE DATABASE kolesa;

USE kolesa;

CREATE TABLE partners (
    id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title varchar(150) NOT NULL,
    description text,
    address varchar(255) NOT NULL
);

CREATE TABLE clients (
    id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    phone char(12),
    fullname varchar(255)
);

CREATE TABLE positions (
    id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
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
    id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    created_at datetime,
    address varchar(255),
    latitude float,
    longitude float,
    status enum('active', 'archived'),
    client_id int UNSIGNED NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id)
    	ON UPDATE CASCADE
    	ON DELETE RESTRICT
);

CREATE TABLE orders_positions (
    order_id int UNSIGNED NOT NULL,
    position_id int UNSIGNED NOT NULL,
    PRIMARY KEY (order_id, position_id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
    	ON UPDATE CASCADE
    	ON DELETE CASCADE,
    FOREIGN KEY (position_id) REFERENCES positions(id)
    	ON UPDATE CASCADE
    	ON DELETE CASCADE
)

/* Заполните базу тестовыми данными, не менее 3 партнеров, не менее 3 позиций для заказа у каждого из партнеров. 3 Пользователя, у каждого из которых от 1 до 5 заказов, в каждом из заказов от 1 до 3 позиций блюд */
INSERT INTO partners (title, description, address) VALUES ("The Benny Brothers", "Lorem ipsum dolor sit amet", "ул.Пушкина");
INSERT INTO partners (title, description, address) VALUES ("Viva Moojita", "Aliquam molestie finibus enim ut congue", "ул.Курмангазы");
INSERT INTO partners (title, description, address) VALUES ("No Bones Meals", "Mauris vitae orci turpis", "ул.Шевченко");

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Гамбургер", "Nunc sit amet cursus erat", 2000, null, 1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Суши", "Pellentesque habitant", 5000, null, 1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Пицца", "Cras a ante id quam", 4000, null, 1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Картошка с мясом", "Nunc sit amet cursus erat", 1800, null, 2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Вареники", "Cras enim magna", 1000, null, 2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Пельмени", "Morbi mollis iaculis elementum", 1200, null, 2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Паста", "Nunc sit amet cursus erat", 2500, null, 3);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Бефстроганов", "Nunc sit amet cursus erat", 2800, null, 3);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Мясо по-тайски", "Nunc sit amet cursus erat", 2400, null, 3);

INSERT INTO clients (phone, fullname) VALUES ("+77017777777", "Иванов Иван");
INSERT INTO clients (phone, fullname) VALUES ("+77775476324", "Сакенов Серик");
INSERT INTO clients (phone, fullname) VALUES ("+77057841212", "Сидоров Николай");

INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Кунаева", 21.4, 74.2, "active", 1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Кунаева", 21.4, 74.2, "archived", 1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Кунаева", 21.4, 74.2, "archived", 1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "пр.Достык", 12.7, 77.15, "archived", 2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "пр.Достык", 12.7, 77.15, "archived", 2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "пр.Достык", 12.7, 77.15, "archived", 2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "пр.Достык", 12.7, 77.15, "archived", 2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Сатпаева", 55.6, 23.7, "active", 3);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Сатпаева", 55.6, 23.7, "archived", 3);


INSERT INTO orders_positions (order_id, position_id) VALUES (1, 3);
INSERT INTO orders_positions (order_id, position_id) VALUES (1, 2);
INSERT INTO orders_positions (order_id, position_id) VALUES (2, 5);
INSERT INTO orders_positions (order_id, position_id) VALUES (2, 4);
INSERT INTO orders_positions (order_id, position_id) VALUES (2, 6);
INSERT INTO orders_positions (order_id, position_id) VALUES (3, 8);
INSERT INTO orders_positions (order_id, position_id) VALUES (4, 8);
INSERT INTO orders_positions (order_id, position_id) VALUES (4, 9);
INSERT INTO orders_positions (order_id, position_id) VALUES (5, 1);
INSERT INTO orders_positions (order_id, position_id) VALUES (5, 2);
INSERT INTO orders_positions (order_id, position_id) VALUES (6, 2);
INSERT INTO orders_positions (order_id, position_id) VALUES (6, 3);
INSERT INTO orders_positions (order_id, position_id) VALUES (7, 5);
INSERT INTO orders_positions (order_id, position_id) VALUES (7, 4);
INSERT INTO orders_positions (order_id, position_id) VALUES (7, 6);
INSERT INTO orders_positions (order_id, position_id) VALUES (8, 9);
INSERT INTO orders_positions (order_id, position_id) VALUES (8, 7);
INSERT INTO orders_positions (order_id, position_id) VALUES (9, 1);
INSERT INTO orders_positions (order_id, position_id) VALUES (9, 3);

/* Напишите запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера */
SELECT distinct ord.id, cln.phone, prt.title
FROM orders ord, clients cln, partners prt, positions pos, orders_positions op
WHERE cln.id = ord.client_id AND ord.id = op.order_id AND op.position_id = pos.id AND pos.partner_id = prt.id

/* Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы. Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа */
INSERT INTO partners (title, description, address) VALUES ("Вкусно и точка", "Lorem ipsum dolor sit amet", "ул.Гоголя");

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Роял бургер", "Nunc sit amet cursus erat", 2500, null, 4);

SELECT prt.title FROM partners prt
WHERE prt.id NOT IN (SELECT pos.partner_id
							FROM orders_positions op, positions pos
							WHERE	op.position_id=pos.id)

/* Напишите запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа */
SELECT pos.title
FROM positions pos, orders ord, orders_positions op
WHERE ord.id = 1 AND ord.client_id = 1 AND pos.id = op.position_id AND ord.id = op.order_id 







