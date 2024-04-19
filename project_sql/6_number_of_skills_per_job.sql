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

limit 300
