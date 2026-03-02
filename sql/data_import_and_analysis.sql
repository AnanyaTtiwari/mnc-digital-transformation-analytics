CREATE TABLE mnc_digital_transformation (
company_name VARCHAR(100),
industry VARCHAR(50),
founded_year INT,
revenue_usd_bn DECIMAL(10,2),
digital_maturity_score INT,
key_technologies VARCHAR(255),
digital_category VARCHAR(20)
);

copy mnc_digital_transformation
FROM 'C:\Users\anany\OneDrive\Attachments\Desktop\Projects\mnc_digital_transformation.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM mnc_digital_transformation

/*Technology and IT-enabled industries show the highest digital maturity, while traditional sectors such as Manufacturing and Energy lag behind.*/

/* Which industries are leading in digital transformation */
SELECT industry, AVG(digital_maturity_score) as avg_digital_maturity FROM mnc_digital_transformation GROUP BY industry ORDER BY avg_digital_maturity DESC;

/*High revenue does not always guarantee high digital maturity. Some mid-revenue companies outperform larger firms digitally. */

/* is higher revenue associated with higher digital maturity */ 
SELECT company_name,revenue_usd_bn,digital_maturity_score FROM mnc_digital_transformation ORDER BY revenue_usd_bn DESC; 

/*A small group of companies consistently scores high, indicating strong investment in cloud, AI, and modern digital platforms.*/

/* TOP 5 most digitally mature company */
SELECT company_name,industry,digital_maturity_score FROM mnc_digital_transformation order by digital_maturity_score DESC LIMIT 5;

/*Most companies fall into the Medium category, with fewer digital leaders and a noticeable group of low-maturity firms.*/

/*How are companies distributed actoss digital maturity */
SELECT digital_category,COUNT(*) AS company_count FROM mnc_digital_transformation GROUP BY digital_category;

/* Technology usage analysis */
SELECT TRIM(tech) AS technology, COUNT(*) AS usage_count FROM mnc_digital_transformation,
UNNEST(STRING_TO_ARRAY(key_technologies, ',')) AS tech GROUP BY technology ORDER BY usage_count DESC;

/* Digital maturity ranking */
SELECT company_name,industry,digital_maturity_score, RANK() OVER (ORDER BY digital_maturity_score DESC) AS digital_rank FROM mnc_digital_transformation;

/* Top comapnies per industry */
SELECT * FROM (SELECT company_name,industry,digital_maturity_score, RANK() OVER (PARTITION BY industry ORDER BY digital_maturity_score DESC) AS top_companies 
FROM mnc_digital_transformation) t WHERE top_companies=1;

/* digital catagory percentage distribution */
SELECT digital_category, COUNT(*) AS comapny_count, ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER (),2) AS percentage_share 
FROM mnc_digital_transformation GROUP BY digital_category;

/* Revenue segmentation */
SELECT company_name, revenue_usd_bn, 
CASE
 WHEN revenue_usd_bn >= 300 THEN 'Very Large'
 WHEN revenue_usd_bn >= 150 THEN 'Large'
 WHEN revenue_usd_bn >= 50 THEN 'Medium'
 ELSE 'Small'
END AS renevue_segment
FROM mnc_digital_transformation;

/* do digital maturity depend on comapny age */

SELECT industry,ROUND(AVG(digital_maturity_score), 2) AS avg_maturity,ROUND(AVG(EXTRACT(YEAR FROM CURRENT_DATE) - founded_year), 0) AS avg_company_age
FROM mnc_digital_transformation GROUP BY industry;

/*Do younger companies adapt better digitally*/
SELECT 
    CASE
        WHEN EXTRACT(YEAR FROM CURRENT_DATE) - founded_year < 20 THEN 'Young'
        WHEN EXTRACT(YEAR FROM CURRENT_DATE) - founded_year BETWEEN 20 AND 50 THEN 'Mid-age'
        ELSE 'Old'
    END AS company_age_group,
    ROUND(AVG(digital_maturity_score), 2) AS avg_maturity
FROM mnc_digital_transformation
GROUP BY company_age_group
ORDER BY avg_maturity DESC;


/* Create SQL views */
CREATE VIEW industry_digital_summary AS
SELECT 
    industry,
    COUNT(*) AS total_companies,
    ROUND(AVG(digital_maturity_score), 2) AS avg_maturity
FROM mnc_digital_transformation
GROUP BY industry;

SELECT * FROM industry_digital_summary;

/* Create sql view for breakdown technologies that are used in comapnaies */

CREATE VIEW tech_usage_summary AS
SELECT
    TRIM(tech) AS technology,
    COUNT(*) AS usage_count
FROM public.mnc_digital_transformation,
     UNNEST(STRING_TO_ARRAY(key_technologies, ',')) AS tech
GROUP BY technology;

SELECT * FROM tech_usage_summary
