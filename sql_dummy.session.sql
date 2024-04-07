INSERT INTO jobss
VALUES (1,'2024-01-17',true,'koundis1.pdf',''),
        (2,'2024-01-18',true,'koundis2.pdf','rejected'),
        (3,'2024-01-19',false,'koundis3.pdf','selected'),
        (4,'2024-01-20',false,'koundis4.pdf','selected')


select * from jobss

AlTER  table jobss
add contact varchar(20)

insert INTO jobss (kouu)
VALUES()

alter table jobss
rename column contact to  kouu

update jobss
set kouu = 'thambi thmabi'
where jobs_id = 1;

update jobss
set kouu = 'anna thmabi'
where jobs_id = 2;

update jobss
set kouu = 'thambi anna'
where jobs_id = 3;

update jobss
set status = 'selected'
where status is null ;

alter TABLE jobss
AlTER column kouu set default 'kk'

delete from jobss
where jobs_id is null

alter TABLE jobss
AlTER column kouu type varchar(50)