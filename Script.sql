CREATE DATABASE food_delivery;

USE food_delivery;

/* Создал БД и теперь создаю таблицы по имеющейся схеме */ 

CREATE TABLE partners (
	id int UNSIGNED PRIMARY KEY auto_increment,
	title varchar(150) NOT NULL,
	description text,
	address varchar(255) NOT NULL
);

CREATE TABLE clients (
	id int UNSIGNED PRIMARY KEY auto_increment,
    fullname varchar(255) NOT NULL,
	phone char(12) NOT NULL
);

CREATE TABLE positions (
	id int UNSIGNED PRIMARY KEY auto_increment,
	title varchar(255) NOT NULL,
	description text NOT NULL,
	price int NOT NULL,
	photo_url varchar(255),
	partner_id int UNSIGNED,
	FOREIGN KEY (partner_id) REFERENCES partners(id)
);

CREATE TABLE orders (
	id int UNSIGNED PRIMARY KEY auto_increment,
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	address varchar(255) NOT NULL,
	latitude float NOT NULL,
	longtitude float NOT NULL,
	status enum ('Новый', 'Принят', 'На доставке', 'Завершен'),
	client_id int UNSIGNED,
	partner_id int UNSIGNED,
	FOREIGN KEY (client_id) REFERENCES clients(id),
	FOREIGN KEY (partner_id) REFERENCES partners(id)
);

CREATE TABLE positions_orders (
	position_id int UNSIGNED,
	order_id int UNSIGNED,
	PRIMARY KEY (position_id, order_id),
	FOREIGN KEY (position_id) REFERENCES positions(id),
	FOREIGN KEY (order_id) REFERENCES orders(id)
);

/* Выполняю первый пункт задания – заполняю базу тестовыми данными */

INSERT INTO partners(title, description, address) VALUES (
	"Damdi", 
    "Фаст-фуд кафе с доставкой.", 
    "ул. Уранхаева 57"
), (
	"Бугорок", 
    "Фаст-фуд кафе с доставкой.", 
    "ул. Валиханова 149"
), (
	"Dodo Pizza", 
    "Семейное кафе с доставкой.", 
    "ул. Валиханова 145"
);

INSERT INTO clients(fullname, phone) VALUES (
	"Первый клиент", 
    "+77778889900"
), (
	"Второй клиент", 
    "+77776667799"
), (
	"Третий клиент", 
    "+77775556688"
);

INSERT INTO positions(
	title,
	description,
	price,
	photo_url,
	partner_id
) VALUES (
	"Бургер",
	"Большой бургер с говяжей котлетой.",
	"800",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Damdi")
), (
	"Донер с говядиной",
	"Большой донер с говядиной.",
	"1100",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Damdi")
), (
	"Твистер",
	"Пародия на шаверму или донер с курицей.",
	"1000",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Damdi")
), (
	"Кола",
	"Бутылка колы.",
	"300",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Damdi")
), (
	"Донер с курицей",
	"Большой донер с курицей.",
	"1000",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Бугорок")
), (
	"Кесадилья",
	"Ещё что-то из фастфуда, с сыром.",
	"900",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Бугорок")
), (
	"Бурито",
	"В кукурузной лепешке с острой начинкой!",
	"1200",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Бугорок")
), (
	"Пепси",
	"Бутылка пепси.",
	"300",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Бугорок")
), (
	"Пицца Пепперони",
	"Классика с колбаской!",
	"2600",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Dodo Pizza")
), (
	"Пицца Маргарита",
	"Пицца с сыром и помидорами.",
	"2000",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Dodo Pizza")
), (
	"Пицца 4 сыра",
	"Больше сыра любителям сыра.",
	"2400",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Dodo Pizza")
), (
	"Додстер",
	"Тут без додстера не обойтись, в каждом нашем кафе есть.",
	"800",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Dodo Pizza")
), (
	"Морс",
	"А у нас морс.",
	"300",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "Dodo Pizza")
);

INSERT INTO orders(
	client_id,
	partner_id,
	address,
	latitude,
	longtitude,
	status
) VALUES (
	(SELECT id FROM clients WHERE fullname = "Первый клиент"),
	(SELECT id FROM partners WHERE title = "Damdi"),
	"ул. Мухамедханова 45",
	11.256999,
	13.256999,
	"Новый"
), (
	(SELECT id FROM clients WHERE fullname = "Первый клиент"),
	(SELECT id FROM partners WHERE title = "Бугорок"),
	"ул. Мухамедханова 45",
	11.256999,
	13.256999,
	"Принят"
), (
	(SELECT id FROM clients WHERE fullname = "Первый клиент"),
	(SELECT id FROM partners WHERE title = "Dodo Pizza"),
	"ул. Мухамедханова 45",
	11.256999,
	13.256999,
	"На доставке"
), (
	(SELECT id FROM clients WHERE fullname = "Второй клиент"),
	(SELECT id FROM partners WHERE title = "Damdi"),
	"ул. Валиханова 124",
	19.256999,
	21.256999,
	"Завершен"
), (
	(SELECT id FROM clients WHERE fullname = "Второй клиент"),
	(SELECT id FROM partners WHERE title = "Бугорок"),
	"ул. Валиханова 124",
	19.256999,
	21.256999,
	"Новый"
), (
	(SELECT id FROM clients WHERE fullname = "Второй клиент"),
	(SELECT id FROM partners WHERE title = "Dodo Pizza"),
	"ул. Валиханова 124",
	19.256999,
	21.256999,
	"Принят"
), (
	(SELECT id FROM clients WHERE fullname = "Третий клиент"),
	(SELECT id FROM partners WHERE title = "Damdi"),
	"ул. Шакарима 60",
	27.256999,
	29.256999,
	"На доставке"
), (
	(SELECT id FROM clients WHERE fullname = "Третий клиент"),
	(SELECT id FROM partners WHERE title = "Бугорок"),
	"ул. Шакарима 60",
	27.256999,
	29.256999,
	"Завершен"
), (
	(SELECT id FROM clients WHERE fullname = "Третий клиент"),
	(SELECT id FROM partners WHERE title = "Dodo Pizza"),
	"ул. Шакарима 60",
	27.256999,
	29.256999,
	"Новый"
);


INSERT INTO positions_orders(position_id, order_id) VALUES (
	(SELECT id FROM positions WHERE title = "Бургер"),
	1
), (
	(SELECT id FROM positions WHERE title = "Кола"),
	1
), (
	(SELECT id FROM positions WHERE title = "Донер с говядиной"),
	4
), (
	(SELECT id FROM positions WHERE title = "Кола"),
	4
), (
	(SELECT id FROM positions WHERE title = "Твистер"),
	7
), (
	(SELECT id FROM positions WHERE title = "Кола"),
	7
), (
	(SELECT id FROM positions WHERE title = "Донер с курицей"),
	2
), (
	(SELECT id FROM positions WHERE title = "Пепси"),
	2
), (
	(SELECT id FROM positions WHERE title = "Кесадилья"),
	5
), (
	(SELECT id FROM positions WHERE title = "Пепси"),
	5
), (
	(SELECT id FROM positions WHERE title = "Бурито"),
	8
), (
	(SELECT id FROM positions WHERE title = "Пепси"),
	8
), (
	(SELECT id FROM positions WHERE title = "Додстер"),
	3
), (
	(SELECT id FROM positions WHERE title = "Морс"),
	3
), (
	(SELECT id FROM positions WHERE title = "Пицца пепперони"),
	6
), (
	(SELECT id FROM positions WHERE title = "Морс"),
	6
), (
	(SELECT id FROM positions WHERE title = "Пицца маргарита"),
	9
), (
	(SELECT id FROM positions WHERE title = "Пицца 4 сыра"),
	9
), (
	(SELECT id FROM positions WHERE title = "Морс"),
	9
);

/* Выполняю второй пункт задания */

SELECT orders.id AS orders_id, clients.phone, partners.title FROM orders 
INNER JOIN clients ON orders.client_id = clients.id 
INNER JOIN partners ON orders.partner_id = partners.id;

/* Выполняю третий пункт задания */

INSERT INTO partners(title, description, address) VALUES (
	"KupiDONer", 
    "Фаст-фуд киоск с доставокй.", 
    "ул. Мамай Батыра 77"
);

INSERT INTO positions(
	title,
	description,
	price,
	photo_url,
	partner_id
) VALUES (
	"Донер",
	"Донер с немного острым соусом.",
	"1100",
	"url is WIP",
	(SELECT id FROM partners WHERE title = "KupiDONer")
);

SELECT * FROM partners 
LEFT JOIN orders ON partners.id = orders.partner_id 
WHERE orders.partner_id IS NULL;

/* Выполняю четвертый пункт задания */

SELECT positions.title FROM positions
INNER JOIN positions_orders ON positions_orders.position_id = positions.id
INNER JOIN orders ON positions_orders.order_id = orders.id
INNER JOIN clients ON orders.client_id = clients.id
WHERE clients.id = 3 AND orders.id = 9;