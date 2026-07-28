CREATE DATABASE
call_center_analysis;
USE call_center_analysis;
SHOW DATABASES;
SHOW CREATE TABLE
cleaned_call_center;
SELECT *FROM cleaned_call_center;
DESCRIBE cleaned_call_center;

#BASIC QUERIES

#FIRST 10 ROWS
SELECT * FROM cleaned_call_center
LIMIT 10;

#Total number of calls
SELECT COUNT(*) AS Total_Calls
FROM cleaned_call_center;

#Show all agents
SELECT DISTINCT Agent
FROM cleaned_call_center;

#Show all departments
SELECT DISTINCT Department
FROM cleaned_call_center;

# Answered calls VS Unanswered calls
SELECT `Answered (Y/N)`,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY `Answered (Y/N)`;

#Number of unanswered calls
SELECT `Answered (Y/N)`,
COUNT(*) AS Unanswered_Calls
FROM cleaned_call_center
WHERE `Answered (Y/N)`= 'N';

# Number of resolved calls
SELECT COUNT(*) AS Resolved_Calls
FROM cleaned_call_center
WHERE `Resolved` = 'Y';

#FOR BOTH RESOLVED AND UNRESOLVED CALLS
SELECT Resolved, 
COUNT(*) AS Total_calls
FROM cleaned_call_center
GROUP BY Resolved;

# Resolution rate
SELECT
COUNT(CASE WHEN Resolved='Y' THEN 1 END)*100.0/COUNT(*)
 AS Resolution_Rate
 FROM cleaned_call_center;
 
 # Average speed of answer
SELECT AVG(`Speed of Answer`) AS Avg_Speed
FROM cleaned_call_center;

#  overall Average satisfaction rating
SELECT AVG(`Satisfaction rating`) AS Avg_Rating
FROM cleaned_call_center;

#INTERMEDIATE QUERIES

# Average satisfaction rating by each department
SELECT Department,
AVG(`Satisfaction rating`) AS Avg_Rating
FROM cleaned_call_center
GROUP BY Department;

# Calls handled by each agent
SELECT Agent,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY Agent
ORDER BY Total_Calls DESC;

# Average rating of each agent
SELECT Agent,
AVG(`Satisfaction Rating`)  AS Avg_Rating
FROM cleaned_call_center
GROUP BY Agent
ORDER BY Avg_Rating DESC;

# Calls Handled each by department
SELECT Department,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY Department
ORDER BY Total_Calls DESC;

# Average talk duration by department
SELECT Department,
SEC_TO_TIME(
AVG(
TIME_TO_SEC(
STR_TO_DATE(REPLACE(AvgTalkDuration,'0 days',''),'%H:%I:%S')
)
)
) AS Avg_Talk_Time
FROM cleaned_call_center
GROUP BY Department;

# Calls by date
SELECT Date,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY Date
ORDER BY Date;



# Agents with highest average rating
SELECT Agent,
ROUND(AVG(`Satisfaction Rating`),2) AS Avg_Rating
FROM cleaned_call_center
GROUP BY Agent
ORDER BY Avg_Rating DESC
LIMIT 1;

# Department-wise resolution rate
SELECT Department,
ROUND(
	COUNT(CASE WHEN Resolved ='Y' THEN 1 END) *100.0 / COUNT(*),2
) AS Resolution_Rate
FROM cleaned_call_center
GROUP BY Department;


# Maximum and minimum talk duration
SELECT
MAX(`AvgTalkDuration`) AS Max_Time,
MIN(`AvgTalkDuration`) AS Min_Time
FROM cleaned_call_center;

# Calls with rating less than 3
SELECT *
FROM cleaned_call_center
WHERE `Satisfaction Rating` < 3;

# Calls answered within 60 seconds
SELECT COUNT(*) AS Calls_Within_60s
FROM cleaned_call_center
WHERE `Speed of Answer` <= 60;

# Overall KPI query
SELECT
COUNT(*) AS Total_Calls,
COUNT(CASE WHEN `Answered (Y/N)`='Y' THEN 1 END) AS Answered,
COUNT(CASE WHEN Resolved='Y' THEN 1 END) AS Resolved,
ROUND(AVG(`Speed of Answer`),2) AS Avg_Speed,
ROUND(AVG(`Satisfaction rating`),2) AS Avg_Rating
FROM cleaned_call_center;
  
  
  #BUSSINESS QUERIES
  
  # Which department receives the most calls?
  SELECT Department,
  COUNT(*) AS Total_Calls
  FROM cleaned_call_center
  GROUP BY Department
  ORDER BY Total_Calls DESC
  LIMIT 1;

# Which agent handled the most calls?
SELECT Agent,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY Agent
ORDER BY Total_Calls DESC
LIMIT 1;

#Top 5 agents bu call handled
SELECT Agent,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY Agent
ORDER BY Total_Calls DESC
LIMIT 5;

#answered vs unanswered calls
SELECT `Answered (Y/N)`,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY `Answered (Y/N)`;

#Which department has the highest customer satisfaction?
SELECT Department,
AVG(`Satisfaction rating`) AS Avg_rating
FROM cleaned_call_center
GROUP BY Department
ORDER BY Avg_rating DESC
LIMIT 1;

#Which day received the highest number of calls?
SELECT Date,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY Date
ORDER BY Total_Calls DESC
LIMIT 1;

#Agent with more than 600 calls
SELECT Agent,
COUNT(*) AS Total_Calls
FROM cleaned_call_center
GROUP BY Agent
HAVING COUNT(*) > 600;


