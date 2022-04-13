show databases;

use 20200128db;

CREATE TABLE ipl22
	(
    playerid varchar(10),
    playername varchar(100),
    team varchar(100),
    baseprice varchar(20)
    );
    
    
insert into ipl22(playerid,playername,team,baseprice) values('p002', 'Dhoni', 'CSK', '8 Millions');

select * from ipl22;