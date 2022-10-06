/* Создания таблицы партнеров.*/
CREATE TABLE Partners (
    id int UNSIGNED NOT NULL primary key auto_increment,
    title varchar(150) NOT NULL, 
    description text,
    address varchar(255) NOT NULL
);


/* Заполниние сущности партнеров 3 тестовыми данными.*/
INSERT INTO Partners (title, description, address)
VALUES 
    ("KFC", "American fast food restaurant chain that specializes in fried chiken", "Sauran 15, Astana"),
    ("Ninja Pizza", "Fast pizza delivery service based on Astana", "Akyrtas 33, Astana"),
    ("Karima", "Traditional oriental cuisine which mainly focused on plovs", "Dostyk 12/1, Astana");

/* Создания таблицы позиций.*/
CREATE TABLE Positions (
    id int UNSIGNED NOT NULL primary key auto_increment,
    title varchar(255) NOT NULL,
    description text,
    price int NOT NULL DEFAULT(0),
    photo_url varchar(255),
    partner_id int UNSIGNED NOT NULL,
    FOREIGN KEY (partner_id) REFERENCES Partners(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT 
);

/* Заполниние сущности позиций 9 тестовыми данными (3 позиций для каждого партнера).*/
INSERT INTO Positions (title, description, price, photo_url, partner_id)
VALUES 
    ("Chicken Pita Combo", "Chicken Pita, french fries L, Pepsi 0,5L, ketchup", 2450, 
    "https://www.kfc.kz/admin/files/medium/medium_4393.jpg", (SELECT id FROM Partners WHERE title = "KFC")),
    ("Chef Tower box", "Chef Tower, 2 strips, french fries L, Pepsi 0,5L, cheese sauce", 3450, 
    "https://www.kfc.kz/admin/files/4345.jpg", (SELECT id FROM Partners WHERE title = "KFC")),
    ("Sanders Bucket", "Drumstick, 2 spicy wings, 2 strips, bites 63 gr.", 1950, 
    "https://www.kfc.kz/admin/files/4298.jpg", (SELECT id FROM Partners WHERE title = "KFC")),
    ("Pizza Alfredo", "Chicken, cheese, champignons, cherry tomatoes, parmesan, Alfredo sauce", 3200,
    "https://ninjapizza.kz/tproduct/282802769-619707445001-pitstsa-alfredo", (SELECT id FROM Partners WHERE title = "Ninja Pizza")),
    ("Pizza Cheesburger", "Tut ground beef, tomatoes, pickles, cheese sauce, red onion", 2690,
    "https://ninjapizza.com.ua/ru/product/cheeseburger-pizza", (SELECT id FROM Partners WHERE title = "Ninja Pizza")),
    ("Pizza Margarita", "Tomatoes, cheese, tomato sauce", 1850,
    "https://php.ninjapizza.com.ua/images/news/margarita_news.png", (SELECT id FROM Partners WHERE title = "Ninja Pizza")),
    ("Tashkent plov", "Grain rice, lamb shoulder, carrots, garlic, paprica", 1200,
    "https://anons.uz/media/news/medium/uzbekskij_plov_1_watermarked.jpeg", (SELECT id FROM Partners WHERE title = "Karima")),
    ("Lagman", "Lean fried meat, vegetables and long noodles", 1390,
    "https://valentinascorner.com/wp-content/uploads/2019/03/Uzbek-Lagman-1568-750x1125.jpg", (SELECT id FROM Partners WHERE title = "Karima")),
    ("Lentil soup", "Vegetables such as carrots, potatoes, celery, ripe plantain and onion", 900,
    "https://www.noracooks.com/wp-content/uploads/2018/11/144A0601.jpg", (SELECT id FROM Partners WHERE title = "Karima"));


/* Создания таблицы клиентов.*/
CREATE TABLE Clients (
    id int UNSIGNED NOT NULL primary key auto_increment,
    phone char(12) NOT NULL,
    fullname varchar(255)
);

/* Заполниние сущности клиентов 3 тестовыми данными.*/
INSERT INTO Clients (phone, fullname)
VALUES
    ("+79384586977", "Alex Cochran"),
    ("+78422566325", "Alexander Martin"),
    ("+75964144591", "Simone Adams");

/* Создания таблицы заказов.*/
CREATE TABLE Orders (
    id int UNSIGNED NOT NULL primary key auto_increment,
    created_at datetime,
    address varchar(255) NOT NULL,
    latitude float,
    longitude float,
    status ENUM('completed', 'accepted', 'in process'),
    client_id int UNSIGNED NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Clients(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT 
);

/* Заполниние сущности заказов 6 тестовыми данными (2 заказа для каждого клиента).*/
INSERT INTO Orders (created_at, address, latitude, longitude, status, client_id)
VALUES
    ('2021-12-18 18:17:15', "M/r 17, bld. 9/A, appt. 7", 45.63, 15.22, "completed", (SELECT id FROM Clients WHERE fullname = "Alex Cochran")),
    ('2022-09-11 11:15:13', "Baytursynova, bld. 95, appt. 346", 47.55, 22.36, "accepted", (SELECT id FROM Clients WHERE fullname = "Alex Cochran")),
    ('2022-01-13 14:12:15', "Mira, bld. 12, appt. 31", 52.15, 62.23, "in process", (SELECT id FROM Clients WHERE fullname = "Alexander Martin")),
    ('2022-06-10 16:17:22', "Ploshchad Pobedy, bld. 3, appt. 32", 40.11, 62.27, "accepted", (SELECT id FROM Clients WHERE fullname = "Alexander Martin")),
    ('2021-11-02 18:17:15', "Estaya, bld. 99, appt. 267", 43.86, 22.16, "in process", (SELECT id FROM Clients WHERE fullname = "Simone Adams")),
    (now(), "Estaya, bld. 99, appt. 267", 43.86, 22.16, "completed", (SELECT id FROM Clients WHERE fullname = "Simone Adams"));


/* Создания промежуточной таблицы для позиций-заказа.*/
CREATE TABLE positions_orders (
    position_id int UNSIGNED NOT NULL,
    order_id int UNSIGNED NOT NULL,
    PRIMARY KEY (position_id, order_id),
    FOREIGN KEY (position_id) REFERENCES Positions(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (order_id) REFERENCES Orders(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/* Заполниние сущности 11 тестовыми данными (позиций для каждого заказа варируется
Например заказ с ID 1 имеет две позиций с ID 1 и 3, в то время как заказ с ID 2
имеет одну позицию с ID 1).*/
INSERT INTO positions_orders (position_id, order_id)
VALUES
    (1,1),(3,1),
    (1,2),
    (4,3), (5,3),(6,3),
    (9,4),
    (7,5),(8,5),
    (4,6),(6,6);