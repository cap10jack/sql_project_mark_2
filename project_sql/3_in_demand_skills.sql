/* QUESTION: Top 10 In-Demand skills for a Data Analyst seeking Work from home?
-Joining job_posting_fact and skills_job_dim to get the skill_id and count
-Using the conditions based on my choice, you can always modify it to suit your needs
-Joining cte to skills_dim to display skills

*/

WITH skillcount AS 

      (
        SELECT skill_id,  count(*) AS total
        FROM skills_job_dim  LEFT JOIN  job_postings_fact
        ON skills_job_dim.job_id = job_postings_fact.job_id

        
            /*          Remember you can always modify this
            for different roles and locations as per your convenience */

        WHERE  job_work_from_home = TRUE AND job_title_short = 'Data Analyst' 
      
        GROUP BY skill_id
        
     )

SELECT 
        skillcount.skill_id, skills_dim.skills, skillcount.total

FROM    skillcount
INNER JOIN skills_dim ON skills_dim.skill_id = skillcount.skill_id 
ORDER BY total DESC 

LIMIT 10



