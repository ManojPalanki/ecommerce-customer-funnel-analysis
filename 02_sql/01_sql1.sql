CREATE DATABASE ecommerce_analysis;
GO

USE ecommerce_analysis;
GO

CREATE TABLE stg_ecommerce_sessions
(
    customer_id              INT,
    session_id               INT,
    visit_date               DATE,
    device_type              INT,
    user_type                INT,
    marketing_channel        INT,
    product_id               INT,
    product_category         INT,
    unit_price               DECIMAL(10,2),
    quantity                 INT,
    discount_percent         DECIMAL(5,2),
    discount_amount          DECIMAL(10,2),
    revenue                  DECIMAL(12,2),
    pages_viewed             INT,
    time_on_site_sec         INT,
    added_to_cart            INT,
    purchased                INT,
    cart_abandoned           INT,
    rating                   DECIMAL(3,2),
    review_text              INT,
    review_helpful_votes     INT,
    payment_method           INT,
    visit_day                INT,
    visit_month              INT,
    visit_weekday            INT,
    visit_season             INT,
    session_duration_bucket  NVARCHAR(50),
    revenue_normalized       DECIMAL(12,4),
    location                 INT,

    device_name              NVARCHAR(50),
    user_type_name           NVARCHAR(50),
    marketing_channel_name   NVARCHAR(100),
    product_category_name    NVARCHAR(100),
    payment_method_name      NVARCHAR(100),
    visit_month_name         NVARCHAR(20),
    visit_weekday_name       NVARCHAR(20),
    visit_season_name        NVARCHAR(20),

    purchase_status          NVARCHAR(30),
    cart_status              NVARCHAR(30),
    funnel_stage             NVARCHAR(30),
    discount_band            NVARCHAR(30),
    price_band               NVARCHAR(30),
    revenue_status           NVARCHAR(30)
);
GO


SELECT *
FROM stg_ecommerce_sessions;

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'stg_ecommerce_sessions'
ORDER BY ORDINAL_POSITION;


USE ecommerce_analysis;

SELECT COUNT(*) AS total_rows
FROM dbo.ecommerce_clean;

SELECT TOP 10 *
FROM dbo.ecommerce_clean;


USE ecommerce_analysis;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT session_id) AS unique_sessions
FROM dbo.ecommerce_clean;

SELECT
    MIN(visit_date) AS first_visit,
    MAX(visit_date) AS last_visit
FROM dbo.ecommerce_clean;

-- Nulls Check
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS null_session_id,
    SUM(CASE WHEN visit_date IS NULL THEN 1 ELSE 0 END) AS null_visit_date,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS null_revenue,
    SUM(CASE WHEN purchased IS NULL THEN 1 ELSE 0 END) AS null_purchased,
    SUM(CASE WHEN cart_abandoned IS NULL THEN 1 ELSE 0 END) AS null_cart_abandoned
FROM dbo.ecommerce_clean;

-- Duplicate session check
SELECT
    session_id,
    COUNT(*) AS row_count
FROM dbo.ecommerce_clean
GROUP BY session_id
HAVING COUNT(*) > 1;

-- Invalid business values
SELECT 'purchased' AS column_name, purchased AS value, COUNT(*) AS row_count
FROM dbo.ecommerce_clean
GROUP BY purchased

UNION ALL

SELECT 'added_to_cart', added_to_cart, COUNT(*)
FROM dbo.ecommerce_clean
GROUP BY added_to_cart

UNION ALL

SELECT 'cart_abandoned', cart_abandoned, COUNT(*)
FROM dbo.ecommerce_clean
GROUP BY cart_abandoned;


-- Numerical sanity check
SELECT
    MIN(unit_price) AS min_unit_price,
    MAX(unit_price) AS max_unit_price,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    MIN(discount_percent) AS min_discount,
    MAX(discount_percent) AS max_discount,
    MIN(revenue) AS min_revenue,
    MAX(revenue) AS max_revenue
FROM dbo.ecommerce_clean;

-- Check revenue logic
SELECT TOP 20
    unit_price,
    quantity,
    discount_amount,
    revenue,
    revenue_normalized
FROM dbo.ecommerce_clean
ORDER BY revenue DESC;

--
SELECT COUNT(*) AS inconsistent_revenue_rows
FROM dbo.ecommerce_clean
WHERE ABS(
    revenue - ((unit_price * quantity) - discount_amount)
) > 0.01;
--

SELECT TOP 20
    unit_price,
    quantity,
    discount_percent,
    discount_amount,
    revenue,
    (unit_price * quantity) AS gross_amount,
    ((unit_price * quantity) - discount_amount) AS calculated_revenue,
    revenue - ((unit_price * quantity) - discount_amount) AS difference
FROM dbo.ecommerce_clean
WHERE ABS(
    revenue - ((unit_price * quantity) - discount_amount)
) > 0.01
ORDER BY ABS(
    revenue - ((unit_price * quantity) - discount_amount)
) DESC;

--

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE
        WHEN discount_amount = 0 THEN 1
        ELSE 0
    END) AS zero_discount_rows,
    SUM(CASE
        WHEN discount_amount > 0 THEN 1
        ELSE 0
    END) AS discounted_rows
FROM dbo.ecommerce_clean;

---

SELECT
    COUNT(*) AS purchased_rows,
    SUM(CASE
        WHEN ABS(
            revenue - ((unit_price * quantity) - discount_amount)
        ) <= 0.01
        THEN 1 ELSE 0
    END) AS matching_revenue_rows,
    SUM(CASE
        WHEN ABS(
            revenue - ((unit_price * quantity) - discount_amount)
        ) > 0.01
        THEN 1 ELSE 0
    END) AS inconsistent_revenue_rows
FROM dbo.ecommerce_clean
WHERE purchased = 1;

--
SELECT
    purchased,
    COUNT(*) AS rows,
    SUM(revenue) AS total_revenue
FROM dbo.ecommerce_clean
GROUP BY purchased;

--
SELECT TOP 51
    session_id,
    unit_price,
    quantity,
    discount_percent,
    discount_amount,
    revenue,
    (unit_price * quantity) - discount_amount AS calculated_revenue,
    revenue - ((unit_price * quantity) - discount_amount) AS difference
FROM dbo.ecommerce_clean
WHERE purchased = 1
  AND ABS(
      revenue - ((unit_price * quantity) - discount_amount)
  ) > 0.01
ORDER BY ABS(
    revenue - ((unit_price * quantity) - discount_amount)
) DESC;

--

SELECT
    COUNT(*) AS purchased_rows,
    SUM(
        CASE
            WHEN ROUND(revenue, 2) =
                 ROUND((unit_price * quantity) - discount_amount, 2)
            THEN 1
            ELSE 0
        END
    ) AS matching_revenue_rows,
    SUM(
        CASE
            WHEN ROUND(revenue, 2) <>
                 ROUND((unit_price * quantity) - discount_amount, 2)
            THEN 1
            ELSE 0
        END
    ) AS inconsistent_revenue_rows
FROM dbo.ecommerce_clean
WHERE purchased = 1;

--

SELECT
    session_id,
    unit_price,
    quantity,
    discount_percent,
    discount_amount,
    revenue,
    ROUND((unit_price * quantity) - discount_amount, 2) AS calculated_revenue,
    ROUND(
        revenue - ((unit_price * quantity) - discount_amount), 
        2
    ) AS difference
FROM dbo.ecommerce_clean
WHERE purchased = 1
  AND ROUND(revenue, 2) <>
      ROUND((unit_price * quantity) - discount_amount, 2)
ORDER BY ABS(
    revenue - ((unit_price * quantity) - discount_amount)
) DESC;

--
SELECT
    COUNT(*) AS purchased_rows,
    SUM(CASE
        WHEN ROUND(revenue, 2) = ROUND(
            (unit_price * quantity) -
            discount_amount, 2
        ) THEN 1 ELSE 0
    END) AS matching_revenue,
    SUM(CASE
        WHEN ROUND(revenue, 2) <> ROUND(
            (unit_price * quantity) -
            discount_amount, 2
        ) THEN 1 ELSE 0
    END) AS inconsistent_revenue
FROM ecommerce_clean
WHERE purchased = 1;

--  Check funnel consistency

SELECT COUNT(*) AS invalid_funnel_rows
FROM dbo.ecommerce_clean
WHERE purchased = 1
  AND added_to_cart = 0;

SELECT COUNT(*) AS invalid_abandonment_rows
FROM dbo.ecommerce_clean
WHERE cart_abandoned = 1
  AND added_to_cart = 0;


-- Check categorical values

SELECT DISTINCT device_name
FROM dbo.ecommerce_clean
ORDER BY device_name;

SELECT DISTINCT user_type_name
FROM dbo.ecommerce_clean
ORDER BY user_type_name;

SELECT DISTINCT marketing_channel_name
FROM dbo.ecommerce_clean
ORDER BY marketing_channel_name;

SELECT DISTINCT purchase_status
FROM dbo.ecommerce_clean
ORDER BY purchase_status;

SELECT DISTINCT funnel_stage
FROM dbo.ecommerce_clean
ORDER BY funnel_stage;


