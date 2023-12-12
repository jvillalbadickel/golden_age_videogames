# golden_age_videogames
Analysis of the top 400 video games released since 1977

## Description
This project is an analysis of video game sales data. It includes an exploration of various aspects of video game sales, such as top-selling games, trends over the years, and the relationship between sales and review scores. The project aims to provide insights into the gaming industry's market dynamics using data-driven approaches.

These are the summaries of the SQL queries I used in this project:


**1. Top Ten Best-Selling Games:**
- *Extracts all information for the top ten best-selling games.*
- *Orders the results from the best-selling game down to the tenth best-selling.*


**2. Count of Games with Missing Scores:**
- *Joins game_sales and reviews tables.*
- *Counts the number of games where both critic_score and user_score are null.*


**3. Average Critic Score by Year:**
- *Select the release year and average critic score for each year, rounded to two decimal places.*
- *Joins game_sales and reviews tables and groups by release year.*
- *Orders the highest to lowest average critic score data, limited to top 10 results.*


**4. Average Critic Score and Game Count by Year:**
- *Enhances the previous query by adding a count of games released in each year.*
- *Filters to return only years that have more than four reviewed games.*


**5. Comparison of Critic Favorites Over Years:**
- *Selects the year and average critic score for years that dropped off the list of critic favorites.*
- *Orders the results from highest to lowest average critic score.*


These queries showcase my ability to perform complex data extraction, aggregation, and join operations in SQL.
