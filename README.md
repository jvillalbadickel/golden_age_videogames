# golden_age_videogames
Analysis of the top 400 video games released since 1977

## Description
This project is an analysis of video game sales data. It includes an exploration of various aspects of video game sales, such as top-selling games, trends over the years, and the relationship between sales and review scores. The project aims to provide insights into the gaming industry's market dynamics using data-driven approaches.

These are the summaries of the SQL queries I used in this project:

### **1. Top Ten Best-Selling Games:**
- *Extracts all information for the top ten best-selling games.*
- *Orders the results from the best-selling game down to the tenth best-selling.*

### **2. Count of Games with Missing Scores:**
- *Joins game_sales and reviews tables.*
- *Counts the number of games where both critic_score and user_score are null.*

### **3. Average Critic Score by Year:**
- *Selects the release year and average critic score for each year, rounded to two decimal places.*
- *Joins game_sales and reviews tables and groups by release year.*
- *Orders the highest to lowest average critic score data, limited to top 10 results.*

### **4. Average Critic Score and Game Count by Year:**
- *Enhances the previous query by adding a count of games released in each year.*
- *Filters to return only years that have more than four reviewed games.*

### **5. Comparison of Critic Favorites Over Years:**
- *Selects the year and average critic score for years that dropped off the list of critic favorites.*
- *Orders the results from highest to lowest average critic score.*

### **6. Average User Score Difference Before and After 2000:**
- *Calculates the difference in average user scores between games released before and after the year 2000.*
- *Utilizes subqueries to separately compute average user scores for games released in these two periods, then finds the difference.*
- *Provides insight into how user preferences or rating trends might have shifted across these two eras.*

### **7. Publishers with Consistent Releases Since 2010:**
- *Identifies publishers who have consistently released games every year since 2010.*
- *Groups the data by publisher and filters to those with a presence in every year from 2010 onwards.*
- *Useful for understanding which publishers have maintained a steady stream of releases over a significant period.*

### **8. Average Sales for Highly Rated Games:**
- *Calculates the average total sales for games that have a critic score higher than 8.*
- *Joins game_sales and reviews tables to link sales data with critic scores.*
- *Highlights the potential correlation between high critic scores and commercial success.*

### **9. Platform with Largest Score Discrepancy:**
- *Finds the platform with the greatest difference between average critic and user scores.*
- *Computes the absolute difference between these averages for each platform.*
- *Reveals platforms where there may be a significant divergence in critic and user opinions.*

### **10. Highest-Scoring Games in Comparison to Yearly Releases:**
- *Retrieves games that have a higher user score than any other game released in the same year.*
- *Uses a subquery to compare each game's score against the highest score of games released in the same year.*
- *Useful for identifying standout games in terms of user reception for each year.*

### **11. Developer with Highest Average User Score:**
- *Identifies the developer with the highest average user score across all their games.*
- *Aggregates user scores from the reviews table and groups them by developer.*
- *Useful for recognizing developers with consistently high user approval ratings.*

### **12. Yearly Average Sales for Top Critically Acclaimed Games:**
- *Calculates the average yearly sales for games that have received high critic scores.*
- *Joins game_sales and reviews tables, filtering for games with critic scores above a certain threshold.*
- *Provides insights into the sales performance of critically acclaimed games over the years.*

### **13. Comparison of Publisher's Average Scores:**
- *Compares the average critic and user scores for each publisher.*
- *Joins game_sales and reviews tables and calculates the average scores for both categories.*
- *Useful for assessing how different publishers fare in terms of critic and user reception.*

### **14. Games with Critic Scores Higher Than Average:**
- *Lists games whose critic scores are higher than the average critic score for their release year.*
- *Utilizes a subquery to calculate the average critic score for each year and compares individual games against this average.*
- *Highlights games that stood out critically compared to their contemporaries.*

### **15. Most Popular Genres Based on Sales:**
- *Identifies the most popular game genres based on total sales.*
- *Aggregates sales data from the game_sales table, grouping by genre.*
- *Provides a view into which genres are most commercially successful.*


These queries showcase my ability to perform complex data extraction, aggregation, and join operations in SQL.
