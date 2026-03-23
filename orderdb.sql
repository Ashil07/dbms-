create database insurance
use insurance

create table person(
		driverid varchar(20),
		fname varchar(10),
		address varchar(30),
		primary key(driverid)
)
insert into person values('111','John Smith','SP-road Bangalore')
insert into  person values ('112','Ramesh' , 'KP Nagar Udupi 13') 
insert into  person values ('113','Raju SK' , 'KS Circle Mangalore12') 
insert into  person values ('114','Ramesh' , 'AS Road Bangalore14')
insert into  person values ('115','Alica ' , 'SS Karkala16' )
 

 select * from person

 create table car(
		regno varchar(10),
		model varchar(18),
		year int,
		primary key(regno)
)

insert into  CAR values ('KA-12','FORD' ,1980) 
insert into  CAR values ('KA-13','SWIFT' ,1990) 
insert into  CAR values ('MH-11','INDIGO' ,1998) 
insert into  CAR values ('AP-10','SWIFT' ,1988) 
insert into  CAR values ('TN-11','FORD' ,2001) 
insert into  CAR values ('TN-12','TOYATA' ,2001) 
insert into  CAR values ('MH-14','SWIFT' ,2001) 
insert into  CAR values ('KL-15','TOYATA' ,2001) 
insert into  CAR values ('KL-4','INDIGO' ,2001) 
insert into  CAR values ('AP-05','SANTRO' ,2001) 


create table accident(
		reportno int,
		accdate datetime,
		location varchar(30),
		primary key(reportno)
)

 
insert into  ACCIDENT values (1,'1998-07-22' ,'Nitte') 
insert into  ACCIDENT values (2,'1998-07-22','Karkala') 
insert into  ACCIDENT values (12,'1998-07-22' ,'Mangalore') 
insert into  ACCIDENT values (3,'1998-07-23','Mangalore') 
insert into  ACCIDENT values (4,'1990-09-09','Bhatkal') 
insert into  ACCIDENT values (5,'2001-02-22' ,'Udupi') 
insert into  ACCIDENT values (6,'1990-09-09','Udupi') 
insert into  ACCIDENT values (15,'1981-07-22' ,'Udupi')

create table owns(
		driverid varchar(20),
		regno varchar(10),
		primary key(driverid,regno),
		foreign key (driverid) references person(driverid) on delete cascade on update cascade,
		foreign key (regno) references car(regno) on delete cascade on update cascade
)

insert into  OWNS values ('111','KA-13') 
insert into  OWNS values ('111','KA-12') 
insert into  OWNS values ('111','MH-11') 
insert into  OWNS values ('112','AP-10') 
insert into  OWNS values ('112','TN-11') 
insert into  OWNS values ('113','TN-12') 
insert into  OWNS values ('113','KL-15') 
insert into  OWNS values ('114','AP-05') 
insert into  OWNS values ('114','KL-4') 
insert into  OWNS values ('115','MH-14') 

create table participated (
		driverid varchar(20),
		regno varchar(10),
		reportno int,
		dmgamount int,
		primary key(driverid,regno,reportno),
		foreign key(driverid) references person(driverid) on delete cascade on update cascade,
		foreign key(regno) references car(regno) on delete cascade on update cascade,
		foreign key(reportno) references accident(reportno) on delete cascade on update cascade
)


 
insert into  participated values ('111','KA-12',1,20000) 
insert into  participated values ('111','KA-13',2,10000) 
insert into  participated values ('111','KA-12',3,60000) 
insert into  participated values ('111','KA-12',4,60000) 
insert into  participated values ('111','KA-12',5,60000) 
insert into  participated values ('111','KA-12',15,40000) 
insert into  participated values ('111','KA-13',6,10000) 
insert into  participated values ('111','MH-11',12,20000)  
insert into  participated values ('112','AP-10',7,30000) 
insert into  participated values ('112','TN-11',8,40000) 
insert into  participated values ('112','AP-10',13,20000) 
insert into  participated values ('112','TN-11',14,10000)  
insert into  participated values ('113','TN-12',9,40000) 
insert into  participated values ('113','KL-15',10,50000) 
insert into  participated values ('113','TN-12',11,20000) 
 
select * from participated 


 select count(distinct(p.driverid)) from accident A , participated p 
 where A.reportno=p.reportno and year(A.accdate)='1998'

 select count(P.reportno) from participated P, Person PN where
 P.driverid=PN.driverid and 
 PN.fname='John Smith'

 update participated set dmgamount = 3000 where regno='KA-12' and reportno=1
		
