--General Movie Analysis

--1. Top 10 Highest-Rated Movies
SELECT TOP 10 names, score,genre
FROM idmb
ORDER BY score DESC;

--2. Top 10 Movies with the Highest Revenue
SELECT TOP 10 names, genre, revenue
FROM idmb
ORDER BY revenue DESC;

--3. Distribution of Movies by Genre
SELECT genre, COUNT(*) AS movie_count
FROM idmb
GROUP BY genre
ORDER BY movie_count DESC;

--4. Average Movie Score Across Different Genres
SELECT genre, AVG(score) AS avg_score
FROM idmb
GROUP BY genre
ORDER BY avg_score DESC;

--5. Correlation Between Movie Rating and Budget


SELECT 
    (COUNT(*) * SUM(score * budget) - SUM(score) * SUM(budget)) / 
    (SQRT((COUNT(*) * SUM(score * score) - SUM(score) * SUM(score)) * 
    (COUNT(*) * SUM(budget * budget) - SUM(budget) * SUM(budget)))) 
    AS correlation
FROM idmb
WHERE budget > 0 AND score IS NOT NULL;


--Financial Analysis

--6. Movies with Highest ROI
SELECT TOP 10 names, ((revenue - budget) / budget) AS ROI
FROM idmb
WHERE budget > 0 AND revenue > 0
ORDER BY ROI DESC;

--7. Trend of Budget vs. Revenue Over the Years
SELECT YEAR(date) AS release_year, 
       AVG(budget) AS avg_budget, 
       AVG(revenue) AS avg_revenue
FROM idmb
WHERE budget > 0 AND revenue > 0
GROUP BY YEAR(date)
ORDER BY release_year;

--8. Percentage of Movies That Made a Profit vs. a Loss
SELECT 
    SUM(CASE WHEN revenue > budget THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS profit_percentage,
    SUM(CASE WHEN revenue <= budget THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS loss_percentage
FROM idmb
WHERE budget > 0 AND revenue > 0;


--9. Countries with the Highest-Grossing Movies
SELECT Country, SUM(revenue) AS total_revenue
FROM idmb
WHERE revenue > 0
GROUP BY Country
ORDER BY total_revenue DESC;

--10. Total Revenue Contribution by Each Country
SELECT Country, SUM(revenue) AS total_revenue
FROM idmb
WHERE revenue > 0
GROUP BY Country
ORDER BY total_revenue DESC;


--Time-Based Trends

--11. Number of Movie Releases Over the Years
SELECT YEAR(date) AS release_year, COUNT(*) AS movie_count
FROM idmb
GROUP BY YEAR(date)
ORDER BY movie_count DESC;

--12. Revenue Trends Over the Years
SELECT YEAR(date) AS release_year, SUM(revenue) AS total_revenue
FROM idmb
WHERE revenue > 0
GROUP BY YEAR(date)
ORDER BY total_revenue DESC;

--13. Years with the Highest Number of Blockbuster Movies
SELECT YEAR(date) AS release_year, COUNT(*) AS blockbuster_count
FROM idmb
WHERE revenue > 1000000000  -- Assuming $1B+ revenue as blockbuster
GROUP BY YEAR(date)
ORDER BY blockbuster_count DESC;

--14. Yearly Trend of Movie Budgets and Revenues
SELECT YEAR(date) AS release_year, 
       AVG(budget) AS avg_budget, 
       AVG(revenue) AS avg_revenue
FROM idmb
WHERE budget > 0 AND revenue > 0
GROUP BY YEAR(date)
ORDER BY release_year;

--15. Year with the Highest Average Movie Score
SELECT TOP 1 YEAR(date) AS release_year, AVG(score) AS avg_score
FROM idmb
WHERE score IS NOT NULL
GROUP BY YEAR(date)
ORDER BY avg_score DESC;

--Country-Specific Insights

--16. Country Producing the Highest-Rated Movies on Average
SELECT TOP 1 Country, AVG(score) AS avg_rating
FROM idmb
WHERE score IS NOT NULL
GROUP BY Country
ORDER BY avg_rating DESC;

--17. Most Popular Movie Genres in Different Countries
SELECT Country, genre, COUNT(*) AS genre_count
FROM idmb
GROUP BY Country, genre
ORDER BY Country, genre_count DESC;

--18. Budget Allocation Across Different Countries
SELECT Country, AVG(budget) AS avg_budget
FROM idmb
WHERE budget > 0
GROUP BY Country
ORDER BY avg_budget DESC;

--19. Average Movie Rating for Each Country
SELECT Country, AVG(score) AS avg_score
FROM idmb
WHERE score IS NOT NULL
GROUP BY Country
ORDER BY avg_score DESC;

--20. Country with the Most Movies in the Dataset
SELECT TOP 1 Country, COUNT(*) AS movie_count
FROM idmb
GROUP BY Country
ORDER BY movie_count DESC;