DROP TABLE schools;

CREATE TABLE schools
(
    school_name VARCHAR(100) PRIMARY KEY,
    borough VARCHAR(100),
    building_code VARCHAR(10),
    average_math INT,
    average_reading INT,
    average_writing INT,
    percent_tested FLOAT
);

\copy schools FROM 'schools_modified.csv' DELIMITER ',' CSV HEADER;

--Finding missing values : Count the number of schools not reporting the percentage of students tested and the total number of schools in the database.

SELECT COUNT(school_name) - COUNT(percent_tested) AS num_tested_missing , COUNT(*) AS num_schools
FROM schools

--Schools by building code : Find how many unique schools there are based on building code.

SELECT  COUNT(DISTINCT building_code) As num_school_buildings  
FROM schools

--Best schools for math : Filter the database for all schools with math scores of at least 640.

SELECT school_name , average_math
FROM schools
WHERE average_math >= 640
ORDER BY average_math DESC

--Best writing school : Filter the database for the top-performing school, as measured by average writing scores.

SELECT school_name , MAX(average_writing) AS max_writing
FROM schools
GROUP BY school_name
ORDER BY max_writing DESC
LIMIT 1

--Top 10 schools : by calculating the SAT scores.

SELECT school_name , SUM(average_math + average_reading + average_writing) AS average_sat
FROM schools
GROUP BY school_name
ORDER BY average_sat DESC
LIMIT 10

--Ranking boroughs : the SAT performance in New york Cities for instance , by calculateing the number of schools and the average SAT score per borough!  

SELECT borough , COUNT(school_name) As num_schools , SUM(average_math + average_reading + average_writing)/ COUNT(school_name) AS average_borough_sat
FROM schools
GROUP BY borough
ORDER BY average_borough_sat DESC
LIMIT 10
 
--Brooklyn numbers : Find the top five best schools in Brooklyn by math score

SELECT school_name , average_math
FROM schools
WHERE borough = 'Brooklyn'
ORDER BY average_math DESC
LIMIT 5












