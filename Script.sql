create database if not exists food_delivery;

use food_delivery;

select
	*
from
	Partners;

create table Partners (
	id INT unsigned auto_increment primary key,
	title VARCHAR(150) not null,
	description TEXT,
	address VARCHAR(255) not null
);

create table Positions (
	id INT unsigned auto_increment primary key,
	title VARCHAR(255) not null,
	description TEXT,
	price INT not null default(0),
	photo_url VARCHAR(255),
	partner_id INT unsigned not null,
	foreign key (partner_id) references Partners(id) on update cascade on delete cascade
);

create table Clients (
	id INT unsigned auto_increment primary key,
	phone CHAR(12),
    fullname VARCHAR(255)
);

create table Orders (
	id INT unsigned auto_increment primary key,
	created_at datetime,
	address VARCHAR(255),
	latitude float,
	longitude float,
	status enum('new',
'accepted',
'delivery',
'completed') not null,
	client_id INT unsigned not null,
	foreign key (client_id) references Clients(id) on update cascade on delete restrict
);

create table Order_positions (
	order_id INT unsigned not null,
    position_id INT unsigned not null,
    primary key(order_id,
position_id),
    foreign key (order_id) references Orders(id) on update cascade on delete cascade,
	foreign key (position_id) references Positions(id) on update cascade on delete restrict
);

#1
insert
	into
	partners (title,
	description,
	address)
values 
		('Bahandi',
'Bahandi burger — это лучшая cеть городских кафе быстрого обслуживания, классический burger в лучшем его проявлении',
'​улица Масанчи 96'),
    	('Shafran',
'Семейный ресторан',
'улица Толе би, 112'),
    	('Lanzhou',
'сеть ресторанов быстрого питания',
'пр-т. Абая 44');

    

insert
	into
	positions(title,
	description,
	price,
	photo_url,
	partner_id)
values 
		('Menu Cheese Burger куриный',
'Бургер с куриной котлетой с сыром, порция картошки фри, напиток на выбор, соус на выбор.',
2000,
'​Bahandi1.jpg',
1),
    	('Menu Cheese Burger говяжий',
'Бургер с говяжей котлетой с сыром, порция картошки фри, напиток на выбор, соус на выбор.',
2300,
'Bahandi2.jpg',
1),
    	('Menu Mix Cheese Burger x2.',
'Бургер с говяжей и куриной котлетой с сыром, порция картошки фри, напиток на выбор, соус на выбор.',
2500,
'​Bahandi3.jpg',
1),
    	('Фри с мясом',
'Фри, говядина, репчатый лук, болгарский перец',
1290,
'Shafran1.jpg',
2),
    	('Феттучини с семгой',
'Феттучини, семга, лук, пармезан, сливки',
2190,
'Shafran2.jpg',
2),
    	('Куырдак из баранины',
'Баранина, лук репчатый, картофель, соль, перец',
1190,
'Shafran3.jpg',
2),
    	('Комбо Цомян',
'А как на счет цомяна, свежего салата и воздушной пампушки',
2190,
'​Lanzhou1.jpg',
3),
    	('Комбо картофель с мясом',
'А как на счет жареного картофеля с мясом, свежего салата, лепешки и лимонада',
2490,
'​Lanzhou2.jpg',
3),
    	('Комбо Фирменный',
'А как на счет Фирменного блюда, свежего салата, пампушки и компота 0,5',
2290,
'​​Lanzhou3.jpg',
3);

INSERT into clients (phone, fullname)
VALUES 	('+77759259098', 'Ulan Zhassanov'),
    	('+77076667788', 'John Dow'),
    	('+77012225577', 'Andrew Dean');

INSERT into orders (created_at, address, latitude, longitude, status, client_id)
values 	('2022-10-06 16:15:00','пр-т. Абая 15','43.235056', '76.874179','new',1),
		('2022-10-06 15:15:00','пр-т. Абая 15','43.235056', '76.874179','delivery',1),
		('2022-10-04 16:15:00','пр-т. Абая 15','43.235056', '76.874179','completed',1),
		('2022-10-06 12:00:00','улица Гоголя 15','43.235056', '76.874179','accepted',2),
		('2022-10-04 21:38:37','микрорайон №1','43.235056', '76.874179','completed',3),
		('2022-10-03 20:45:46','микрорайон №1','43.235056', '76.874179','completed',3),
		('2022-10-01 18:19:26','микрорайон №1','43.235056', '76.874179','completed',3);

select * from orders;
select * from positions;

insert
	into
	order_positions (order_id,
	position_id)
values (1,4),
    	(1,5),
    	(2,7),
    	(3,7),
    	(3,8),
   	 	(3,9),
    	(4,3),
    	(5,1),
    	(6,1),
    	(7,1),
    	(7,2);

#2
select
	o.id,
	c.phone,
	prt.title
from
	orders o
join clients c on
	c.id = o.client_id
join order_positions op on
	op.order_id = o.id
join positions pos on
	pos.id = op.position_id
join partners prt on
	prt.id = pos.partner_id

#3
INSERT into partners(title, description, address)
values ('Papa Johns', 'Закажите горячую пиццу на дом или в офис', 'улица Гоголя 75');

insert
	into
	positions(title,
	description,
	price,
	photo_url,
	partner_id)
values ('Папа Микс Рэнч',
'Четыре любимых пиццы в одной: Цыплёнок Рэнч, Спайси Ранч, Четыре Сыра, Ветчина и Грибы',
5350,
'PapaJohns.jpg',
4);


select
	*
from
	partners prt
left join (
	select
		pos.partner_id
	from
		positions pos
	join order_positions op on
		pos.id = op.position_id) pos on
	pos.partner_id = prt.id
where
	pos.partner_id is null;

#4
select
	o.client_id,
	o.id,
	group_concat(pos.title)
from
	orders o
join order_positions op on
	op.order_id = o.id
join positions pos on
	pos.id = op.position_id
group by
	o.client_id,
	o.id
