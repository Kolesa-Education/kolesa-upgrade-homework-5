create table Clients
(
    id       int          not null
        primary key,
    phone    char(12)     not null,
    fullname varchar(255) not null
);

create table Orders
(
    id           int                                                              not null
        primary key,
    created_at   datetime                                                         ,
    address      varchar(255)                                                     not null,
    latitude     float                                                            not null,
    longitude    float                                                            not null,
    order_status enum ('новый', 'принят рестораном', 'доставляется', 'завершен') ,
    client_id    int                                                              not null,
    constraint Orders_Clients_fk
        foreign key (client_id) references Clients (id)
);

create table Partners
(
    id          int          not null
        primary key,
    title       varchar(150) not null,
    description text         ,
    address     varchar(255) not null
);

create table Positions
(
    id          int           not null
        primary key,
    title       varchar(255)  not null,
    description text          ,
    price       int default 0 not null,
    photo_url   varchar(255)  ,
    partner_id  int           not null,
    constraint Positions_Partners_fk
        foreign key (partner_id) references Partners (id)
);

create table orders_positions
(
    order_id    int not null,
    position_id int not null,
    constraint orders_positions_Orders_fk
        foreign key (order_id) references Orders (id),
    constraint orders_positions_Positions_fk
        foreign key (position_id) references Positions (id)
);

INSERT INTO Partners (id, title, description, address) VALUES (1, 'KFC', 'Ресторан бытрого питания', 'Керей-Жанибек хандар, 12');
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (1, 'Чикен Пита Комбо', 'Чикен Пита, картофель фри большой, Pepsi 0.5L, кетчуп ', 2450, 'https://www.kfc.kz/admin/files/medium/medium_4393.jpg', 1);
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (2, 'ФРЕНДС БОКС АССОРТИ', '5 ножек, 10 острых крыльев, 5 стрипсов, байтс 270 гр, баскет фри', 8250, 'https://www.kfc.kz/admin/files/medium/medium_4340.jpg', 1);
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (3, 'ШЕФ ТАУЭР БОКС', 'Шеф Тауэр, 2 стрипса, картофель фри большой, Pepsi 0,5L, сырный соус', 3440, 'https://www.kfc.kz/admin/files/4345.jpg', 1);



INSERT INTO Partners (id, title, description, address) VALUES (2, 'McDonald''s', 'Сеть ресторанов быстрого обслуживания', 'Проспект Сарыарка, 9д');
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (4, 'McCombo Двойной чизбургер', 'Два сочных бифштекса из натуральной цельной говядины с кусочками сыра на специальной булочке, заправленной горчицей, кетчупом, луком и кусочком маринованного огурчика, стандартная порция обжаренного и слегка посоленного картофеля фри, газированный напиток Coca-Cola, Coca-Cola No sugar, Fanta, Sprite 0,4 л. или чай черный, чай зеленый 0,2 л. и соус на Ваш выбор.', 1800, 'https://mcdonalds.kz/storage/2524/673ad1201e4f4d00b82e3104f3bbd23a5fdcecc1.png', 2);
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (5, 'McCombo Макчикен', 'Обжаренная куриная котлета, панированная в сухарях, которая подается на карамелизованной булочке, заправленной свежим салатом и специальным соусом , стандартная порция обжаренного и слегка посоленного картофеля фри, газированный напиток Coca-Cola, Coca-Cola No sugar, Fanta, Sprite 0,4 л. или чай черный, чай зеленый 0,2 л. и соус на Ваш выбор.', 1950, 'https://mcdonalds.kz/storage/2516/da141df1378dc814686593419c679a10f4ed1e0e.png', 2);
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (6, 'McCombo Биг Мак', 'Большой сандвич с двумя бифштексами на специальной булочке Биг Мак с изысканным соусом, стандартная порция обжаренного и слегка посоленного картофеля фри, газированный напиток Coca-Cola, Coca-Cola No sugar, Fanta, Sprite 0,4 л. или чай черный, чай зеленый 0,2 л. и соус на Ваш выбор.', 1950, 'https://mcdonalds.kz/storage/2512/817f2be52e9f284e57a8a10a958c4d529861b237.png', 2);


INSERT INTO Partners (id, title, description, address) VALUES (3, 'Burger King', 'Ресторан бытрого питания', 'улица Шокан Уалиханов, 2а');
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (7, 'WINGS БАКЕТ', 'Наггетсы (8), кинг крылышки (4), крылышки в панировке (4), Кинг фри (М).', 4400, 'https://burgerking.kz/uploads/menuproducts/image/big_1628579764.png', 3);
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (8, 'ВОППЕР', 'Фирменный, сытный бургер с овощами, со 100% говядиной, приготовленной на открытом огне', 2200, 'https://burgerking.kz/uploads/menuproducts/image/big_1628580583.png', 3);
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (9, 'БИГ КИНГ', 'БИГ КИНГ бургер с 2 говяжими котлетами, солеными орурцами и cалатом Айсберг под фирменным ', 3000, 'https://burgerking.kz/uploads/menuproducts/image/big_1628580655.png', 3);



INSERT INTO Clients (id, phone, fullname) VALUES (1, '+77777777777', 'Полковник Сандерс');
INSERT INTO Clients (id, phone, fullname) VALUES (2, '+77077070707', 'Дик Макдоналд');
INSERT INTO Clients (id, phone, fullname) VALUES (3, '+77755555555', 'Джеймс Маклэмор');


INSERT INTO Orders (id, created_at, address, latitude, longitude, order_status, client_id) VALUES (1, '2022-10-01 11:09:54', 'Генривилл', 38.541603, -85.76819, 'новый', 1);
INSERT INTO homework5.orders_positions (order_id, position_id) VALUES (1, 1);
INSERT INTO homework5.orders_positions (order_id, position_id) VALUES (1, 2);

INSERT INTO Orders (id, created_at, address, latitude, longitude, order_status, client_id) VALUES (2, '2022-10-03 16:09:06', 'Иллинойс', 39.7833, -89.67683, 'доставляется', 2);
INSERT INTO homework5.orders_positions (order_id, position_id) VALUES (2, 4);
INSERT INTO homework5.orders_positions (order_id, position_id) VALUES (2, 5);

INSERT INTO Orders (id, created_at, address, latitude, longitude, order_status, client_id) VALUES (3, '2022-10-03 19:09:15', 'Сиэтл', 47.607967, -122.32846, 'завершен', 3);
INSERT INTO homework5.orders_positions (order_id, position_id) VALUES (3, 7);
INSERT INTO homework5.orders_positions (order_id, position_id) VALUES (3, 8);


Select O.id,C.phone, Partners.title from Partners
    JOIN Positions P on Partners.id = P.partner_id
    JOIN orders_positions op on P.id = op.position_id
    JOIN Orders O on O.id = op.order_id
    JOIN Clients C on C.id = O.client_id GROUP BY O.id, C.phone, Partners.title;


INSERT INTO Partners (id, title, description, address) VALUES 4, 'Hardees', 'Ресторан бытрого питания', 'Достык 5');
INSERT INTO Positions (id, title, description, price, photo_url, partner_id) VALUES (10, 'Биг бургер', 'бургер', 1500, 'https://astana.restolife.kz/upload/information_system_26/1/0/0/group_10045/information_groups_property_28202.jpg', 4)

SELECT * from Partners where Not  EXISTS(
    SELECT Positions.partner_id FROM Positions
                            WHERE EXISTS(SELECT position_id FROM orders_positions where position_id=Positions.id)
                            AND Partners.id = Positions.partner_id
                            GROUP BY Positions.partner_id
                                           );
SELECT Positions.title FROM Positions
    join orders_positions op on Positions.id = op.position_id
    join Orders O on O.id = op.order_id
    join Clients C on C.id = O.client_id
    WHERE client_id = 1 and order_id = 1




