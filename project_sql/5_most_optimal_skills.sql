/* What are the most optimal skills ?
-So we need to find a mix of most in-demand skills and most high paying skills
-This can be done by combining query 3 & 4
*/



WITH top_paying_skills AS 

      (
        SELECT
                skill_id,  ROUND(avg(salary_year_avg), 0) AS average
        FROM skills_job_dim  LEFT JOIN  job_postings_fact
        ON skills_job_dim.job_id = job_postings_fact.job_id

        
            /*          Remember you can always modify this
            for different roles and locations as per your convenience */

        WHERE  job_work_from_home = TRUE AND job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
      
        GROUP BY skill_id
        
     ),
     
      skillcount AS 

      (
        SELECT skill_id,  count(*) AS demand
        FROM skills_job_dim  LEFT JOIN  job_postings_fact
        ON skills_job_dim.job_id = job_postings_fact.job_id

        
            /*          Remember you can always modify this
            for different roles and locations as per your convenience */

        WHERE  job_work_from_home = TRUE AND job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
      
        GROUP BY skill_id
        
     )

SELECT 

       skillcount.skill_id, skills_dim.skills, skillcount.demand, top_paying_skills.average
       FROM skillcount INNER JOIN top_paying_skills ON 
       skillcount.skill_id = top_paying_skills.skill_id
       INNER JOIN skills_dim ON skillcount.skill_id = skills_dim.skill_id

       where demand > 10 --you can adjust this based on your needs

ORDER BY average DESC, demand DESC
       limit 100



/*
    Popular Data Technologies Dominate High Paying Roles:
     Skills related to big data and cloud technologies such as Hadoop, Snowflake, Azure, and AWS are among the top-paying skills.
      This suggests a high demand for professionals with expertise in managing and analyzing large datasets using cloud-based solutions.

    Data Visualization and Business Intelligence Skills Are Valued: 
     Skills like Tableau, Looker, Power BI, and Qlik, which are related to data visualization and business intelligence, also command high salaries.
      This indicates a growing need for professionals who can interpret complex data and communicate insights effectively through visualization tools.

    Programming Languages Remain Essential:
     Traditional programming languages such as Java, Python, and R continue to be in demand, with Python being particularly prominent due to its widespread use in data science and machine learning. 
     Additionally, SQL skills are highly valued across various industries, highlighting the importance of data querying and manipulation capabilities.
*/
        