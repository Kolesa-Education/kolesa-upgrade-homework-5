attach database 'db_file.db' as 'order_scheme'
create table order_scheme.Partners (
partner_id primary key,
title varchar(150) not null,
description text,
address varchar(255) not null
);
create table order_scheme.Positions(
position_id primary key,
title varchar(255) not null,
description text,
price decimal not null default(0),
photo_url varchar(255) not null,
partner_id int ,
Foreign key (partner_id)  references  Partners(partner_id)
);
create table order_scheme.Clients(
client_id primary key,
phone varchar(12),
fullname varchar(255)
);
create table order_scheme.Orders(
order_id primary key,
created_at datetime,
address varchar(255) ,
latitude float,
longitude float,
status varchar(255) check (status in ('новый','принят рестораном','доставляется','завершен')),
client_id int ,
Foreign key (client_id)  references  Clients(client_id)
);
CREATE table order_scheme.pos_ord(
position_id int ,
order_id int ,
Foreign key (position_id)  references  Positions(position_id),
Foreign key (order_id)  references  Orders(order_id)
);
/* первая задача */
insert into order_scheme.Partners  values (1,'Patner1','first partner','st.default 1');
insert into order_scheme.Partners  values (2,'Patner2','second partner','st.default 2');
insert into order_scheme.Partners  values (3,'Patner3','third partner','st.default 3'); 

insert into order_scheme.Positions  values (1,'Position1','first position',1000,'default url',1);
insert into order_scheme.Positions  values (2,'Position2','second position',2000,'default url',2);
insert into order_scheme.Positions  values (3,'Position3','third position',3000,'default url',3);
insert into order_scheme.Positions  values (4,'Position1','first position',1000,'default url',2);
insert into order_scheme.Positions  values (5,'Position2','second position',2000,'default url',1);
insert into order_scheme.Positions  values (6,'Position3','third position',3000,'default url',1);
insert into order_scheme.Positions  values (7,'Position1','first position',1000,'default url',3);
insert into order_scheme.Positions  values (8,'Position2','second position',2000,'default url',3);
insert into order_scheme.Positions  values (9,'Position3','third position',3000,'default url',2);

insert into order_scheme.Clients  values (1,'87770000001','Client1');
insert into order_scheme.Clients  values (2,'87770000002','Client2');
insert into order_scheme.Clients  values (3,'87770000003','Client3'); 

insert into order_scheme.Orders  values  (1,DATE('now'),'st. order 1',1.111,1.1112,'новый',1);
insert into order_scheme.Orders  values  (2,DATE('now'),'st. order 2',1.131,1.1412,'новый',2);
insert into order_scheme.Orders  values  (3,DATE('now'),'st. order 2',1.131,1.1412,'доставляется',2);
insert into order_scheme.Orders  values  (4,DATE('now'),'st. order 3',1.431,1.1442,'доставляется',3);
insert into order_scheme.Orders  values  (5,DATE('now'),'st. order 3',1.431,1.1442,'принят рестораном',3);
insert into order_scheme.Orders  values  (6,DATE('now'),'st. order 3',1.431,1.1442,'завершен',3);

insert into order_scheme.pos_ord  values (1,1) ;
insert into order_scheme.pos_ord  values (5,1) ;
insert into order_scheme.pos_ord  values (5,2) ;
insert into order_scheme.pos_ord  values (2,3) ;
insert into order_scheme.pos_ord  values (4,3) ;
insert into order_scheme.pos_ord  values (8,4) ;
insert into order_scheme.pos_ord  values (9,5) ;
insert into order_scheme.pos_ord  values (7,6) ;
insert into order_scheme.pos_ord  values (8,6) ;
insert into order_scheme.pos_ord  values (3,6) ;


/* вторая задача  */
SELECT 
DISTINCT 
o.order_id,
c.phone,
p.title
from 

order_scheme.Clients c,
order_scheme.Partners p,
order_scheme.Orders o,
order_scheme.Positions pos,
order_scheme.pos_ord po

where c.client_id=o.client_id
  and po.order_id=o.order_id
  and po.position_id=pos.position_id
  and pos.partner_id=p.partner_id
/* третья  задача  */
  insert into order_scheme.Partners  values ( 4,'Patner4','fourth partner','st.default 4'); 
  insert into order_scheme.Positions  values (10,'Position1','first position',3000,'default url',4);
  
select p.* from order_scheme.Partners p
where p.partner_id not in (select partner_id from pos_ord po ,order_scheme.Positions pos where 
po.position_id=pos.position_id)
/* четвертая  задача  */
SELECT pos.title FROM order_scheme.Orders o,
order_scheme.Positions pos,
order_scheme.pos_ord po
where  po.order_id=o.order_id
  and po.position_id=pos.position_id
  and o.order_id=6
  AND o.client_id=3
