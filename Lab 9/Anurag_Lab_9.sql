use 20200128db;
delimiter //
CREATE PROCEDURE HelloWorld()
BEGIN
SELECT 'Hello World!';
END; //
delimiter ;
CALL HelloWorld();

CREATE FUNCTION HelloName(name VARCHAR(100))
RETURNS VARCHAR(120) DETERMINISTIC
RETURN CONCAT('Hello ', name);
SET @fn_res = HelloName('BPDC');
select @fn_res;

delimiter $$
create function compute_square_fun(number int)
returns int
begin
return number * number;
end $$
delimiter ;

delimiter $$
create function compute_circle_area(radius int)
returns float
begin
return 3.14*radius * radius;
end$$
delimiter ;

select compute_square_fun(3);
select compute_circle_area(4);

create table t(s1 int);
INSERT INTO t VALUES (17);

delimiter //
CREATE PROCEDURE p12 (IN parameter1 INT)
BEGIN
DECLARE variable1 INT;
SET variable1 = parameter1 + 1;
IF variable1 = 0 THEN
INSERT INTO t VALUES (17);
END IF;
IF parameter1 = 0 THEN
UPDATE t SET s1 = s1 + 1 where s1 = 17;
ELSE
UPDATE t SET s1 = s1 + 2 where s1 = 17;
END IF;
END; //

delimiter ;
CALL p12(1);

select * from t;

delimiter //
CREATE PROCEDURE p13 (IN parameter1 INT)
BEGIN
DECLARE variable1 INT;
SET variable1 = parameter1 + 1;
CASE variable1
WHEN 0 THEN
INSERT INTO t VALUES (17);
WHEN 1 THEN
INSERT INTO t VALUES (18);
ELSE
INSERT INTO t VALUES (19);
END CASE;
END; //
delimiter ;
CALL p13(0);
select * from t;

delimiter //
CREATE PROCEDURE p14 ()
BEGIN
DECLARE v INT;
SET v = 0;
WHILE v < 5 DO
INSERT INTO t VALUES (v);
SET v = v + 1;
END WHILE;
END; //
delimiter ;
CALL p14();
select * from t;


delimiter //
CREATE PROCEDURE p15 ()
BEGIN
DECLARE v INT;
SET v = 5;
REPEAT
INSERT INTO t VALUES (v);
SET v = v + 1;
UNTIL v >= 10
END REPEAT;
END; //
delimiter ;
CALL p15();
select * from t;

delimiter //
CREATE PROCEDURE p16 ()
BEGIN
DECLARE v INT;
SET v = 10;
loop_label: LOOP
INSERT INTO t VALUES (v);
SET v = v + 1;
IF v >= 15 THEN
LEAVE loop_label;
END IF;
END LOOP;
END; //
delimiter ;
CALL p16();
select * from t;

#Even placed rows
SELECT * FROM t WHERE MOD(s1, 2) = 0;

#Odd placed rows
SELECT * FROM t WHERE MOD(s1, 2) = 1;

delimiter //
CREATE PROCEDURE p17 (IN parameter1 INT)
BEGIN
DECLARE variable1 INT;
SET variable1 = parameter1 + 1;
CASE variable1
WHEN 0 THEN
INSERT INTO t VALUES (15);
WHEN 1 THEN
INSERT INTO t VALUES (16);
ELSE
INSERT INTO t VALUES (17);
END CASE;
END; //
delimiter ;
CALL p17(0);
select * from t;

CALL p17(-1);
select * from t;

CALL p17(2);
select * from t;
