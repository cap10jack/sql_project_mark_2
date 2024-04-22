/* number of skills required per job
6. Question: Optimizing for least skills to know for a higher salary
-  we will need the count function for the number of skills
*/

   with skillcount as  
(select job_postings_fact.job_id,job_postings_fact.job_title_short,
        count (skills_job_dim.skill_id) as number_of_skills, salary_year_avg
from skills_job_dim 
inner join job_postings_fact on
           skills_job_dim.job_id = job_postings_fact.job_id
        
            where salary_year_avg IS NOT NULL

group by job_postings_fact.job_id

order by number_of_skills, salary_year_avg DESC

   )

select * from skillcount 

limit 300
