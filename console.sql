create database if not exists delivery;

use delivery;


create table partners
(
    id          int          not null primary key auto_increment,
    title       varchar(150) not null,
    description text,
    address     varchar(255)
);

create table positions
(
    id          int          not null primary key auto_increment,
    title       varchar(255) not null,
    description text,
    price       int          not null default 0,
    photo_url   varchar(255),
    partner_id  int,
    foreign key (partner_id) references partners (id) on update cascade on delete cascade
);

create table clients
(
    id           int not null primary key auto_increment,
    phone_number varchar(12),
    fullname     varchar(255)
);

create table orders
(
    id        int                                                       not null primary key auto_increment,
    create_at datetime,
    addres    varchar(255),
    latitude  float,
    longitude float,
    status    enum ('new order', 'delivered', 'on the way', 'accepted') not null,
    client_id int                                                       not null,
    foreign key (client_id) references clients (id) on update cascade on delete cascade
);

create table orders_details
(
    position_id bigint references orders (id),
    order_id    bigint references positions (id),
    constraint position_to_order primary key (position_id, order_id)
);

# 1. Заполните базу тестовыми данными, не менее 3 партнеров, не менее 3 позиций для заказа у каждого из партнеров.
#     3 Пользователя, у каждого из которых от 1 до 5 заказов, в каждом из заказов от 1 до 3 позиций блюд

insert into partners(title, description, address)
values ('Бродвей бургер', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 'Фурманова, 1'),
       ('Плов в коробочке', 'Duis eu urna nec nunc aliquam maximus.', 'Байзакова, 28'),
       ('Дареджани', 'Etiam rhoncus leo eget tempus efficitur.', 'Толе би, 214Б');

insert into positions(title, description, price, photo_url, partner_id)
values ('Классический бургер', 'Тостовая булочка, двойная котлета из мраморной говядины', 2400, 'images/pic_1_1', 1),
       ('Картофель фри лодочки', 'Хрустящая картошка с сырным соусом', 600, 'images/pic_1_2', 1),
       ('Kids combo', 'Джуниор бургер из мраморной говядины, куриные наггетсы, сок на выбор', 3100, 'images/pic_1_2',
        1),

       ('Самса', 'Узбекской самсой может называться не всякий пирожок с мясом.', 400, 'images/pic_2_1', 2),
       ('Плов ташкентский', 'Настоящий плов прямо из Ташкента', 1490, 'images/pic_2_2', 2),
       ('Чай', 'Освежающий летом и согревающий зимой напиток', 450, 'images/pic_2_3', 2),

       ('Хачапури', 'Хинкали с говядиной, зирой и кинзой (5 шт.)', 2400, 'images/pic_3_1', 3),
       ('Хинкали', 'Винoградные листья, фарш из говядины и баранины, бульон. Подается с кефирным соусом', 2700,
        'images/pic_3_2', 3),
       ('Суп Харчо', 'На говяжьем бульоне с рисом, кинзой, сельдереем, чесноком и хмели-сунели', 2200, 'images/pic_3_3',
        3);

insert into clients(phone_number, fullname)
values ('+77471157383', 'Dias Kaipan'),
       ('+77758437238', 'Raushan E'),
       ('+77771095566', 'Madi R');

insert into orders(create_at, addres, latitude, longitude, status, client_id)
values (now(), 'мкр Аксай-2 63', 14.28, 71.18, 'new order', 1),
       (now(), 'Орбита 3 20', 43.15, 76.60, 'accepted', 1),
       (now(), 'Бейсембаева 3', 43.17, 76.59, 'on the way', 1),
       (now(), 'Торайгырова 17', 43.15, 76.60, 'delivered', 1),
       (now(), 'Тимирязова 17', 43.17, 76.59, 'on the way', 1),
       (now(), 'мкр Аксай-4 29', 43.16, 76.53, 'on the way', 2),
       (now(), 'Орбита 3 20', 43.12, 76.55, 'accepted', 3),
       (now(), 'мкр Аксай-4 29', 43.15, 76.55, 'delivered', 2),
       (now(), 'мкр Аксай-4 29', 43.12, 76.55, 'new order', 3);

insert into orders_details (position_id, order_id)
values (9, 1),
       (8, 2),
       (7, 3),
       (6, 4),
       (5, 5),
       (4, 6),
       (3, 7),
       (2, 8),
       (1, 9);
#2. Напишите запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера
select o.id, c.phone_number, p2.title
from orders o
         join clients c on o.client_id = c.id
         join orders_details od on o.id = od.position_id
         join positions p on od.position_id = p.id
         join partners p2 on p2.id = p.partner_id;

# 3.Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы. Сделайте
# запрос, который выведет таких партнеров, у которых еще не было ни одного заказа

insert into partners(title, description, address)
values ('KFC', 'Lorem ipsum sit amet, consectetur adipiscing elit.', 'Фурманова, 1'),
       ('Ramen 77', 'Duis eu urna nec nunc aliquam maximus.', 'Байзакова, 28');

insert into positions(title, description, price, photo_url, partner_id)
values ('Шеф Твистер Комбо', 'Duis eu urna nec nunc aliquam maximus', 2450, 'images/pic_4_1', 4),
       ('Боксмастер Комбо', 'Duis eu urna nec nunc aliquam maximus', 2800, 'images/pic_4_2', 4),
       ('Баскет S Комбо', 'Duis eu urna nec nunc aliquam maximus', 5000, 'images/pic_4_2', 4),

       ('Рамен Том Ям', 'Lorem ipsum sit amet, consectetur adipiscing elit.', 2990, 'images/pic_5_1', 5),
       ('Бао с курицей', 'Lorem ipsum sit amet, consectetur adipiscing elit.', 2490, 'images/pic_5_2', 5),
       ('Рис', 'Lorem ipsum sit amet, consectetur adipiscing elit.', 490, 'images/pic_5_3', 5);

select p.title
from partners p
where id not in (select partner_id
                 from orders_details od
                          join positions p on p.id = od.position_id);

#4. Напишите запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа.

select p.title
from orders_details od
         left join orders o on od.order_id = o.id
         left join positions p on od.position_id = p.id
         left join clients c on o.client_id = c.id
where o.id = 3
  and c.id = 1;
