CREATE DATABASE food_ordering;
USE food_ordering;

CREATE table partners( 
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    address VARCHAR(255) NOT NULL
);

CREATE table positions(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    price INT NOT NULL default(0),
    photo_url VARCHAR(255),
    partner_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(partner_id) REFERENCES partners(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE table clients(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    phone CHAR(12),
    fullname VARCHAR(255)
);

CREATE table orders(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    created_at DATETIME,
    address VARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,
    status ENUM('Новый', 'Принят рестораном', 'Доставляется', 'Завершен'),
    client_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(client_id) REFERENCES clients(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE table positions_orders(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    position_id INT UNSIGNED NOT NULL,
    order_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(position_id) REFERENCES positions(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY(order_id) REFERENCES orders(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

#1

INSERT INTO partners(title,description,address) VALUES
    ("KazMin","Разные напитки и тд","Алматы"),
    ("Shoco","Разные типы шоколадов","Астана"),
    ("Meat-kz","Мяса","Шымкент");
    
INSERT INTO positions(title,description,price,photo_url,partner_id) VALUES
    ("Сарыагаш", "Минеральная",200,"temp.png",1),
    ("ASU", "Не газированная",250,"temp.png",1),
    ("Асем-ай", "Минеральная, газированная",300,"temp.png",1);
    
INSERT INTO positions(title,description,price,photo_url,partner_id) VALUES
    ("Snickers", "С арахисом",350,"temp.png",2),
    ("Bounty", "С манго",400,"temp.png",2),
    ("Kitkat", "С малиной",300,"temp.png",2);
    
INSERT INTO positions(title,description,price,photo_url,partner_id) VALUES
    ("Говяжий", "Говяжий",2300,"temp.png",3),
    ("Конина", "Конина",2500,"temp.png",3),
    ("Свинина", "Свинина",2000,"temp.png",3);
    
INSERT INTO clients(phone,fullname)
    VALUES('+77786046570', "Жанарыс Дильмахамбетов");
    
INSERT INTO orders(created_at,address,latitude,longitude,status,client_id) VALUES
    ('2022-09-15 10-37-42',"Манаса 52",35.0,45.0,"Доставляется",
    (SELECT id FROM clients c
    WHERE c.fullname = "Жанарыс Дильмахамбетов")),
    ('2022-07-15 22-37-42',"Манаса 52",70.0,85.0,"Завершен",
    (SELECT id FROM clients c
    WHERE c.fullname = "Жанарыс Дильмахамбетов"));
    
INSERT INTO clients(phone,fullname)
    VALUES("+77056123597","Жанысбай Бауыржан");
    
INSERT INTO orders(created_at,address,latitude,longitude,status,client_id) VALUES
    ('2022-09-26 15-37-42',"Абая 52",55.0,77.0,"Новый",
    (SELECT id FROM clients c
    WHERE c.fullname = "Жанысбай Бауыржан"));
    
INSERT INTO clients(phone,fullname)
    VALUES("+77758423588","Сериков Эдик");
    
INSERT INTO orders(created_at,address,latitude,longitude,status,client_id) VALUES
    ('2022-05-11 19-37-42',"Достык 85",55.0,77.0,"Принят рестораном",
    (SELECT id FROM clients c
    WHERE c.fullname = "Сериков Эдик"));

INSERT INTO positions_orders(position_id,order_id) VALUES
    (9,3),(8,1),(3,2),(4,2),(1,3),(6,4);
 
#SELECT * FROM positions;   
#SELECT * FROM clients;
#SELECT * FROM orders;

#2
SELECT o.id,c.phone,ps.title FROM orders o
    INNER JOIN clients c ON c.id = o.client_id
    INNER JOIN positions_orders po ON o.id = po.order_id
        INNER JOIN positions p ON p.id = po.position_id
        INNER JOIN partners ps ON ps.id = p.partner_id;


#3
INSERT INTO partners(title,description,address)
    VALUES("Zhan","Турецкие блюда","Алматы");

INSERT INTO positions(title,description,price,photo_url,partner_id)
    VALUES("Искандер","Искандер",2500,"temp.png",
    (SELECT id FROM partners 
    WHERE partners.title = "Zhan"));

SELECT par.id, par.title FROM partners par
WHERE par.id NOT IN (SELECT p.partner_id FROM positions_orders po, positions p WHERE po.position_id = p.id);

#4
SELECT p.title FROM positions p, positions_orders ps, orders o
    WHERE o.client_id = 1 AND o.id = 1 AND ps.order_id = o.id AND p.id = ps.position_id;

    
