/* QUESTION: What skills are required for the top paying Data Analyst jobs?
-Use the previous query to compile the top paying Data Analyst roles
-Add specific skills required for the roles
-Why? It helps job seekers to get a sense of what skills are needed by the top employers
 and they can choose to upgrade their skills accordingly 
*/ 


SELECT 
        job_postings_fact.job_id,
        company_dim.name AS  "Company Name",
        job_title_short,
        salary_year_avg,
        skills_dim.skills
        

FROM
      job_postings_fact LEFT JOIN company_dim ON 

      job_postings_fact.company_id = company_dim.company_id

      INNER join skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 

      INNER join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title_short LIKE 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL



ORDER BY salary_year_avg DESC

LIMIT 100



-- Alternatively we can also use CTE to make the code look cleaner

with top_paying_jobs as 
(
            SELECT 
                  job_id,
                  company_dim.name AS  "Company Name",
                  job_title_short,
                  salary_year_avg

            FROM
                  job_postings_fact LEFT JOIN company_dim ON 
                  job_postings_fact.company_id = company_dim.company_id

                        /*          Remember you can always modify this
                        for different roles and locations as per your convenience */

            WHERE job_title_short LIKE 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
            ORDER BY salary_year_avg DESC
)

SELECT 

      top_paying_jobs.*, skills_dim.skills 

FROM  top_paying_jobs 
      INNER JOIN skills_job_dim ON 
      top_paying_jobs.job_id = skills_job_dim.job_id 
      INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY salary_year_avg DESC

LIMIT 100



