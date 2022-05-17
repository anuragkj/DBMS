show databases;
use 20200128db;
CREATE TABLE SALESMAN
(
SALESMAN_ID int(4) not null unique,
NAME varchar(20),
CITY varchar(20),
COMMISSION float(4),
primary key (SALESMAN_ID)
);
INSERT INTO SALESMAN VALUES(5001,'James Hoog','New York',0.15);
INSERT INTO SALESMAN VALUES(5002,'Nail Knite','Paris',0.13);
INSERT INTO SALESMAN VALUES(5005,'Pit Alex','London',0.11);
INSERT INTO SALESMAN VALUES(5006,'Mc Lyon','Paris',0.14);
INSERT INTO SALESMAN VALUES(5003,'Lausen Hen',NULL,0.12);
INSERT INTO SALESMAN VALUES(5007,'Paul Adam','Rome',0.13);

select * from SALESMAN;
desc SALESMAN;

CREATE TABLE CUSTOMER
(
CUSTOMER_ID int(4) not null unique,
CUST_NAME varchar(20),
CITY varchar(20),
GRADE int(3),
SALESMAN_ID int(4) not null,
primary key (CUSTOMER_ID),
foreign key(SALESMAN_ID) references SALESMAN(SALESMAN_ID)
);
SELECT * FROM SALESMAN;


CREATE TABLE ORDERS
(
ORD_NO int(5) not null unique,
PURCH_AMT float(10),
ORD_DATE date,
CUSTOMER_ID int(4) not null,
SALESMAN_ID int(4) not null,
primary key (ORD_NO),
foreign key(CUSTOMER_ID) references CUSTOMER(CUSTOMER_ID),
foreign key(SALESMAN_ID) references SALESMAN(SALESMAN_ID)
);
INSERT INTO CUSTOMER VALUES(3002,'Nick Rimando','New York', 100,5001);
INSERT INTO CUSTOMER VALUES(3005,'Graham Zusi','California', 200,5002);
INSERT INTO CUSTOMER VALUES(3001,'Brad Guzan','London', null,5005);
INSERT INTO CUSTOMER VALUES(3004,'Fabian Johns','Paris', 300,5006);	
INSERT INTO CUSTOMER VALUES(3007,'Brad Davis','New York', 200,5001);
INSERT INTO CUSTOMER VALUES(3009,'Geoff Camero','Berlin', 100,5003);
INSERT INTO CUSTOMER VALUES(3008,'Julian Green','London', 300,5002);
INSERT INTO CUSTOMER VALUES(3003,'Jozy Altidor','Moscow', 200,5007);
select * from CUSTOMER;
INSERT INTO ORDERS VALUES(70001, 150.5,'2012-10-05',3005,5002);
INSERT INTO ORDERS VALUES(70009, 270.65,'2012-09-10',3001,5005);
INSERT INTO ORDERS VALUES(70002, 65.26,'2012-10-05',3002,5001);
INSERT INTO ORDERS VALUES(70004, 110.5,'2012-08-17',3009,5003);
INSERT INTO ORDERS VALUES(70007, 948.5,'2012-09-10',3005,5002);
INSERT INTO ORDERS VALUES(70005, 2400.6,'2012-07-27',3007,5001);
INSERT INTO ORDERS VALUES(70008, 5760,'2012-09-10',3002,5001);
INSERT INTO ORDERS VALUES(70010, 1983.43,'2012-10-10',3004,5006);
INSERT INTO ORDERS VALUES(70003, 2480.4,'2012-10-10',3009,5003);
INSERT INTO ORDERS VALUES(70012, 250.45,'2012-06-27',3008,5002);
INSERT INTO ORDERS VALUES(70011, 75.29,'2012-08-17',3003,5007);
INSERT INTO ORDERS VALUES(70013, 3045.6,'2012-04-25',3002,5001);
#Table Queries 
SELECT * FROM SALESMAN;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

#Desrible Tables
DESC SALESMAN;
DESC CUSTOMER;
DESC ORDERS;

#1. Write a query to find those customers with their name and those salesmen with their name and city who lives in the same city
SELECT CUSTOMER.CUST_NAME,
SALESMAN.NAME, SALESMAN.CITY
FROM SALESMAN, CUSTOMER
WHERE SALESMAN.CITY = CUSTOMER.CITY;

#2. Query Write a SQL statement to find the names of all customers along with the salesmen who works for them.
SELECT CUSTOMER.CUST_NAME, SALESMAN.NAME
FROM CUSTOMER,SALESMAN
WHERE SALESMAN.SALESMAN_ID = CUSTOMER.SALESMAN_ID;

#3. Write a SQL statement to display all those orders by the customers not located in the same cities where their salesmen live.
SELECT ORD_NO, CUST_NAME, ORDERS.CUSTOMER_ID, ORDERS.SALESMAN_ID
FROM SALESMAN, CUSTOMER, ORDERS
WHERE CUSTOMER.CITY <> SALESMAN.CITY
AND ORDERS.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
AND ORDERS.SALESMAN_ID = SALESMAN.SALESMAN_ID;

#4. Write a SQL statement that finds out each order number followed by the name of the customers who made the order.
SELECT ORD_NO, CUST_NAME
FROM ORDERS, CUSTOMER
WHERE CUSTOMER.CUSTOMER_ID = ORDERS.CUSTOMER_ID;

#5. Write a SQL statement that sorts out the customer and their grade who made an order. Each of the customers must have a grade and served by at least a salesman, who belongs to a city.
SELECT CUSTOMER.CUST_NAME AS "CUSTOMER",
CUSTOMER.GRADE AS "GRADE",ORDERS.ORD_NO AS "ORDER NO."
FROM ORDERS, SALESMAN, CUSTOMER
WHERE ORDERS.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
AND ORDERS.SALESMAN_ID = SALESMAN.SALESMAN_ID
AND SALESMAN.CITY IS NOT NULL
AND CUSTOMER.GRADE IS NOT NULL;

#6. Write a query that produces all customers with their name, city, salesman and commission, who served by a salesman and the salesman works at a rate of the commission within 12% to 14%.
SELECT CUSTOMER.CUST_NAME AS "NAME", CUSTOMER.CITY AS "CITY", 
SALESMAN.NAME AS "SALESMAN", SALESMAN.COMMISSION AS "COMMISSION"
FROM CUSTOMER, SALESMAN
WHERE SALESMAN.SALESMAN_ID = CUSTOMER.SALESMAN_ID
AND SALESMAN.COMMISSION BETWEEN 0.12 AND 0.14;

#7. Write a SQL statement that produces all orders with the order number, customer name, commission rate and earned commission amount for those customers who carry their grade is 200 or more and served by an existing salesman.

SELECT ORD_NO, CUST_NAME, COMMISSION AS "COMMISSION RATE",
PURCH_AMT*COMMISSION AS "EARNED COMMISSION"
FROM SALESMAN,ORDERS,CUSTOMER
WHERE ORDERS.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
AND ORDERS.SALESMAN_ID = SALESMAN.SALESMAN_ID
AND CUSTOMER.GRADE>=200;

#8. rite a query to display all customers with a grade above 100.
SELECT * FROM CUSTOMER 
WHERE GRADE > 100;

#9. Write a query statement to display all customers in New York who have a grade value above 100.
SELECT * FROM CUSTOMER 
WHERE CITY = "NEW YORK" 
AND GRADE > 100;

#10. Write a SQL statement to display all the customers, who are either belongs to the city New York or not had a grade above 100.
SELECT * FROM CUSTOMER 
WHERE CITY = "NEW YORK"
OR GRADE <= 100;

#11. Write a SQL query to display those customers who are neither belongs to the city New York nor grade value is more than 100.
SELECT * FROM CUSTOMER 
WHERE CITY != "NEW YORK"
AND GRADE <= 100;

#12. Write a SQL statement to display either those orders which are not issued on date 2012-09-10 and issued by the salesman whose ID is 5005 and below or those orders which purchase amount is 1000.00 and below.
SELECT * FROM ORDERS
WHERE
(PURCH_AMT <= 1000.0)
OR
(ORD_DATE != '2021-09-10' AND SALESMAN_ID <= 5005);


