
# Miller_CO

## Introduction

Millers & Co. is a fashion e-commerce platform that sells both male and female apparel goods from over 30 companies in various nations. As a Business Intelligence Analyst, the task is to analyze and report on the performance of various brands and goods, helping the C-suite better understand the business and identify ways to increase sales.

---

## Repository Contents

This repository contains:
1. **Datasets**: Includes product, sales, customers, and coupon tables used for analysis.
2. **SQL Script**: Queries used to clean, transform, and extract insights from the dataset.
3. **Power BI File (.pbix)**: Visualization dashboard showcasing the insights derived from the analysis.

---

## About the Dataset

The analysis is based on four datasets:
- **Product Table**: Product details such as brand, category, sub-category, and pricing.
- **Sales Table**: Transaction data, including quantities, revenue, and abandoned carts.
- **Customers Table**: Customer demographic data and purchase behaviors.
- **Coupon Table**: Details on coupons and discounts applied.

---

## Business Questions

The analysis addresses the following business questions:

### High-Level Analysis
1. Total quantity sold for all products (including abandoned carts).
2. Total revenue generated (considering discounts and abandoned carts).
3. Total value of coupon codes applied.

### Product Analysis
4. Top 10 brands by revenue, quantity, reviews, and ratings.
5. Percentage of products sold per category.
6. Distribution of product ratings by category.
7. Most popular brand by category.
8. Reviews distribution by category, sub-category, and segment.
9. Sub-category with the highest discounts and average discount offered.
10. Top 3 brands by segment.
11. Segment preferences by category.
12. Brand with the highest revenue by category.
13. Category with the highest original prices.
14. Revenue impact of products with higher size options.
15. Revenue, discount, and ratings by segment (average, minimum, maximum, total).
16. Influence of customer gender distribution on sales results.
17. Impact of size options on ratings and reviews.

---

## Visualizations

The **Power BI Dashboard** provides:
- High-level sales trends and KPIs.
- Brand and category-level insights.
- Customer behavior visualizations.


---

## SQL Queries

All data transformations, aggregations, and calculations were performed using SQL. The script is available in the repository and includes:
- Data cleaning steps.
- Joins between tables.
- Calculations for KPIs and metrics.


---

## How to Use

1. **Clone the repository**:
   ```bash
   git clone https://github.com/dammmie-beep/Miller_CO.git
   ```
2. **Set up the database**:
   - Import the SQL file into your preferred SQL environment to recreate the database schema and tables.
3. **Explore the Power BI dashboard**:
   - Open the `.pbix` file in Power BI Desktop to view and interact with the visualizations.

---

## Final Thoughts

Fashion retailers must monitor key performance indicators (KPIs) to understand what drives revenue, customer satisfaction, and brand popularity. This analysis demonstrates how data-driven insights can inform strategies to boost sales and improve customer experiences.

---

## Future Enhancements

- Extend the Power BI dashboard with time-series forecasting.
- Develop predictive models to identify potential high-performing products.
- Automate reporting workflows for regular updates.

