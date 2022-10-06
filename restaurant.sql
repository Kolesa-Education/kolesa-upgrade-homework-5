CREATE DATABASE restaurant;

USE restaurant;

CREATE TABLE partners (
                          id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                          title varchar(150) NOT NULL,
                          description text,
                          address varchar(255) NOT NULL
);

CREATE TABLE positions (
                           id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                           title varchar(255) NOT NULL,
                           description text,
                           price int NOT NULL DEFAULT(0),
                           photo_url varchar(255),
                           partner_id int UNSIGNED NOT NULL,
                           FOREIGN KEY (partner_id) REFERENCES partners(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE clients (
                         id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                         phone char(12),
                         fullname varchar(255)
);

CREATE TABLE orders (
                        id int UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        created_at datetime,
                        address varchar(255),
                        latitude float,
                        longitude float,
                        status enum('active', 'done'),
                        client_id int UNSIGNED NOT NULL,
                        FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE orders_positions (
                                  order_id int UNSIGNED NOT NULL,
                                  position_id int UNSIGNED NOT NULL,
                                  PRIMARY KEY (order_id, position_id),
                                  FOREIGN KEY (order_id) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE,
                                  FOREIGN KEY (position_id) REFERENCES positions(id) ON UPDATE CASCADE ON DELETE CASCADE
)

INSERT INTO partners (title, description, address) VALUES ("Loft", "Еда навынос, средний счёт 5000–7000 тнг, доставка еды. Типы доставки: собственная курьерская служба.", "ул. Байтурсынова, 46Б");
INSERT INTO partners (title, description, address) VALUES ("Асон", "Доставка еды, средний счёт от 3000 тнг.", "ул. Сатпаева, 1");
INSERT INTO partners (title, description, address) VALUES ("Пусан", "Доставка еды, средний счёт 1000–3000 тнг.", "ул. Сулейменова, 45");
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Чэтщэтэщипс — курица в сметанном соусе", "Рецепт адыгейской кухни - чэтщэтэщипс.", 4999, null, 1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Суп «Харчо»", "Суп харчо - вкусный, ароматный, острый.", 1999, null, 1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Куриный суп с плавленым сыром", "Очень сытный, нежный и ароматный куриный суп, не требующий много времени для приготовления", 2999, null, 1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Шурпа из говядины", "Как известно, обеденная трапеза должна начинаться из первого блюда.", 3999, null, 2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Тосканский суп с фаршем", "Разнообразить меню первых блюд трудно, мы привыкли готовить и есть одни и те же супы.", 2999, null, 2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Жюльен с курицей и грибами", "Очень популярную закуску - жульен", 999, null, 2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Куриный беф-строганов", "Бефстроганов из курицы - очень нежный и вкусный. И быстро готовится.", 2999, null, 3);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Джамбалайя", "Сегодня готовлю простое, вкусное и сытное блюдо американской кухни, на основе риса", 3999, null, 3);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Гречка по-купечески", "Гречка - А добавка будет?.", 1999, null, 3);

INSERT INTO clients (phone, fullname) VALUES ("+77078711815", "Виктор Николайвич");
INSERT INTO clients (phone, fullname) VALUES ("+77057852488", "Ербол Нурболов");
INSERT INTO clients (phone, fullname) VALUES ("+77777848547", "Султан Беков");

INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Ауезов", 58,3, 88,6, "active", 1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Ауезов", 58,3, 88,6, "done", 1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Ауезов", 58,3, 88,6, "active", 1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "пр.Мухтар", 8,8, 99,4, "done", 2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "пр.Мухтар", 8,8, 99,4, "active", 2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "пр.Мухтар", 8,8, 99,4, "done", 2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "пр.Мухтар", 8,8, 99,4, "active", 2);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Султан", 65,2, 78,5, "done", 3);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), "ул.Султан", 65,2, 78,5, "active", 3);


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

SELECT distinct ord.id, cln.phone, prt.title
FROM orders ord, clients cln, partners prt, positions pos, orders_positions op
WHERE cln.id = ord.client_id AND ord.id = op.order_id AND op.position_id = pos.id AND pos.partner_id = prt.id

INSERT INTO partners (title, description, address) VALUES ("Тагам", "Еда навынос, средний счёт 1000–2000 тнг, доставка еды.", "ул. Коркыт Ата, 52");

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ("Джалеби", "Джалеби - сладкие спиральки - одно из самых любимых лакомств индийцев.", 2999, null, 4);

SELECT prt.title FROM partners prt
WHERE prt.id NOT IN (SELECT pos.partner_id FROM orders_positions op, positions pos WHERE op.position_id=pos.id)

SELECT pos.title
FROM positions pos, orders ord, orders_positions op
WHERE ord.id = 1 AND ord.client_id = 1 AND pos.id = op.position_id AND ord.id = op.order_id