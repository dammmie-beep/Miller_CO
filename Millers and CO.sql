-- 1. What was the total quantity sold for all products? (consider the % of abandoned carts). 
SELECT SUM(quantity * (1 - abandoned / 100)) AS total_quantity_sold
FROM sale;

--correct dicount to discount
ALTER TABLE coupon
RENAME COLUMN "dicount_percent" TO discount_percent

--What is the total generated revenue for all products  (consider the discount %  and abandoned carts).
SELECT SUM((s.quantity * (1-(s.abandoned / 100))) * (p.price * (1-(c.discount_percent / 100)))) AS total_revenue
FROM sale s
JOIN product p ON s.product_id = p.product_id
JOIN coupon c ON s.coupon_code = c.coupon_code;

--3. What was the total value of the coupon codes for all products?
SELECT SUM( c.discount_percent) AS total_coupon_value
FROM coupon c

--4. Identify the top 10 brands by revenue, quantity, review and rating

--top 10 brands by revenue
Select p.brand_name, 
sum((s.quantity * (1 - s.abandoned / 100)) * (p.price * (1 - c.discount_percent / 100))) as total_revenue
from sale s
join product p on s.product_id = p.product_id
join coupon c on s.coupon_code = c.coupon_code
group by p.brand_name
ORDER BY total_revenue DESC
LIMIT 10;

--top 10 brands by quantity
SELECT p.brand_name, 
SUM(s.quantity * (1 - s.abandoned / 100)) AS total_quantity
FROM sale s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.brand_name
ORDER BY total_quantity DESC
LIMIT 10;

-- top 10 brands by review,
SELECT p.brand_name,ROUND(AVG(p.reviews),0) AS average_review
FROM product p
GROUP BY p.brand_name
ORDER BY average_review DESC
LIMIT 10;

-- top 10 brands by ratings,
SELECT p.brand_name,ROUND(AVG(p.ratings),2) AS average_rating
FROM product p
GROUP BY p.brand_name
ORDER BY average_rating DESC
LIMIT 10;

--What is the percentage of products sold per category?

SELECT category,ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM product)),2) AS percentage_sold
FROM product 
GROUP BY category
ORDER BY percentage_sold DESC;

--What is the percentage distribution of product rating by category? What brand is the most popular by category?
--What is the percentage distribution of product rating by category?
SELECT category,ratings,
COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY category) AS percentage_distribution
FROM product
GROUP BY category, ratings
ORDER BY category, ratings;

-- What brand is the most popular by category?
SELECT category, brand_name, COUNT(*) AS popularity
FROM product
GROUP BY category, brand_name
HAVING COUNT(*) = (
    SELECT MAX(popularity)
    FROM (
        SELECT category, brand_name, COUNT(*) AS popularity
        FROM product
        GROUP BY category, brand_name
    ) AS subquery
    WHERE subquery.category = product.category
)
ORDER BY category;

--Find the percentage of reviews by category, sub-category and segment.
SELECT category, sub_category, segment,
       ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()),2) AS percentage_reviews
FROM product
GROUP BY category, sub_category, segment
ORDER BY category, sub_category, segment;

--What sub-category has the highest number of discounts? What is the average discount offered?
SELECT p.sub_category, COUNT(c.discount_percent) AS discount_count, AVG(c.discount_percent) AS average_discount
FROM product p
JOIN sale s ON p.product_id = s.product_id
JOIN coupon c ON s.coupon_code = c.coupon_code
GROUP BY p.sub_category
ORDER BY discount_count DESC
LIMIT 1;

--What are the top 3 popular brands by segment?
SELECT segment, brand_name, COUNT(*) AS popularity
FROM product
GROUP BY segment, brand_name
ORDER BY segment, popularity DESC
LIMIT 3;

--What is the segment preference by category?
SELECT category, segment, COUNT(*) AS preference_count
FROM product
GROUP BY category, segment
ORDER BY preference_count DESC;

--What brand has the highest revenue by category?
SELECT category, brand_name, total_revenue
FROM (
    SELECT category, brand_name, SUM(quantity * (1 - abandoned / 100) * price * (1 - discount_percent / 100)) AS total_revenue,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY SUM(quantity * (1 - abandoned / 100) * price * (1 - discount_percent / 100)) DESC) AS row_num
    FROM product p
    JOIN sale s ON p.product_id = s.product_id
    JOIN coupon c ON s.coupon_code = c.coupon_code
    GROUP BY category, brand_name
) AS revenue_table
WHERE row_num = 1
ORDER BY total_revenue DESC
LIMIT 1;

--Which category has the highest original price
SELECT category, MAX(price) AS highest_original_price
FROM product
GROUP BY category
ORDER BY highest_original_price DESC
LIMIT 1;

--Do products with higher size options generate more revenue?

SELECT size_options, ROUND(AVG(quantity * (1 - abandoned / 100) * price * (1 - discount_percent / 100)),2) AS average_revenue
FROM product p
JOIN sale s ON p.product_id = s.product_id
JOIN coupon c ON s.coupon_code = c.coupon_code
GROUP BY size_options



--What are the average, minimum, maximum and total revenue, discount and ratings by segments? 
--What would you say about your findings and the gender distribution in the customer table?
--(for example; are your results due to more men or women?)

SELECT 
  p.segment,
  AVG(s.quantity * (1 - s.abandoned / 100) * p.price * (1 - c.discount_percent / 100)) AS average_revenue,
  MIN(s.quantity * (1 - s.abandoned / 100) * p.price * (1 - c.discount_percent / 100)) AS minimum_revenue,
  MAX(s.quantity * (1 - s.abandoned / 100) * p.price * (1 - c.discount_percent / 100)) AS maximum_revenue,
  SUM(s.quantity * (1 - s.abandoned / 100) * p.price * (1 - c.discount_percent / 100)) AS total_revenue,
  AVG(c.discount_percent) AS average_discount,
  MIN(c.discount_percent) AS minimum_discount,
  MAX(c.discount_percent) AS maximum_discount,
  AVG(p.ratings) AS average_rating,
  MIN(p.ratings) AS minimum_rating,
  MAX(p.ratings) AS maximum_rating
FROM product p
JOIN sale s ON p.product_id = s.product_id
JOIN coupon c ON s.coupon_code = c.coupon_code
GROUP BY p.segment;

--What would you say about your findings and the gender distribution in the customer table?
SELECT gender, COUNT(*) AS gender_count
FROM customers
GROUP BY gender
ORDER BY gender_count DESC;

--percentage discount
SELECT gender, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers) AS percentage
FROM customers
GROUP BY gender;


--What influence do the size options have on ratings and reviews?
SELECT size_options,
       AVG(ratings) AS average_rating,
       AVG(reviews) AS average_review
FROM product
GROUP BY size_options
ORDER BY average_rating, average_review DESC;






