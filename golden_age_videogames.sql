-- Create DB
DROP TABLE game_sales;

CREATE TABLE game_sales (
  game VARCHAR(100) PRIMARY KEY,
  platform VARCHAR(64),
  publisher VARCHAR(64),
  developer VARCHAR(64),
  games_sold NUMERIC(5, 2),
  year INT
);

DROP TABLE reviews;

CREATE TABLE reviews (
    game VARCHAR(100) PRIMARY KEY,
    critic_score NUMERIC(4, 2),   
    user_score NUMERIC(4, 2)
);

DROP TABLE top_critic_years;

CREATE TABLE top_critic_years (
    year INT PRIMARY KEY,
    avg_critic_score NUMERIC(4, 2)  
);

DROP TABLE top_critic_years_more_than_four_games;

CREATE TABLE top_critic_years_more_than_four_games (
    year INT PRIMARY KEY,
    num_games INT,
    avg_critic_score NUMERIC(4, 2)  
);

DROP TABLE top_user_years_more_than_four_games;

CREATE TABLE top_user_years_more_than_four_games (
    year INT PRIMARY KEY,
    num_games INT,
    avg_user_score NUMERIC(4, 2)  
);

\copy game_sales FROM 'game_sales.csv' DELIMITER ',' CSV HEADER;
\copy reviews FROM 'game_reviews.csv' DELIMITER ',' CSV HEADER;
\copy top_critic_years FROM 'top_critic_scores.csv' DELIMITER ',' CSV HEADER;
\copy top_critic_years_more_than_four_games FROM 'top_critic_scores_more_than_four_games.csv' DELIMITER ',' CSV HEADER;
\copy top_user_years_more_than_four_games FROM 'top_user_scores_more_than_four_games.csv' DELIMITER ',' CSV HEADER;


-- Select all information for the top ten best-selling games
-- Order the results from best-selling game down to tenth best-selling
SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10;


-- Join games_sales and reviews
-- Select a count of the number of games where both critic_score and user_score are null
SELECT COUNT(gs.game)
FROM game_sales AS gs
LEFT JOIN reviews AS r
    ON gs.game = r.game
WHERE r.critic_score IS NULL 
    AND r.user_score IS NULL;


-- Select release year and average critic score for each year, rounded and aliased
-- Join the game_sales and reviews tables
-- Group by release year
-- Order the data from highest to lowest avg_critic_score and limit to 10 results
SELECT 
    gs.year, 
    ROUND(AVG(r.critic_score), 2) AS avg_critic_score
FROM game_sales AS gs
LEFT JOIN reviews AS r
    ON gs.game = r.game
GROUP BY gs.year
ORDER BY avg_critic_score DESC
LIMIT 10;


-- Select the year and avg_critic_score for those years that dropped off the list of critic favorites 
-- Order the results from highest to lowest avg_critic_score
SELECT 
    year, 
    avg_critic_score
FROM top_critic_years
EXCEPT
SELECT 
    year, 
    avg_critic_score
FROM top_critic_years_more_than_four_games
ORDER BY avg_critic_score DESC;


-- Select year, an average of user_score, and a count of games released in a given year, aliased and rounded
-- Include only years with more than four reviewed games; group data by year
-- Order data by avg_user_score, and limit to ten results
SELECT 
    gs.year, 
    COUNT(r.game) AS num_games, 
    ROUND(AVG(r.user_score), 2) AS avg_user_score
FROM game_sales AS gs
LEFT JOIN reviews AS r
    ON gs.game = r.game
GROUP BY gs.year
HAVING COUNT(gs.game) > 4
ORDER BY avg_user_score DESC
LIMIT 10;


-- Select the year results that appear on both tables
SELECT year
FROM top_critic_years_more_than_four_games
INTERSECT
SELECT year
FROM top_user_years_more_than_four_games


-- Select year and sum of games_sold, aliased as total_games_sold; order results by total_games_sold descending
-- Filter game_sales based on whether each year is in the list returned in the previous task
SELECT year, SUM(games_sold) AS total_games_sold
FROM game_sales
WHERE year IN (SELECT year
    FROM top_critic_years_more_than_four_games
    INTERSECT
    SELECT year
    FROM top_user_years_more_than_four_games)
GROUP BY year
ORDER BY total_games_sold DESC;


-- Retrieve the top 3 publishers with the highest average critic score for their games.
SELECT 
    publisher, 
    AVG(critic_score) AS avg_critic_score FROM game_sales 
JOIN reviews 
    ON game_sales.game = reviews.game 
GROUP BY publisher 
ORDER BY avg_critic_score DESC 
LIMIT 3;


-- List Games and Platforms with User Score Greater than Their Platform's Average.
SELECT gs.game, gs.platform 
FROM game_sales gs
JOIN reviews r 
    ON gs.game = r.game
WHERE r.user_score > (
    SELECT AVG(user_score) 
    FROM reviews 
    WHERE game IN (
        SELECT game 
        FROM game_sales 
        WHERE platform = gs.platform
    )
);


-- Find Year with Highest Average Total Sales.
SELECT 
    year, 
    AVG(games_sold) AS avg_sales 
FROM game_sales 
GROUP BY year 
ORDER BY avg_sales DESC 
LIMIT 1;


-- Game with Highest Critic Score Not Developed by 'Nintendo'.
SELECT game 
FROM reviews 
WHERE game NOT IN (
    SELECT game 
    FROM game_sales 
    WHERE developer = 'Nintendo'
) 
ORDER BY critic_score DESC 
LIMIT 1;


--Difference in Average User Scores Before and After 2000.
SELECT 
    (SELECT AVG(user_score) 
     FROM reviews 
     WHERE game IN (
         SELECT game 
         FROM game_sales 
         WHERE year >= 2000
     )
    ) - 
    (SELECT AVG(user_score) 
     FROM reviews 
     WHERE game IN (
         SELECT game 
         FROM game_sales 
         WHERE year < 2000
     )
    ) AS score_difference;

-- Publishers with Releases Every Year Since 2010.
SELECT publisher 
FROM game_sales 
WHERE year >= 2010 
GROUP BY publisher 
HAVING COUNT(DISTINCT year) = (
    SELECT COUNT(DISTINCT year) 
    FROM game_sales 
    WHERE year >= 2010
);


-- Average Sales for Games with Critic Score Above 8.
SELECT AVG(games_sold) 
FROM game_sales 
WHERE game IN (
    SELECT game 
    FROM reviews 
    WHERE critic_score > 8
);

-- Platform with Largest Difference in Average Critic and User Scores.
SELECT 
    gs.platform, 
    ABS(AVG(r.critic_score) - AVG(r.user_score)) AS score_difference
FROM game_sales gs
JOIN reviews r 
    ON gs.game = r.game
GROUP BY gs.platform
ORDER BY score_difference DESC
LIMIT 1;


-- Games with Higher User Score Than Any Game Released in the Same Year.
SELECT r.game, r.user_score 
FROM reviews r
WHERE r.user_score > ALL (
    SELECT user_score 
    FROM reviews 
    WHERE game IN (
        SELECT game 
        FROM game_sales 
        WHERE year = (
            SELECT year 
            FROM game_sales 
            WHERE game = r.game
        )
    )
);


-- Developer with Highest Average User Score Across All Games.
SELECT 
    developer, 
    AVG(user_score) AS avg_user_score 
FROM game_sales gs
JOIN reviews r 
    ON gs.game = r.game
GROUP BY developer
ORDER BY avg_user_score DESC
LIMIT 1;


-- This query identifies top-selling video games that are also highly rated by both critics and users.
-- It uses Common Table Expressions (CTEs) to first isolate games with high critic and user scores,
-- and then identifies the top-selling games. Finally, it combines these insights to find games 
-- that are both commercially successful and critically acclaimed.
WITH CriticFavoredGames AS (
    SELECT 
        r.game, 
        AVG(r.critic_score) AS avg_critic_score
    FROM reviews r
    WHERE r.critic_score IS NOT NULL
    GROUP BY r.game
    HAVING AVG(r.critic_score) > 8
),
UserFavoredGames AS (
    SELECT 
        r.game, 
        AVG(r.user_score) AS avg_user_score
    FROM reviews r
    WHERE r.user_score IS NOT NULL
    GROUP BY r.game
    HAVING AVG(r.user_score) > 8
),
TopSellingGames AS (
    SELECT 
        gs.game, 
        SUM(gs.games_sold) AS total_sales
    FROM game_sales gs
    GROUP BY gs.game
    ORDER BY total_sales DESC
    LIMIT 100
)
SELECT 
    t.game, 
    t.total_sales, 
    c.avg_critic_score, 
    u.avg_user_score
FROM TopSellingGames t
JOIN CriticFavoredGames c ON t.game = c.game
JOIN UserFavoredGames u ON t.game = u.game
ORDER BY t.total_sales DESC, c.avg_critic_score DESC, u.avg_user_score DESC;
