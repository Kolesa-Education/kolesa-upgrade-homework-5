



create database service;
use service;
create table  Partners ( 	
	id int unsigned  not null  primary key auto_increment,
	title varchar(150) not null,
	description text,
	address varchar(255) not null
);

create table  Positions ( 	
	id int unsigned  not null  primary key auto_increment,
	title varchar(255) not null,
	description text,
	price int not null default(0),
	photo_url varchar(255),
	partner_id int unsigned not null,
	foreign key (partner_id) references Partners(id)
		on update cascade 
		on delete restrict 
);

create table Clients (

	id int unsigned not null primary key auto_increment,
	phone char(12),
	fullname varchar(255)

);



create table  Orders ( 	
	id int unsigned  not null  primary key auto_increment,
	created_at datetime,
	address varchar(255),
	latitude float,
	longitude float,
	status enum('fulfilled','fulfilling','notfulfilled'), 
	client_id int unsigned not null,
	foreign key (client_id) references Clients(id)
		on update cascade 
		on delete restrict 
);


create table Positions_Orders (
	position_id int unsigned not null,
	order_id int unsigned not null,
	foreign key(position_id) references Positions(id)
		on update cascade 
		on delete restrict, 
	foreign key(order_id) references Orders(id)
		on update cascade 
		on delete restrict 
);


insert into partners (title, description,address) values ('City Wok', 'A chinese restaurant', 'Baker St. 221B');
insert into partners (title, description,address) values ('Dodo Pizza', 'A fastfood restaurant', 'Koshkarbayeva St. 21/3');
insert into partners (title, description,address) values ('Burger King', 'A fastfood restaurant', 'Samiruk St. 3/3');
insert into partners (title, description,address) values ('Del Papa', 'An italian restaurant', 'Ruskulov St. 4/5');

insert into positions (title, description,price,photo_url,partner_id) values ('Margherita','A pizza covered with mozzarella cheese',1500,'https://upload.wikimedia.org/wikipedia/commons/c/c8/Pizza_Margherita_stu_spivack.jpg',2);
insert into positions (title, description,price,photo_url,partner_id) values ('Smouldering flames','A pizza covered with the halapeno pepper',2300,'https://s23209.pcdn.co/wp-content/uploads/2012/05/Jalapeno-Popper-PizzaIMG_1697-600x900.jpg?p=270',2);
insert into positions (title, description,price,photo_url,partner_id) values ('Buffalo 666','A pizza covered with shredded buffalo jackfruit',1900,'https://images.squarespace-cdn.com/content/v1/5a9b049f75f9eef8f485a56e/1562767148361-GVKV1XC6FB3PYPZZ6AP7/EbZSTZ%25aTNiYFJPp4tF1AA_thumb_88ae.jpg',2);

insert into positions (title, description,price,photo_url,partner_id) values ('Peking Roasted Duck','a famous dish from Beijing, enjoying world fame, and considered as one of China national dishes.',2900,'https://images.chinahighlights.com/allpicture/2021/12/d247e7d25b164b77841f6022_cut_750x400_39.webp',1);
insert into positions (title, description,price,photo_url,partner_id) values ('Kung Pao Chicken','a famous Sichuan-style specialty, popular with both Chinese and foreigners',1900,'https://images.chinahighlights.com/allpicture/2019/11/31acb7b302ec4b48b17443ed_cut_750x400_39.webp',1);
insert into positions (title, description,price,photo_url,partner_id) values ('Sweet and sour pork','has a bright orange-red color, and a delicious sweet and sour taste',1900,'https://images.chinahighlights.com/allpicture/2019/11/a4ad4a7fe0cb401cb0be6383_cut_750x400_39.webp',1);

insert into positions (title, description,price,photo_url,partner_id) values ('Whopper','A ¼ lb* of flame-grilled beef patty topped with juicy tomatoes, crisp lettuce, creamy mayonnaise, ketchup,',500,'https://cdn.sanity.io/images/czqk28jt/prod_bk_us/84743a96a55cb36ef603c512d5b97c9141c40a33-1333x1333.png?w=320&q=40&fit=max&auto=format',3);
insert into positions (title, description,price,photo_url,partner_id) values ('Whopper Jr.','A flame-grilled beef patty with juicy tomatoes, crisp lettuce, creamy mayonnaise, ketchup, crunchy pickles, and sliced',400,'https://cdn.sanity.io/images/czqk28jt/prod_bk_us/a186587fa5489876daa7a480d72aa517ddfed595-1333x1333.png?w=320&q=40&fit=max&auto=format',3);
insert into positions (title, description,price,photo_url,partner_id) values ('Single Quarter Pound King','Our Quarter Pound KING™ Sandwich has over ¼ lb.* of flame-grilled 100% beef, topped with all of our classic favorites',1000,'https://cdn.sanity.io/images/czqk28jt/prod_bk_us/55361a27d204b821ff404ed6a70d654c1224ecb0-1333x1333.png?w=320&q=40&fit=max&auto=format',3);


insert into positions (title, description,price,photo_url,partner_id) values ('English Breakfast','beef sausages, stewed beans,spinach, green peas, cherry tomatoes, aioli pesto and eggs of your choice',1430,'https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Full_English_breakfast.jpg/330px-Full_English_breakfast.jpg',4);
insert into positions (title, description,price,photo_url,partner_id) values ('Beet confit','with salsa verde sauce feta cheese and almond',5400,'https://miro.medium.com/max/828/1*vnLuPfX78jMmHVe_hcjPLg.jpeg',4);
insert into positions (title, description,price,photo_url,partner_id) values ('Salted salmon tartare','avocado, cereal chips',4500,'https://www.raymondblanc.com/wp-content/uploads/2018/04/Raymond_Blanc_001-346.jpg',4);

insert into clients  (fullname , phone ) values ('Salam Bulatov','870182117322');
insert into clients  (fullname , phone ) values ('Margulan Dzhumabekov','871189211733');
insert into clients  (fullname , phone ) values ('Kaisar Molatov','870182217394');


insert into orders  (created_at , address, latitude,longitude,status,client_id) values ('2015-11-05 14:29:36','469 Boston Court West Islip, NY 11795', 5,45,'fulfilled',1);

insert into orders  (created_at , address, latitude,longitude,status,client_id) values ('2022-11-05 14:29:36','80 Surrey Ave. Morgantown, WV 2650', 7,48,'fulfilling',2);
insert into orders  (created_at , address, latitude,longitude,status,client_id) values ('2022-11-05 14:29:36','7220 Mill Ave. New Brunswick, NJ 0890', 1,23,'fulfilling',2);

insert into orders  (created_at , address, latitude,longitude,status,client_id) values ('2016-11-05 14:29:36','97 Plumb Branch Lane Hoboken, NJ 07030', 67,95,'notfulfilled',3);
insert into orders  (created_at , address, latitude,longitude,status,client_id) values ('2022-11-06 14:29:36','27 Wild Horse St. Anaheim, CA 9280', 35,78,'fulfilling',3);
insert into orders  (created_at , address, latitude,longitude,status,client_id) values ('2016-11-07 14:29:36','469 Boston Court West Islip, NY 11795', 41,78,'fulfilled',3);


insert into positions_orders  (position_id, order_id) values (1,1);
insert into positions_orders  (position_id, order_id) values (2,2);
insert into positions_orders  (position_id, order_id) values (3,1);
insert into positions_orders  (position_id, order_id) values (11,3);
insert into positions_orders  (position_id, order_id) values (5,6);
insert into positions_orders  (position_id, order_id) values (7,2);
insert into positions_orders  (position_id, order_id) values (7,3);
insert into positions_orders  (position_id, order_id) values (11,1);
insert into positions_orders  (position_id, order_id) values (12,5);
insert into positions_orders  (position_id, order_id) values (8,2);
insert into positions_orders  (position_id, order_id) values (9,3);
insert into positions_orders  (position_id, order_id) values (3,4);
insert into positions_orders  (position_id, order_id) values (4,2);
insert into positions_orders  (position_id, order_id) values (5,1);


select o.id ,c.phone ,p.title  from 
partners p
inner join positions p2 on p.id =p2.partner_id 
inner join positions_orders po on po.position_id =p2.id 
inner join orders o on o.id =po.order_id 
inner join clients c on c.id = o.client_id;

insert into partners (title, description,address) values ('TEST VERSION', 'TEST', 'TEST STREET');
insert into positions (title, description,price,photo_url,partner_id) values ('TEST DISH','TEST DESCRIPTION',0,'TEST PHOTO',5);

select o.id ,c.phone ,p.title  from 
partners p
inner join positions p2 on p.id =p2.partner_id 
inner join positions_orders po on po.position_id =p2.id 
inner join orders o on o.id =po.order_id 
inner join clients c on c.id = o.client_id;

select p.title ,p.description  from 
partners p
where not exists (select * from positions_orders po inner join positions p2 on p2.id =po.position_id where p2.partner_id =p.id );

select p.title  from clients c 
inner join orders o on o.client_id =c.id 
inner join positions_orders po on po.order_id =o.id 
inner join positions p on p.id =po.position_id 
where c.id =2 and o.id =2;





















