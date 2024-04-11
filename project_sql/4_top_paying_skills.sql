/* QUEsTION: Top 10 paying skills
-Take average salary associated with each skill
-Focus on salaries with specific values
-Why? It reveals the most financially rewarding skills 
-Use code from previous query
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
        
     )

SELECT 
        skills_dim.skills, top_paying_skills.average

FROM    top_paying_skills
INNER JOIN skills_dim ON skills_dim.skill_id = top_paying_skills.skill_id 
ORDER BY average DESC 

LIMIT 10



/*
    Big Data Technologies in Demand:
     Skills like PySpark, Couchbase, Watson, and Elasticsearch indicate a strong demand for big data expertise, reflecting the need for professionals who can handle large datasets in industries like technology, finance, and healthcare.

    Rise of Data Science and Machine Learning:
     Skills such as PySpark, Watson, DataRobot, and Pandas highlight a growing emphasis on data science and machine learning capabilities. Employers seek professionals skilled in data analysis and predictive modeling to derive insights and make data-driven decisions.

    Importance of Collaboration Tools:
     GitLab and Bitbucket, among the top-paying skills, underscore the significance of version control and collaboration platforms in modern software development. Proficiency in these tools ensures efficient and reliable code collaboration, essential for successful project management.
*/