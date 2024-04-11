/* QUESTION: What are the top paying remote jobs for a Data Analyst ?

- Top 100 paying jobs for the role of Data Analyst 
- Focusing on remote jobs for this query 
- Showing only jop postings where salary is mentioned

-why? Highlighting the top paying jobs for data analysts, offering insights into employment opportunities

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

            /*          Remember you can always modify this
            for different roles and locations as per your convenience */

WHERE job_title_short LIKE 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL

ORDER BY salary_year_avg DESC

LIMIT 100
