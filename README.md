# Walmart Sales Data Analysis

## Project Overview
This project focuses on the analysis of Walmart sales data using SQL queries. The dataset includes information on sales transactions, customer demographics, and various product lines. The goal is to derive insights and answer key questions about sales patterns, customer behavior, and product performance.

## Table of Contents
- [Dataset](#dataset)
- [SQL Script](#sql-script)
- [Data Wrangling](#data-wrangling)
- [Feature Engineering](#feature-engineering)
- [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
  - [Generic Questions](#generic-questions)
  - [Product-related Questions](#product-related-questions)
  - [Sales-related Questions](#sales-related-questions)
  - [Customer-related Questions](#customer-related-questions)
- [Tableau Visualizations](#tableau-visualizations)
- [Files](#files)
- [How to Run](#how-to-run)
- [Contributing](#contributing)
- [License](#license)

## Dataset
The dataset includes Walmart sales data with details such as invoice ID, branch, city, customer type, gender, product line, unit price, quantity, VAT, total, date, time, payment method, COGS, gross margin percentage, gross income, and rating.

## SQL Script
The SQL script provided creates the 'walmart_sales_data' database and the 'W_sales' table within it. The script includes data cleaning, feature engineering, and various SQL queries to answer specific questions about the dataset.

## Data Wrangling
The data cleaning process involves handling NULL values and missing data. The SQL script removes null cells using the 'NOT NULL' constraint for each column.

## Feature Engineering
Feature engineering is employed to generate additional columns such as 'time_of_day,' 'day_name,' and 'month' to gain insights into sales patterns over time.

## Exploratory Data Analysis (EDA)
EDA is performed to answer a range of questions related to product lines, sales trends, and customer behavior.

### Generic Questions
- How many unique cities does the data have?
- In which city has which branch?

### Questions on Product
- How many unique product lines does the data have?
- What is the most common payment method?
- What is the most selling product line?
- What is the total revenue by month?
- What month had the largest COGS?
- What product line had the largest revenue?
- What is the city with the largest revenue?
- What product line had the largest VAT?
- ...

### Sales-related Questions
- Number of sales made in each time of the day per weekday?
- Which of the customer types brings the most revenue?
- Which city has the largest tax percent/VAT?
- ...

### Customer-related Questions
- How many unique customer types does the data have?
- How many unique payment methods does the data have?
- What is the most common customer type?
- Which customer type buys the most?
- What is the gender of most of the customers?
- What is the gender distribution per branch?
- Which time of the day do customers give most ratings?
- ...

## Tableau Visualizations
The project includes Tableau visualizations for better understanding and presentation of key insights. The visualizations cover customer demographics, revenue breakdown, sales trends over time, and time analysis.

1. Customer Demographics and Revenue Breakdown 
![](https://github.com/Shaik-Thoukheer/Walmart-sales-data/blob/main/Customer%20demographics%20and%20revenue%20breakdown.png)
2. Sales Trends Over Time
![](https://github.com/Shaik-Thoukheer/Walmart-sales-data/blob/main/Sales%20trends%20over%20time.png)
3. Time Analysis
![](https://github.com/Shaik-Thoukheer/Walmart-sales-data/blob/main/Time%20analysis.png)
4. Walmart Sales Dashboard
![](https://github.com/Shaik-Thoukheer/Walmart-sales-data/blob/main/Dashboard%20Walmart%20Sales%20Insights.png)

## Files
- Unclened Excel file ([`Unclened_data.xlsx`](https://github.com/Shaik-Thoukheer/Walmart-sales-data/blob/main/Raw%20WalmartSalesData.csv))
- Cleaned Excel file ([`clened_data.xlsx`](https://github.com/Shaik-Thoukheer/Walmart-sales-data/blob/main/mysql%20Walmart%20Sales%20cleaned%20Data.csv))
- SQL script ([`walmart_sales_script.sql`](https://github.com/Shaik-Thoukheer/Walmart-sales-data/blob/main/walmart%20sales%20Query%20portfolio.sql))
- Tableau visualizations ([`walmart_sales_dashboard.twbx`](https://github.com/Shaik-Thoukheer/Walmart-sales-data/blob/main/walmart%20sales%20insights.twbx))

## How to Run
1. Import the SQL script into a MySQL database.
2. Load the raw data into the created database.
3. Execute the queries in the SQL script to derive insights.
4. Explore Tableau visualizations for a comprehensive view of key patterns.

## Contributing
Contributions are welcome! Feel free to submit issues or pull requests to improve the project.

## License
This project is licensed under the [MIT License](LICENSE).
