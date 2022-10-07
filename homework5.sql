CREATE DATABASE kolesa;

CREATE TABLE partners (
      id  int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
      title varchar(150) NOT NULL,
      description text,
      address varchar(255) NOT NULL
);

CREATE TABLE clients (
         id  int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
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
        status enum('active', 'inactive'),
        client_id int UNSIGNED NOT NULL,
        FOREIGN KEY (client_id) REFERENCES clients(id)
            ON UPDATE CASCADE
            ON DELETE RESTRICT
);


CREATE TABLE orders_positions_join (
               order_id int UNSIGNED NOT NULL,
               position_id int UNSIGNED NOT NULL,
               PRIMARY KEY (order_id, position_id),
               FOREIGN KEY (order_id) REFERENCES orders(id)
                   ON UPDATE CASCADE
                   ON DELETE CASCADE,
               FOREIGN KEY (position_id) REFERENCES positions(id)
                   ON UPDATE CASCADE
                   ON DELETE CASCADE
);

# Заполните базу тестовыми данными, не менее 3 партнеров, не менее 3 позиций для заказа у каждого из партнеров.
# 3 Пользователя, у каждого из которых от 1 до 5 заказов, в каждом из заказов от 1 до 3 позиций блюд
INSERT INTO partners (title, description, address) VALUES ('title1', 'dec1', 'address1');
INSERT INTO partners (title, description, address) VALUES ('title2', 'desc2', 'address2');
INSERT INTO partners (title, description, address) VALUES ('title3', 'desc3', 'address3');

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('title4', 'desc4',40000, null, 1);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('title5', 'desc5',50000, null, 2);
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('title5', 'desc5',60000, null, 3);


INSERT INTO clients (phone, fullname) VALUES ('7777777777', 'Azamat');
INSERT INTO clients (phone, fullname) VALUES ('7575757575', 'Almas');
INSERT INTO clients (phone, fullname) VALUES ('8777453322','Kamys');


INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), 'addrees1', 25.6, 88.1, 'active', 1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), 'addrees2', 25.4, 23.2, 'active', 1);
INSERT INTO orders (created_at, address, latitude, longitude, status, client_id) VALUES (SYSDATE(), 'addrees3', 11.6, 79.2, 'active', 2);

INSERT INTO orders_positions_join (order_id, position_id) VALUES (1, 3);
INSERT INTO orders_positions_join (order_id, position_id) VALUES (2, 3);
INSERT INTO orders_positions_join (order_id, position_id) VALUES (3, 3);

# Напишите запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера

SELECT distinct ord.id, cln.phone, pr.title
FROM orders ord, clients cln, partners pr, positions pos, orders_positions_join ordjoin
WHERE cln.id = ord.client_id AND ord.id = ordjoin.order_id AND ordjoin.position_id = pos.id AND pos.partner_id = pr.id;

# Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы.
# Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа

INSERT INTO partners (title, description, address) VALUES ('title10', 'desc10', 'address10');

select *
from partners;
INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES ('title11', 'desc11', 4600, null, 4);


# Напишите запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа.
SELECT pos.title
FROM positions pos, orders ord, orders_positions_join ordjoin
WHERE ord.id = 1 AND ord.client_id = 1 AND pos.id = ordjoin.position_id AND ord.id = ordjoin.order_id