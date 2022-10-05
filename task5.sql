/*create database kolesa_task; */
use kolesa_task;

CREATE TABLE Partners (
	id int NOT NULL PRIMARY KEY,
	title varchar(150) NOT NULL,
	description text,
    address varchar(255) NOT NULL 
);


CREATE TABLE Positions (
	id int NOT NULL PRIMARY KEY,
	title varchar(255) NOT NULL,
	description text,
    price int NOT NULL default(0),
    photo_url varchar(255),
    partner_id int ,
    FOREIGN KEY (partner_id) REFERENCES Partners(id)
);

CREATE TABLE Clients (
	id int NOT NULL PRIMARY KEY,
    phone char(12),
    fullname varchar(255)
);

CREATE TABLE Orders (
	id int NOT NULL PRIMARY KEY,
    created_at datetime,
    address varchar(255),
    latitude float,
    longitude float,
    status ENUM('open','close'),
    client_id int,
    FOREIGN KEY (client_id) REFERENCES Clients(id)
);



CREATE TABLE position_order (
	position_id int not null,
    order_id int not null,
	PRIMARY KEY (position_id,order_id) ,
    FOREIGN KEY (order_id) References Orders(id)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
	FOREIGN KEY (position_id) REFERENCES Positions(id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*Заполните базу тестовыми данными, не менее 3 партнеров, не менее 3 позиций для заказа у каждого из партнеров. 3 Пользователя, у каждого из которых от 1 до 5 заказов, в каждом из заказов от 1 до 3 позиций блюд*/
INSERT INTO Partners(id,title,description,address)
values(1,'Del Papa','итальянская кухня','ул. Кабанбай батыра 83');

INSERT INTO Partners(id,title,description,address)
values(2,'Хачапури Хинкальевич','грузинская кухня','пр-т. Абая 60');

INSERT INTO Partners(id,title,description,address)
values(3,'Ramen 77','японская кухня','Dostyk Plaza');

select * from partners;



INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(1,
'Курица Миланезе','Куриная грудка Миланезе в панировке из воздушных сухарей и сыра',
2699,
'https://e1.edimdoma.ru/data/photos/0013/9707/139707-ed4_wide.jpg?1628921560',
1);

INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(2,
'Цезарь','Пицца на сырном соусе с куриной грудкой',
3499,
'https://www.kulina.ru/images/art/84632.jpg',
1);

INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(3,
'Моцарелла с бургером',
'Бургер с мясом и моцареллой',
2699,
'https://cdn-irec.r-99.com/1229813/hhSOpx5kmjfztVNIvftmQ.jpeg',
1);

INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(4,
'Хачапури на шампуре',
'Традиционная еда грузинов. Тесто приготовленное в тандыре с сыром',
1590,
'https://www.gastronom.ru/binfiles/images/20180426/b5d7fc2d.jpg',
2);

INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(5,
'Кубдари',
'Грузинская лепешка заправленная мясом',
1990,
'https://volshebnaya-eda.ru/wp-content/uploads/2019/02/kubdari-9.jpg',
2);

INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(6,
'Грузинский сыр',
'Грузинский сыр приготовленный в кавказских горах',
2590,
'https://ingeotour.com/upload/iblock/abc/abc462ef67e31f5458a4b387a2c77f99.jpg',
2);


INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(7,
'Шойу',
'самый старинный вариант рамена. Бульон для этого супа варят на курице либо овощах с добавлением большого количества соевого соуса',
1690,
'https://media-cdn.tripadvisor.com/media/photo-s/1c/a6/36/97/ramen-shoyu-classic.jpg',
3);
INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(8,
'Мисо',
'Это лапша рамен, порцию которой, только что отваренной, кладут в миску или пиалу и заливают суповой основой.',
1690,
'https://fancyishcooking.com/wp-content/uploads/2020/07/Chicken-miso-ramen.jpg',
3);

INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(9,
'Биск',
'абсолютный хит среди любителей супов. . Наваристый бульон с домашней пшеничной лапшой',
1690,
'https://eda.yandex.ru/images/1368744/22e8493307ee2b9e7a3a411821ca687c-680x500.jpeg',
3);

select * from positions;

/*Количество клиентов*/
INSERT INTO Clients(id,phone,fullname)
values(1,
'87474343529',
'Zhassulan Akimbayev');

INSERT INTO Clients(id,phone,fullname)
values(2,
'87472223355',
'Olzhas Smagulov');

INSERT INTO Clients(id,phone,fullname)
values(3,
'87076663529',
'Damir Sovetkhan');


select * from clients;

/*Заказы Жасулана */
INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(1,
'2019-03-28 10:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'open',
1
);

INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(2,
'2022-10-03 11:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'close',
1
);
INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(3,
'2022-10-03 16:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'open',
1
);
INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(4,
'2022-10-02 12:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'close',
1
);
/*Заказы Олжаса Смагулова */
INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(5,
'2022-10-02 12:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'open',
2
);
INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(7,
'2022-10-02 12:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'open',
2
);
INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(6,
'2022-10-02 12:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'open',
2
);
select * from orders;
/*Заказы Дамира Советхана*/

INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(8,
'2022-10-02 12:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'open',
3
);
INSERT INTO Orders(id,created_at,address,latitude,longitude,status,client_id)
values(9,
'2022-10-02 12:00:00',
'Taugul-1,d 72',
43.2567,
76.9286,
'open',
3
);

select * from orders;

/*  Заказы и позиции Жасулана  */
INSERT INTO position_order(position_id,order_id)
values(1,1);

INSERT INTO position_order(position_id,order_id)
values(2,1);

INSERT INTO position_order(position_id,order_id)
values(3,1);

INSERT INTO position_order(position_id,order_id)
values(4,4);
/*  Заказы и позиции Олжаса  */
INSERT INTO position_order(position_id,order_id)
values(1,5);
INSERT INTO position_order(position_id,order_id)
values(2,6);
INSERT INTO position_order(position_id,order_id)
values(3,7);

/*  Заказы и позиции Дамира  */
INSERT INTO position_order(position_id,order_id)
values(1,8);
INSERT INTO position_order(position_id,order_id)
values(9,9);
INSERT INTO position_order(position_id,order_id)
values(7,8);

/*  Напишите запрос, который будет выводить номера заказов (их ИД), номер телефонов клиентов, название партнера */
select o.id,c.phone,pr.title
from position_order po
LEFT JOIN positions p ON po.position_id = p.id
LEFT JOIN orders o ON po.order_id = o.id
LEFT JOIN clients c ON o.client_id = c.id
LEFT JOIN partners pr ON p.partner_id = pr.id;


/*  Добавьте еще одного партнера и минимум 1 позицию для него. Но не создавайте заказы. Сделайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа  */

select * from partners;

INSERT INTO Partners(id,title,description,address)
values(4,'Lanzhou','уйгурская кухня','пр-т. Абая 44');

select * from positions;

INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(10,
'Цомян','Ган-бян-цомян – это жареный лагман. 
В отличие от обычного лагмана, в котором на длинную лапшу сверху накладывают пожаренное мясо с овощами и специями, 
во время приготовления цомяна заранее порезанную лапшу перемешивают с мясом и другими ингредиентами еще на сковороде',
1600,
'https://e1.edimdoma.ru/data/photos/0013/9707/139707-ed4_wide.jpg?1628921560',
4);
INSERT INTO Positions(id,title,description,price,photo_url,partner_id)
values(11,
'Цомян с курицей и грибами','Ган-бян-цомян – это жареный лагман. 
В отличие от обычного лагмана, в котором на длинную лапшу сверху накладывают пожаренное мясо с овощами и специями, 
во время приготовления цомяна заранее порезанную лапшу перемешивают с мясом и другими ингредиентами еще на сковороде',
1500,
'https://e1.edimdoma.ru/data/photos/0013/9707/139707-ed4_wide.jpg?1628921560',
4);

/*делайте запрос, который выведет таких партнеров, у которых еще не было ни одного заказа*/
select * from partners
 where partners.id not in 
 (select partner_id from position_order
 join positions on positions.id = position_order.position_id);


/*Напишите запрос, который по ID пользователя и ID заказа выведет названия всех позиций из этого заказа*/
SELECT p.title
FROM position_order po
LEFT JOIN positions p ON po.position_id = p.id
LEFT JOIN orders o ON po.order_id = o.id
WHERE po.order_id = o.id 
AND po.position_id = p.id 
AND o.id = 5
AND o.client_id = 2;


