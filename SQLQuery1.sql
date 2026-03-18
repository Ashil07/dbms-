create database bk_shop143

use bk_shop143


create table AUTHOR(
author_id int,
name char(20),
city char(20),
country char(20),
PRIMARY KEY(author_id)          
);


insert into AUTHOR values(101,'alephbook','karkala','india');
insert into AUTHOR values(102,'hachette','udupi','brazil');
insert into AUTHOR values(103,'penguinebooks','padubidri','china');
insert into AUTHOR values(104,'universitypress','manipal','japan');
insert into AUTHOR values(105,'aleph','karkala','portugal');
select *from AUTHOR

create table PUBLISHER(
publisher_id int,
pname char(20),
city char(20),
country char(20),
PRIMARY KEY(publisher_id)
);

insert into PUBLISHER values(10,'wiley','udupi','brazil');
insert into PUBLISHER values(11,'springer nature','karkala','india');
insert into PUBLISHER values(12,'oxford','manipal','japamn');
insert into PUBLISHER values(13,'pearson','padubidri','brazil');
insert into PUBLISHER values(14,'scholastic','moodbidri','brazil');
select *from PUBLISHER

create table CATAGORY(
category_id int,
description char(20),
PRIMARY KEY(category_id)
);


insert into CATAGORY values(1,'THEGOAT');
insert into CATAGORY values(2,'FANTASY');
insert into CATAGORY values(3,'ELEMENT');
insert into CATAGORY values(4,'WATER');
insert into CATAGORY values(5,'THEGOAT');
select *from CATAGORY

create table CATALOG1(
book_id int,
title varchar(20),
author_id int,
publisher_id int,
category_id int,
year int ,
price int,
PRIMARY KEY(book_id),
foreign key(author_id)references
AUTHOR(author_id)on delete cascade on update cascade,
foreign key(publisher_id)references
PUBLISHER(publisher_id)on delete cascade on update cascade,
foreign key(category_id)references
CATAGORY(category_id)on delete cascade on update cascade
)

insert into CATALOG1 values(20,'emid blyton',101,10,1,2025,5000);
insert into CATALOG1 values(30,'wing of fire',102,11,2,2026,6000);
insert into CATALOG1 values(40,'the dicovery india',103,12,3,2023,7000);
insert into CATALOG1 values(50,'play it my way',104,13,4,2024,8000);
insert into CATALOG1 values(60,'my experience',105,14,5,2015,9000);
select *from CATALOG1


create table ORDERDETAILS(
order_no int,
book_id int,
quantity int,
PRIMARY KEY(order_no),
foreign key(book_id) references
CATALOG1(book_id)on delete cascade on update cascade
)

insert into ORDERDETAILS values(1000,20,4);
insert into ORDERDETAILS values(2000,30,5);
insert into ORDERDETAILS values(3000,20,6);
insert into ORDERDETAILS values(4000,50,7);
insert into ORDERDETAILS values(5000,20,8);
select *from ORDERDETAILS



select A.author_id,A.name,A.city,sum(o.quantity) as QTY_SUM from AUTHOR A ,CATALOG1 C,ORDERDETAILS o
where A.author_id =C.author_id
and c.book_id=o.book_id group by a.author_id,A.name,A.city,c.book_id having sum(quantity)>=all(select sum(quantity) from ORDERDETAILS group by book_id)


update CATALOG1 set price = price*1.1 where publisher_id in (select publisher_id from PUBLISHER where pname='pearson')
select * from CATALOG1

