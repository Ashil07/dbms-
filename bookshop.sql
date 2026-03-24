create database bookshop

use bookshop

create table author(
		authorid int primary key,
		aname varchar(20),
		city varchar(20),
		country varchar(20),
)


insert into AUTHOR values(110,'Elmasri','Houston','Canada') 
insert into AUTHOR values(111,'sebesta','mangalore','India') 
insert into AUTHOR values(112,'Elmasri','Houston','Canada') 
insert into AUTHOR values(113,'Bharath K','Bangalore','India') 
insert into AUTHOR values(114,'Willy Z','California','USA') 
insert into AUTHOR values(115,'Salma','Dakha','Bangladesh')

create table publisher(
		publisherid int,
		pname varchar(20),
		city varchar(20),
		country varchar(20),
		primary key (publisherid)
)

insert into PUBLISHER values(201,'McGRAW','mangalore','India') 
insert into PUBLISHER values(202,'Pearson','Bangalore','India') 
insert into PUBLISHER values(203,'GKP','Bangalore','India') 
insert into PUBLISHER values(204,'MediTech','Delhi','India') 
insert into PUBLISHER values(205,'Sun','Ahmadbad','India')


create table category(
		categoryid int,
		dscript varchar(20),
		primary key(categoryid)
)

insert into CATEGORY values(1,'All children Books') 
insert into CATEGORY values(2,'Cooking Books') 
insert into CATEGORY values(3,'Popular Novels') 
insert into CATEGORY values(4,'Small Story Books') 
insert into CATEGORY values(5,'Medical Books')


create table catalogue(
		bookid int,
		title varchar(20),
		publisherid int,
		authorid int,
		categoryid int,
		year int,
		price int,
		primary key (bookid),
		foreign key (authorid) references author(authorid) on delete cascade on update cascade,
		foreign key (publisherid) references publisher(publisherid) on delete cascade on update cascade,
		foreign key (categoryid) references category(categoryid) on delete cascade on update cascade
)
 
insert into catalogue values(301,'Panchatantra',201,111,1,2000,300) 
insert into catalogue values(302,'Vegetables',202,111,2,2000,400) 
insert into catalogue values(303,'Yogasana',203,112,5,2002,600) 
insert into catalogue values(304,'Stories of Village',204,113,4,2005,100) 
insert into catalogue values(305,'Triangle',205,114,3,2008,1000) 
insert into catalogue values(306,'Naughtiest Girl',201,110,3,2007,1500) 
insert into catalogue values(307,'Cookery',205,115,2,2006,100) 
select * from catalogue

create table order_details(
		orderno int,
		bookid int,
		qty int,
		primary key(orderno,bookid),
		foreign key (bookid) references catalogue(bookid) on delete cascade on update cascade
)


insert into order_details values(1,301,10) 
insert into order_details values(1,302,6) 
insert into order_details values(1,307,23) 
insert into order_details values(2,301,15) 
insert into order_details values(2,304,11) 
insert into order_details values(3,304,15) 
insert into order_details values(4,301,3) 
insert into order_details values(4,305,8) 
insert into order_details values(5,303,20) 
insert into order_details values(5,306,6) 
insert into order_details values(5,305,7) 	


select A.authorid , A.aname, A.city , sum(O.qty) from 
author A, order_details O , catalogue C where A.authorid=C.authorid and 
O.bookid=C.bookid group by 
A.authorid,a.aname,a.city,C.bookid having sum(O.qty) >= all(
select sum(qty) from order_details group by bookid)

update catalogue set price= 1.1*price where publisherid in (
select publisherid from publisher where pname='Pearson')

select count(orderno) as NO_OF_ORDERS , bookid from order_details group by 
bookid having sum(qty)<= all(select sum(qty) from order_details group by bookid)
