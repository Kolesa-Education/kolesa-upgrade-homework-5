-- mysql -h localhost -u root -p

DROP DATABASE food_delivery; -- удалим базу, если она была создана ранее
CREATE DATABASE food_delivery; -- Создаем БД
USE food_delivery; -- начинаем работу в созданной БД


CREATE TABLE partners -- таблица партнеров
(
    id           int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title        varchar(150) NOT NULL,
    description_ text,
    address      varchar(255) NOT NULL
);


CREATE TABLE positions -- таблица позиций
(
    id           int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title        varchar(255) NOT NULL,
    description_ text,
    price        int UNSIGNED NOT NULL DEFAULT (0),
    photo_url    varchar(255),
    partner_id   int UNSIGNED NOT NULL,
    FOREIGN KEY (partner_id) REFERENCES partners (id)
        ON UPDATE CASCADE  -- при изменении id партнера в позициях также поменяем
        ON DELETE RESTRICT -- не удаляем партнера, пока у него есть заказы
    -- если удалим, то история заказа будет неполной, нарушается согласованность БД
);


CREATE TABLE clients -- таблица клиентов
(
    id       int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    phone    char(12) NOT NULL UNIQUE, -- телефон критично, чтобы был не пустым
    -- так как это способ коммуникации с клиентом
    -- и скорее всего будет использоваться для его авторизации
    fullname varchar(255)              -- имя может быть пустым, не критично
);


CREATE TABLE orders -- таблица заказов
(
    id         int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    created_at datetime                                                                        NOT NULL,
    address    varchar(255)                                                                    NOT NULL,
    latitude   float                                                                           NOT NULL,
    longitude  float                                                                           NOT NULL,
    status     enum ('Создан', 'Принят', 'Готовится', 'Доставляется', 'Доставлен', 'Отменен') NOT NULL,
    clien_id   int UNSIGNED                                                                    NOT NULL,
    FOREIGN KEY (clien_id) REFERENCES clients (id)
        ON UPDATE CASCADE  -- при изменении id клиента в заказах также поменяем
        ON DELETE RESTRICT -- не удаляем партнера, пока у него есть заказы
    -- если удалим, то история заказа будет неполной, нарушается согласованность БД
);


CREATE TABLE order_contents -- таблица состав заказов для связи заказов и позиций
(
    order_id    int UNSIGNED,
    position_id int UNSIGNED,
    quantity    int UNSIGNED NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (id)
        ON UPDATE CASCADE               -- при изменении id заказа в составе заказа также поменяем
        ON DELETE RESTRICT,             -- не удаляем заказ, пока у него есть в составе позиции
    FOREIGN KEY (position_id) REFERENCES positions (id)
        ON UPDATE CASCADE               -- при изменении id позиции в заказах также поменяем
        ON DELETE RESTRICT,             -- не удаляем позицию, пока он участвует в составе заказа
    PRIMARY KEY (order_id, position_id) -- составной ключ из заказа и позиции,
    -- так как у нас есть количество, то в сосатве одного заказа может быть только уникальная позиция
);


-- Задание 1. Заполнение БД

INSERT INTO partners (title, description_, address)
VALUES ('Qaganat', 'Столовая низшнго класса', 'проспект Абая 134/3'),
       ('АКУНИН', 'Суши бар для реальных бэкендеров', 'проспект Абая 21'),
       ('MC Donald\'s', 'Лучший фаст-фуд со средним чеком до 3К', 'улица Толе би 41');

SELECT *
FROM partners;


INSERT INTO positions (title, description_, price, photo_url, partner_id)
VALUES ('Котлета с пюрешкой', 'Классический обед трудяги, так как звучит по-простому', 980,
        'https://images.app.goo.gl/XWYhNygzWt1FRdrZ7', 1),
       ('Бризоль с рисом', 'Любимец бомжеватых хипстерских студетов, так как звучит пафосно', 1020,
        'https://images.app.goo.gl/Wsp6XTA6h8GvjPmr6', 1),
       ('Лагман по-домашнему',
        'Наворачивает слезы любому четкому пацану с юга вспомминаниями о родной маме и родного аула', 1220,
        'https://images.app.goo.gl/t91xUaBNUAW9MMWb6', 1),
       ('Филодельфия', 'Классический ролл, вкус семги и нежного сыра филодельфия', 3980,
        'https://images.app.goo.gl/QXgBSYuNvWw48atm9', 2),
       ('Унаги маки', 'Лучший ролл из лучших ингридиентов', 4020, 'https://images.app.goo.gl/jygg9JxmhbD1ypzG7', 2),
       ('Нигири из тунца', 'Для настоящих ценителей рыбы', 2220, 'https://images.app.goo.gl/3Y5b6Lc8eHRxv1S97', 2),
       ('Биг Мак', 'Самый сбалансированный бургер из ', 1600, 'https://images.app.goo.gl/6Q9MWJCShxh6po5R8', 3),
       ('Биг Тейсти', 'Для буржуа, самая дорогая позиция в меню', 2060, 'https://images.app.goo.gl/rA36BLfgcQiWu6mSA',
        3),
       ('Гамбургер из говодины', 'Для плебеев, не более. Не советую, если ты четкий', 650,
        'https://images.app.goo.gl/DSRTNhZcSTMLNS8s7', 3);

SELECT *
FROM positions;


INSERT INTO clients (phone, fullname)
VALUES ('87023456778', 'Борат Сагдиев'),
       ('+77777777778', 'Нурсултан Назарбаев'),
       ('+77777777777', 'Дмитрий Кузыров');

SELECT *
FROM clients;


INSERT INTO orders (created_at, address, latitude, longitude, status, clien_id)
VALUES (CURRENT_TIMESTAMP() - 200, 'Ниже Рыскулова, выше плинтуса', 43.307714, 76.919704, 'Доставлен', 1),
       (CURRENT_TIMESTAMP() - 500, 'Ак орда', 51.125894, 71.445965, 'Отменен', 2),
       (CURRENT_TIME(), 'Шевченко 157В', 43.243461, 76.900603, 'Принят', 3);

SELECT *
FROM orders;


INSERT INTO order_contents (order_id, position_id, quantity)
VALUES (1, 3, 2),
       (1, 2, 1),
       (2, 9, 5),
       (2, 7, 1),
       (3, 5, 1),
       (3, 6, 2),
       (3, 4, 1);

SELECT *
FROM order_contents;


-- Задание 2. Вывод номеров заказов (их ИД), номеров телефонов клиентов, названий партнеров

SELECT DISTINCT orders.id, clients.phone, partners.title
FROM orders
         LEFT JOIN clients ON orders.clien_id = clients.id
         LEFT JOIN order_contents ON orders.id = order_contents.order_id
         LEFT JOIN positions ON order_contents.position_id = positions.id
         LEFT JOIN partners ON positions.partner_id = partners.id


-- Задание 3. Добавьте еще одного партнера и минимум 1 позицию для него.
-- Но не создавайте заказы. Сделайте запрос, который выведет таких партнеров,
-- у которых еще не было ни одного заказа

INSERT INTO partners (title, description_, address)
VALUES ('Баханди', 'Быть жирным не запретишь', 'улица Казыбек би 24/1');

INSERT INTO positions (title, description_, price, photo_url, partner_id)
VALUES ('Двойной чизбергер', 'Миллиард коллорий для сотен килограммов', 1920,
        'https://images.app.goo.gl/BtaqXx5WW4Lm7Wqf9', 4);

WITH partners_with_orders AS
(
    SELECT DISTINCT partner_id
    FROM order_contents
    LEFT JOIN positions ON positions.id = order_contents.position_id
)

SELECT partners.*
FROM partners
         LEFT JOIN partners_with_orders p ON partners.id = p.partner_id
WHERE p.partner_id IS NULL;


-- Задание 4. Напишите запрос, который по ID пользователя и ID заказа
-- выведет названия всех позиций из этого заказа.

SELECT p.title
FROM order_contents
     LEFT JOIN orders o ON o.id = order_contents.order_id
     LEFT OUTER JOIN positions p ON p.id = order_contents.position_id
WHERE o.clien_id = 3 -- id клиента
  AND o.id = 3 -- id заказа
