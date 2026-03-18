
create database INSURANCE2026006;
use INSURANCE2026006;


create table PERSON (
driverid varchar(15) not null PRIMARY KEY,
dname varchar(30) unique,
daddress varchar(50)
);

insert into PERSON values('111','ravi','SP Road, Banglore-12')
insert into PERSON values('112','Ramesh Bahu','Kp Nagar','Udupi-13')
insert into PERSON values('113','Raju SK','KS')
insert into PERSON values('114','raju','academic')
insert into PERSON values('115','hemanth','academic')
select * from PERSON;

create table CAR (
regno varchar(15) not null PRIMARY KEY,
			)

insert into COURSE values(1,'DBMS','CS')
insert into COURSE values(2,'Compiler','CS')
insert into COURSE values(3,'JAVA','CS')
insert into COURSE values(4,'SIG PROCESSING','ENC')
insert into COURSE values(5,'DIGTAL CIRCUITS','ENC')
insert into COURSE values(6,'MACHINE DESIGN','MECH')
insert into COURSE values(7,'THERMODYNAMICS','MECH')
insert into COURSE values(8,'AUTOCAD','MECH')

select * from COURSE

create table TEXTBOOK (
				bookISBN int,
				title varchar(50),
				publisher varchar(20),
				author char(20),
				primary key(bookISBN)
			)

insert into TEXTBOOK values(201,'Fundamentals of DBMS','McGraw','NAVATHE')
insert into TEXTBOOK values(202,'Database Design','McGraw','Raghu Rama')
insert into TEXTBOOK values(203,'Compiler Design','Pearson','Ulma')
insert into TEXTBOOK values(204,'Java Complete Reference','McGraw','BALAGURU')
insert into TEXTBOOK values(205,'Signals and  Fundamental','McGraw','NITHIN')
insert into TEXTBOOK values(206,'Machine Theory','McGraw','Ragava')
insert into TEXTBOOK values(207,'Thermodynamics','McGraw','Alfred')
insert into TEXTBOOK values(208,'Circuit Design','McGraw','Rajkamal')
insert into TEXTBOOK values(209,'Electronis Circuits','McGraw','Alfred')
insert into TEXTBOOK values(210,'Circuits Theory','McGraw','Alfred')

select * from TEXTBOOK

create table BOOK_ADAPTION (
				course int,
				sem int,
				bookISBN int,
				primary key(course,sem,bookISBN),
				foreign key(course) references COURSE(course) on delete cascade on update cascade,
				foreign key(bookISBN) references TEXTBOOK(bookISBN) on delete cascade on update cascade
			)

insert into BOOK_ADAPTION values(1,5,201)
insert into BOOK_ADAPTION values(1,7,202)
insert into BOOK_ADAPTION values(2,5,203)
insert into BOOK_ADAPTION values(2,6,203)
insert into BOOK_ADAPTION values(3,7,204)
insert into BOOK_ADAPTION values(4,3,205)
insert into BOOK_ADAPTION values(4,5,209)
insert into BOOK_ADAPTION values(5,5,205)
insert into BOOK_ADAPTION values(5,6,208)
insert into BOOK_ADAPTION values(5,2,210)
insert into BOOK_ADAPTION values(6,7,206)
insert into BOOK_ADAPTION values(7,3,207)
insert into BOOK_ADAPTION values(7,3,206)
insert into BOOK_ADAPTION values(8,3,207)

select * from BOOK_ADAPTION

create table enroll(
				regno varchar(10),
				course int,
				sem int,
				marks int,
				primary key(regno,course,sem),
				foreign key(regno) references STUDENT(regno) on delete cascade on update cascade,
				foreign key(course) references COURSE(course) on delete cascade on update cascade
			)

insert into enroll values (111,1,5,59)
insert into enroll values (111,2,5,70)
insert into enroll values (111,3,5,75)
insert into enroll values (112,1,5,49)
insert into enroll values (113,2,5,80)
insert into enroll values (114,3,7,79)
insert into enroll values (115,4,3,79)

select * from enroll 

select A.bookISBN,A.title,B.Course,B.cname from TEXTBOOK A,COURSE B,BOOK_ADAPTION C where A.bookISBN=C.bookISBN and B.Course=C.Course
and B.dept='CS' and B.Course in (select course from BOOK_ADAPTION group by course having count(*)>=2) order by A.title



select C.dept from COURSE C, BOOK_ADAPTION B, TEXTBOOK A
where C.course=B.course and B.bookISBN = A.bookISBN group by C.dept having count(B.bookISBN) >=ALL (select count(distinct D.bookISBN)
from COURSE F,BOOK_ADAPTION D,TEXTBOOK E  where F.course=D.course and D.bookISBN=E.bookISBN group by F.dept)


select distinct C.dept from COURSE C where not exists (select bookISBN from BOOK_ADAPTION where course in (select COURSE from COURSE where dept=C.dept)
and bookISBN not in(select T.bookISBN from  TEXTBOOK T where T.publisher='Mcgraw'))





             