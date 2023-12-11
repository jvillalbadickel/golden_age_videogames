# golden_age_videogames
Analysis of the top 400 video games released since 1977

## Description
This project is a comprehensive analysis of video game sales data. It includes exploration and visualization of various aspects of video game sales, such as top-selling games, trends over the years, and the relationship between sales and review scores. The project aims to provide insights into the gaming industry's market dynamics using data-driven approaches.

1. Task: The Ten Best-Selling Video Games
- Description: The task involves identifying the top ten best-selling video games.
- SQL Query: Selects all information for the top ten best-selling games, ordering the results from best-selling game down to the tenth best-selling.


`'SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10;`
