create database hw;

use hw;


create table partners
(
    id          int primary key auto_increment not null,
    title       varchar(150)                   not null,
    description text,
    address     varchar(255)                   not null
);

create table positions
(
    id          int primary key auto_increment not null,
    title       varchar(255)                   not null,
    description text,
    price       int                            not null default (0),
    photo_url   varchar(255),
    partner_id  int,
    foreign key (partner_id) references partners (id)
);


create table clients
(
    id        int primary key not null auto_increment,
    phone     char(12),
    full_name varchar(255)
);

create table orders
(
    id           int primary key auto_increment not null,
    created_at   datetime,
    address      varchar(255),
    latitude     float,
    longitude    float,
    status       enum ('NEW','ACCEPTED', 'READY', 'COMPLETED'),
    client_id    int,
    positions_id int,
    foreign key (positions_id) references positions (id),
    foreign key (client_id) references clients (id)
);


-- add clients
insert into clients(phone, full_name)
values ('87476791947', 'Mark');
insert into clients(phone, full_name)
values ('87476791919', 'Dima');
insert into clients(phone, full_name)
values ('87774336890', 'Idris');

-- add partners
insert into partners(title, description, address)
values ('DODO', 'Доставка пиццы', 'Макатаева 17');
insert into partners(title, description, address)
values ('Maki-Maki', 'Доставка суши', 'Пушкина 1');
insert into partners(title, description, address)
values ('Salam Bro', 'Доставка бургеров ', 'Тайторы 75');

-- add positions where partner_id=1
insert into positions(title, description, price, photo_url, partner_id)
values ('Классика', 'дефолтная', 2100, 'url-1', 1);
insert into positions(title, description, price, photo_url, partner_id)
values ('Мексиканская', 'острая', 2300, 'url-2', 1);
insert into positions(title, description, price, photo_url, partner_id)
values ('4-сыра', '4- вида сыров', 2500, 'url-3', 1);

-- add positions where partner_id=2
insert into positions(title, description, price, photo_url, partner_id)
values ('Урамаки', 'урамаки', 1950, 'url-4', 2);
insert into positions(title, description, price, photo_url, partner_id)
values ('Гункан', 'описание гункана', 2000, 'url-5', 2);
insert into positions(title, description, price, photo_url, partner_id)
values ('Радуга', 'радужная', 2250, 'url-6', 2);

-- add positions where partner_id=3
insert into positions(title, description, price, photo_url, partner_id)
values ('Чизбургер', 'чиз', 1400, 'url-7', 3);
insert into positions(title, description, price, photo_url, partner_id)
values ('Бургер', 'дефолт', 1000, 'url-8', 3);
insert into positions(title, description, price, photo_url, partner_id)
values ('Двойной чизбургер', 'чизх2', 1550, 'url-9', 3);

-- add orders
insert into orders(created_at, address, latitude, longitude, status, client_id, positions_id)
values ('2022-10-6-22-18-30', 'пушкина 18', 11, 17, 'READY', 1, 1);
insert into orders(created_at, address, latitude, longitude, status, client_id, positions_id)
values ('2022-10-6-22-18-30', 'пушкина 18', 10, 11, 'NEW', 1, 2);
insert into orders(created_at, address, latitude, longitude, status, client_id, positions_id)
values ('2022-10-6-22-18-30', 'пушкина 18', 5, 8, 'COMPLETED', 1, 7);

insert into orders(created_at, address, latitude, longitude, status, client_id, positions_id)
values ('2022-10-6-22-18-10', 'пушкина 1', 8, 11, 'NEW', 2, 3);
insert into orders(created_at, address, latitude, longitude, status, client_id, positions_id)
values ('2022-10-6-22-18-11', 'пушкина 1', 5, 2, 'ACCEPTED', 2, 5);

insert into orders(created_at, address, latitude, longitude, status, client_id, positions_id)
values ('2022-10-6-22-18-11', 'пушкина 1', 5, 2, 'COMPLETED', 3, 5);

insert into partners(title, description, address)
values ('BIBA', 'biba', 'biba 18 ');

insert into positions(title, description, price, photo_url, partner_id)
values ('biba', 'biba', 1950, 'url-biba', 4);



-- 1
SELECT orders.id, clients.phone, partners.title
FROM orders
         JOIN clients on clients.id = orders.client_id
         JOIN positions on positions.id = positions_id
         JOIN partners on positions.partner_id = partners.id;

-- 2
select partners.title, count(positions.partner_id) = 0 as Without_Orders
from positions,
     partners;

-- 3
select clients.id, orders.id as order_ID, positions.title
from orders,
     clients,
     positions
where client_id = clients.id
  and positions_id = positions.id
