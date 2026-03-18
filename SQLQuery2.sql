



create database ord_proc0143

use ord_proc0143

create table customer (
				custid int,
				cname char(15) not null,
				city varchar(30),
				primary key(custid),
				)
select count (*) as NO_of_employees from customer

insert into CUSTOMER values (111, 'John Smith','Karkala')
insert into CUSTOMER values (112, 'Ramesh N','Nitte')
insert into CUSTOMER values (113, 'Franklin','Karkala')
insert into CUSTOMER values (114, 'Alice','Mangalore')
insert into CUSTOMER values (115, 'Raju','Udupi')



create table c_order(
				orderid int,
				odate datetime,
				custid int,
				ordamt int
				primary key(orderid),
				foreign key(custid) references CUSTOMER(custid) on delete cascade on update cascade
				)

insert into c_order values (201,'2001-08-03', 111, null)
insert into c_order values (202,'2002-08-03', 111, null)
insert into c_order values (203,'2001-08-04', 112, null)
insert into c_order values (204,'2004-02-01', 113, null)
insert into c_order values (205,'2001-04-02', 114, null)
insert into c_order values (206,'2005-02-01', 115, null)
insert into c_order values (207,'2008-04-01', 115, null)
insert into c_order values (209,'2008-02-01', 114, null)
insert into c_order values (208,'2008-12-01', 111, null)

select * from c_order

update c_order set ordamt = (select sum(O.qty * T.price) from ORDER_ITEM O, ITEM T where O.itemid = T.itemid and O.orderid=201)      





create table item(
				itemid int,
				price int,
				primary key (itemid)
				 )


insert into item values (301,2000)
insert into item values (302,2000)
insert into item values (303,1000)
insert into item values (304,5000)
insert into item values (305,4000)






create table order_item(
				orderid int,
				itemid int,
				qty int,
				primary key (orderid,itemid),
				foreign key(orderid) references C_order(orderid) on delete cascade on update cascade,
				foreign key(itemid) references ITEM(itemid) on delete cascade on update cascade 
				)

insert into order_item values(201,301,2)
insert into order_item values(201,302,4)
insert into order_item values(201,303,4)
insert into order_item values(201,304,4)
insert into order_item values(201,305,3)

insert into order_item values(202,303,3)
insert into order_item values(202,305,4)
insert into order_item values(203,302,1)
insert into order_item values(204,305,2)
insert into order_item values(205,301,3)
insert into order_item values(206,301,5)




select * from order_item


create table warehouse(
					warehouseid int,
					city varchar(20) not null,
					primary key(warehouseid)
					)
insert into warehouse values (1,'MANGALORE')
insert into warehouse values (2,'MANGALORE')
insert into warehouse values (3,'MANGALORE')
insert into warehouse values (4,'UDUPI')
insert into warehouse values (5,'UDUPI')
insert into warehouse values (6,'KARKALA')

create table SHIPMENT(
					orderid int,
					warehouseid int,
					ship_dt datetime,
					primary key(orderid, warehouseid),
					foreign key(orderid) references C_ORDER(orderid) on delete cascade on update cascade,
					foreign key(warehouseid) references WAREHOUSE(warehouseid) on delete cascade on update cascade
					)


insert into SHIPMENT VALUES (201,1,'2001-04-02')
insert into SHIPMENT VALUES (201,2,'2001-04-04')
insert into SHIPMENT VALUES (202,1,'2001-05-02')

insert into SHIPMENT VALUES (202,2,'2002-05-12')
insert into SHIPMENT VALUES (202,3,'2003-06-02')
insert into SHIPMENT VALUES (202,4,'2003-06-01')
insert into SHIPMENT VALUES (203,1,'2004-02-01')
insert into SHIPMENT VALUES (203,2,'2001-02-01')
insert into SHIPMENT VALUES (203,3,'2001-02-01')
insert into SHIPMENT VALUES (204,4,'2004-06-02')
insert into SHIPMENT VALUES (204,2,'2004-06-02')

select * from SHIPMENT



select OI.itemid, count(DISTINCT OI.orderid ) as NO_OF_ORDERS, sum(OI.qty) as total_quantity
from order_item OI
join shipment s on OI.orderid =S.orderid
group by OI.orderid 
having count(DISTINCT OI.orderid)>2
and COUNT(DISTINCT S.warehouseid)>=2;





 