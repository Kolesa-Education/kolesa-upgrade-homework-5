CREATE DATABASE food_delivery;

USE food_delivery;

CREATE TABLE partners (
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	title varchar(150) NOT NULL,
	address varchar(255) NOT NULL,
	description text
);

CREATE TABLE positions (
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	title varchar(255) NOT NULL,
	description text,
	price int UNSIGNED NOT NULL DEFAULT(0),
	photo_url varchar(255),
	partner_id int UNSIGNED NOT NULL,
	FOREIGN KEY (partner_id) REFERENCES partners(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

CREATE TABLE clients (
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	phone char(12) NOT NULL,
	fullname varchar(255) NOT null
);

CREATE TABLE orders (
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	created_at datetime NOT NULL DEFAULT(now()),
	address varchar(255) NOT NULL,
	latitude float NOT NULL,
	longitude float NOT NULL,
	status enum("new", "accepted", "delivered", "completed"),
	client_id int UNSIGNED NOT NULL,
	FOREIGN KEY (client_id) REFERENCES clients(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT	
);

CREATE TABLE orders_positions (
	order_id int UNSIGNED NOT NULL,
	position_id int UNSIGNED NOT NULL,
	PRIMARY KEY (order_id, position_id),
	FOREIGN KEY (order_id) REFERENCES orders(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (position_id) REFERENCES positions(id)
		ON UPDATE CASCADE
		ON DELETE RESTRICT
);

SHOW tables;


# Задание 1. Заполните базу тестовыми данными, не менее 3 партнеров, не менее 3 позиций 
# для заказа у каждого из партнеров. 3 Пользователя, у каждого из которых от 1 до 5 заказов, 
# в каждом из заказов от 1 до 3 позиций блюд.

INSERT INTO partners (title, address, description) VALUES 
	("SUSHIWOK", "г. Караганда, ул. Язева, 14/1", "Кухни: Wok, Напитки, Роллы и суши"),
	("Pallermo", "г. Караганда, ул. Алиханова, 37/2", "Кухни: Горячие блюда, Десерты, Комплексные обеды"),
	("Трактир Три Медведя", "г. Караганда, пр. Нуркена Абдирова, 30в", "Кухни: Выпечка, Горячие блюда, Десерты, Шашлыки"),
	("Topdog", "г. Караганда, ул. Н. Назарбаева 53/1", "Кухни: Напитки, Салаты и закуски, Фаст фуд");



INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES 
	("Филадельфия", "Норвежский лосось, сыр филадельфия", 1990, 
	"https://storage.emenu.delivery/product/images/30/fq/30fqjgrn_xrtsu8wib6ra_azj4jtxrgc.jpg", 1),
	
	("Сяке темпура", "Норвежский лосось, огурец, сыр филадельфия, панировка", 1490, 
	"https://storage.emenu.delivery/product/images/wv/rc/wvrc2f17yd_su1eiyvmtvgbgu_p69u1t.jpg", 1),
	
	("Эби темпура", "Креветка темпура, огурец, сливочный сыр, панировка", 1590, 
	"https://storage.emenu.delivery/product/images/4a/vy/4avy0cw6zggdf56qt6vheabem6uifklv.jpg", 1),
	
	("Унаги темпура", "Копчёный угорь, огурец, сыр филадельфия, соус унаги, кунжут, панировка", 1790, 
	"https://storage.emenu.delivery/product/images/2z/kf/2zkfrcsxqook8pi1egozwl-fzqgdhefl.jpg", 1);


INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES 
	("Капричеза", "Соус томатный, шампиньоны, оливки, ветчина, маринованные огурцы, орегано, сыр моцарелла", 3000, 
	"https://storage.emenu.delivery/product/images/rn/xo/rnxojjcjpqo4s2iquydjsamkzwfi8set.jpg", 2),
	
	("Карбонара", "Соус томатный, бекон, яйцо, орегано, сыр моцарелла", 2700, 
	"https://storage.emenu.delivery/product/images/ps/oj/psojt71tb3ber0nz8hrhb-xd75nyysfm.jpg", 2),
	
	("Биббона", "Соус томатный, сосиски, перчик пепперони, корнишоны, соус горчичный, сыр моцарелла", 2800, 
	"https://storage.emenu.delivery/product/images/v4/dt/v4dtw4dksa-hhrdy8-2usk-mnsroarsz.jpg", 2);
	

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES 
	("Обжаренные кусочки телятины", "С луком, чесноком и сметаной", 3390, 
	"https://storage.emenu.delivery/product/images/qx/9j/qx9jt_6evpiw7ixrb_doowd5og-33__j.jpg", 3),
	
	("Филе судака запечённое", "С грибами, корнишонами и картофелем", 3490, 
	"https://storage.emenu.delivery/product/images/xz/y7/xzy7pooaavvnzlyjamhlfkp7plmqxtqm.jpg", 3),
	
	("Сочный стейк из свинины", "Запечённый под сыром с грецким орехом", 3090, 
	"https://storage.emenu.delivery/product/images/xb/vh/xbvhvbud0gnckg4arqq36qkapxn2vewv.jpg", 3);
	

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES 
	("Гамбургер с беконом", "Булочка с кунжутом, говяжья котлета, помидоры, огурцы, соус барбекю", 1700, 
	"https://storage.emenu.delivery/product/images/ch/xp/chxpb7s1okvv92gjny3jz3skww57xvfz.jpg", 4),
	
	("Chef", "Булочка с кунжутом, говяжья котлета 2шт, помидоры, огурцы, лист салата, соус сырный", 2700, 
	"https://storage.emenu.delivery/product/images/5z/vo/5zvoa-cmumdm5sblovavp9vbnkii3xly.jpg", 4),
	
	("Хот-дог классический", "Булочка с кунжутом, помидоры, соус релиш, кетчуп томатный, майонез, горчица", 1100, 
	"https://storage.emenu.delivery/product/images/io/e2/ioe2uowgkfieukx2d9z-aqo95cys3vdk.jpg", 4);
	


INSERT INTO clients (phone, fullname) VALUES 
	("+77001110011","Ахметов Данияр"),
	("+77002220022","Бодров Александр"),
	("+77003330033","Волков Юрий");


INSERT INTO orders (address, latitude, longitude, status, client_id) VALUES
	("г. Караганда, ул. Ынтымак 72", 49.860267, 73.194834, "completed", 1),
	("г. Караганда, ул. Ынтымак 72", 49.860267, 73.194834, "delivered", 1),
	("г. Караганда, ул. Ынтымак 72", 49.860267, 73.194834, "accepted", 1),
	("г. Караганда, ул. Комиссарова, 4/2", 49.803115, 73.099619, "completed", 2),
	("г. Караганда, ул. Комиссарова, 4/2", 49.803115, 73.099619, "delivered", 2),
	("г. Караганда, ул. Комиссарова, 4/2", 49.803115, 73.099619, "accepted", 2),
	("г. Караганда, ул. Комиссарова, 4/2", 49.803115, 73.099619, "new", 2),
	("г. Караганда, ул. Пичугина, 231/2", 49.802833, 73.103854, "completed", 3),
	("г. Караганда, ул. Пичугина, 231/2", 49.802833, 73.103854, "new", 3);
	

INSERT INTO orders_positions (order_id, position_id) VALUES 
	(1, 1), (1, 2), (1, 4),
	(2, 5), (2, 6),
	(3, 8), (3, 9),
	(4, 2), (4, 3),
	(5, 11), (5, 12),
	(6, 8), (6, 9), (6, 10),
	(7, 5), (7, 6), (7, 7),
	(8, 3), (8, 4),
	(9, 12), (9, 13);


SELECT * FROM partners;
SELECT * FROM positions;
SELECT * FROM clients;
SELECT * FROM orders;
SELECT * FROM orders_positions;


# Задание 2. Напишите запрос, который будет выводить номера заказов (их ИД), 
# номер телефонов клиентов, название партнера.

SELECT DISTINCT orders.id, clients.phone, partners.title FROM clients
	JOIN orders ON clients.id = orders.client_id
	JOIN orders_positions ON orders.id = orders_positions.order_id
	JOIN positions ON orders_positions.position_id = positions.id
	JOIN partners ON positions.partner_id = partners.id;


# Задание 3. Добавьте еще одного партнера и минимум 1 позицию для него. 
# Но не создавайте заказы. Сделайте запрос, который выведет таких партнеров, 
# у которых еще не было ни одного заказа.

INSERT INTO partners (title, address, description) 
	VALUES ("Kurkuma", "г. Караганда, пр. Бухар Жырау, 2/7", "Кухни: Горячие блюда, Напитки, Пицца, Салаты и закуски");
	
INSERT INTO positions (title, description, price, photo_url, partner_id)
	VALUES ("Жаровня с говядиной", "Говядина, фасоль стручковая, помидор, болгарский перец, лук репчатый, морковь", 2200, 
	"https://storage.emenu.delivery/product/images/mk/vt/mkvtit37lduac4zjbcq_ovg75o3erkrk.jpg", 5);

SELECT * FROM partners;
SELECT * FROM positions;

SELECT  partners.title, orders.id FROM partners
	LEFT JOIN positions ON positions.partner_id = partners.id
	LEFT JOIN orders_positions ON orders_positions.position_id = positions.id
	LEFT JOIN orders ON orders.id = orders_positions.order_id
	WHERE orders.id IS NULL;


# Задание 4. Напишите запрос, который по ID пользователя и ID заказа 
# выведет названия всех позиций из этого заказа.

SELECT positions.title FROM positions
	LEFT JOIN orders_positions ON orders_positions.position_id = positions.id
	LEFT JOIN orders ON orders_positions.order_id = orders.id
	LEFT JOIN clients ON orders.client_id = clients.id
	WHERE clients.id = 1 AND orders.id = 1;
	


