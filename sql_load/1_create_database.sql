CREATE DATABASE sql_course;

-- DROP DATABASE IF EXISTS sql_course;


select job_location :: text, job_posted_date at time zone 'utc' at time zone 'est' as Daate,
extract(month from job_posted_date) as gundu

FROM job_postings_fact
limit 10



select * from job_postings_fact limit 100


select 
 avg(salary_year_avg) as year,
   avg(salary_hour_avg) as hour,
      
      job_schedule_type

      FROM job_postings_fact
   
 
   

   

  where extract (MONTH from job_posted_date) > 5 
   group by job_schedule_type
   having  avg(salary_year_avg) is not null
 
 order by year desc

limit 12


   create table january_jobs as
   select * 
   from job_postings_fact
   where extract(month from job_posted_date) = 1;

-- Create table for February
CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- Create table for March
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

select * from march_jobs

select 55 kun

select job_title_short, job_location,
case 
when job_location =  'Singapore' then 'local'
when job_location = 'Anywhere' then 'nee oru5 remote'
else 'on-site'
end as type_location

from job_postings_fact

limit 100

--create table jobsss as select job_location from job_postings_fact


-- i added an extra column with conditional statement

select  * ,

case
when salary_year_avg> 94000 and job_title_short = 'Data Analyst' then 'nalla kaasu' 

when salary_year_avg< 94000 and job_title_short = 'Data Analyst' then 'bad kaasu'
else 'standard'

end as Expectations

from 
job_postings_fact

where job_title_short like 'Data Analyst' and salary_year_avg is not null

order by salary_year_avg desc
--group by job_title_short

limit 100




-- using subqueries under from

select job_posted_date  , job_location
from (select * from job_postings_fact
where EXTRACT (year from job_posted_date) = 2022) as jan_jobs 

limit 100

--using cte

with jan_jobs as
   ( select job_posted_date,job_location
   from job_postings_fact
   where extract(month from job_posted_date)= 1 )

select * from jan_jobs limit 100



-- using subqueries under where

select name
from company_dim
where company_id in 
      (select company_id 
      from job_postings_fact where
      job_title_short like 'Data Analyst') 


limit 100




--practice problem 1 sub query using cte


with skillcount as (select skill_id, count(*) as kun 
from skills_job_dim 
 
group by skill_id
order by kun desc)

--select * from skillcount limit 100

select skillcount.skill_id, skills_dim.skills, skillcount.kun
from skills_dim
inner JOIN skillcount on skills_dim.skill_id = skillcount.skill_id 



--practice problem 1 using sub query 

/*
select skillcount.skill_id, skills_dim.skills, skillcount.kun
from  (select skill_id, count(*) as kun 
where job_work_from_home = 
from skills_job_dim 
group by skill_id
order by kun desc) as skillcount
*/











with skillcount as 
      (select skill_id,  count(*) as kun 
      from skills_job_dim  left join  job_postings_fact
      on skills_job_dim.job_id = job_postings_fact.job_id

      where  job_work_from_home = TRUE and job_title_short = 'Data Analyst'
      
      
      group by skill_id)


--select * from skillcount limit 100

select skillcount.skill_id, skills_dim.skills, skillcount.kun
from skillcount
inner JOIN skills_dim on skills_dim.skill_id = skillcount.skill_id 
order by kun desc 

limit 10


-- problem 2

with jobsss as (

            select  count(job_id) kun ,company_dim.company_id , company_dim.name
from job_postings_fact left join company_dim on

job_postings_fact.company_id = company_dim.company_id

group by company_dim.company_id 
)

select * , case

when kun <= 10 then 'small'
when kun  between 10 and 50 then 'medium'
else 'large'

end as category

from jobsss

order by kun desc

limit 100



-- curiosity
with kundi as (select job_title_short, salary_year_avg,name, job_location, skills


from job_postings_fact
      inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id 
      inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
      inner join company_dim on job_postings_fact.company_id = company_dim.company_id

            where job_location like '%India%' and salary_year_avg is not null

order by salary_year_avg desc
)



select * from kundi

limit 100



select skills, type

from
 skills_dim

 limit 100



--problem union 

with combine as
   ( select skills, type, job_posted_date, salary_year_avg, job_title_short
   from job_postings_fact 

   left join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id 

      left join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

      left join company_dim on job_postings_fact.company_id = company_dim.company_id

   where  extract(month from job_posted_date) between 1 and 3  

   and salary_year_avg > 70000 and

    job_title_short like 'Data Analyst'  )
    
select * from combine



order by salary_year_avg desc


 -- same problem


 select * 
 from (
   select job_title_short, job_location
 from january_jobs 
union all
 select job_title_short, job_location
 from february_jobs
 union all
  select job_title_short, job_location
 from march_jobs
 

where salary_year_avg > 70000) as combine


/* QUESTION: What are the top paying jobs for a Data Analyst 

- Top 10 paying jobs for the role of Data Analyst 
- Focusing on remote jobs for this query 
- Showing only jop postings where salary is mentioned

*/

SELECT 
        job_id,
        company_dim.name AS  "Company Name",
        job_title_short,
        job_location,
        salary_year_avg,
        job_schedule_type



FROM
      job_postings_fact LEFT JOIN company_dim ON 
      job_postings_fact.company_id = company_dim.company_id

WHERE job_title_short LIKE 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC
LIMIT 10







-- Number of skills per company 

select company_dim.name "Company Name", count (skills_job_dim.skill_id) as kun
from skills_job_dim 
inner join job_postings_fact on
           skills_job_dim.job_id = job_postings_fact.job_id
inner join company_dim on 
            job_postings_fact.company_id = company_dim.company_id

group by company_dim.name

order by kun desc
limit 1000

-- number of skills required per job


   with skillcount as  
(select job_postings_fact.job_id,job_postings_fact.job_title_short,
        count (skills_job_dim.skill_id) as number_of_skills, salary_year_avg
from skills_job_dim 
inner join job_postings_fact on
           skills_job_dim.job_id = job_postings_fact.job_id
           inner join company_dim
on job_postings_fact.company_id = company_dim.company_id

            where salary_year_avg IS NOT NULL

group by job_postings_fact.job_id

order by number_of_skills, salary_year_avg DESC

   )

select * from skillcount 

limit 1000


-- specific details based on job_id

SELECT skills_job_dim.skill_id, skills, company_dim.name as comapany_name,
job_postings_fact.* 

FROM skills_job_dim 
INNER JOIN skills_dim 
ON skills_job_dim.skill_id=skills_dim.skill_id
INNER JOIN job_postings_fact 
ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN company_dim 
ON job_postings_fact.company_id = company_dim.company_id

WHERE skills_job_dim.job_id = 551617

