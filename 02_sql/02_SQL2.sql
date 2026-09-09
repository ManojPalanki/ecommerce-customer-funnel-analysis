USE ecommerce_analysis;
GO

IF OBJECT_ID('dbo.fact_ecommerce', 'U') IS NOT NULL
    DROP TABLE dbo.fact_ecommerce;
GO

SELECT *
INTO dbo.fact_ecommerce
FROM dbo.ecommerce_clean;
GO

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT session_id) AS unique_sessions
FROM dbo.fact_ecommerce;

SELECT TOP 20 *
FROM dbo.fact_ecommerce;

EXEC sp_help 'dbo.fact_ecommerce';

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT session_id) AS unique_sessions,
    MIN(visit_date) AS first_visit,
    MAX(visit_date) AS last_visit
FROM dbo.fact_ecommerce;

SELECT
    session_id,
    COUNT(*) AS row_count
FROM dbo.fact_ecommerce
GROUP BY session_id
HAVING COUNT(*) > 1;

--

USE ecommerce_analysis;
GO

CREATE INDEX IX_fact_ecommerce_visit_date
ON dbo.fact_ecommerce (visit_date);

CREATE INDEX IX_fact_ecommerce_customer_id
ON dbo.fact_ecommerce (customer_id);

CREATE INDEX IX_fact_ecommerce_session_id
ON dbo.fact_ecommerce (session_id);

CREATE INDEX IX_fact_ecommerce_purchased
ON dbo.fact_ecommerce (purchased);

CREATE INDEX IX_fact_ecommerce_marketing_channel
ON dbo.fact_ecommerce (marketing_channel);
GO

EXEC sp_helpindex 'dbo.fact_ecommerce';

USE ecommerce_analysis;
GO

CREATE VIEW dbo.vw_ecommerce_analysis
AS
SELECT
    customer_id,
    session_id,
    visit_date,

    device_name,
    user_type_name,
    marketing_channel_name,
    product_category_name,

    unit_price,
    quantity,
    discount_percent,
    discount_amount,
    revenue,

    pages_viewed,
    time_on_site_sec,

    added_to_cart,
    purchased,
    cart_abandoned,

    rating,
    review_text,

    visit_day,
    visit_month,
    visit_weekday,
    visit_season,

    visit_month_name,
    visit_weekday_name,
    visit_season_name,

    session_duration_bucket,
    location,

    purchase_status,
    cart_status,
    funnel_stage,

    discount_band,
    price_band,
    revenue_status,

    revenue_normalized
FROM dbo.fact_ecommerce;
GO

SELECT TOP 20 *
FROM dbo.vw_ecommerce_analysis;

SELECT COUNT(*) AS total_rows
FROM dbo.vw_ecommerce_analysis;

----------------------------
  --    KPIs
------------------------------
SELECT
    COUNT(*) AS total_sessions,

    COUNT(DISTINCT customer_id) AS unique_customers,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END) AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END) AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END) AS abandoned_sessions,

    SUM(revenue) AS total_revenue
FROM dbo.vw_ecommerce_analysis;

-- Calculate Conversion Metrics
SELECT
    COUNT(*) AS total_sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END) AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END) AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END) AS abandoned_sessions,

    CAST(
        100.0 * SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS add_to_cart_rate,

    CAST(
        100.0 * SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS overall_conversion_rate,

    CAST(
        100.0 * SUM(CASE WHEN purchased = 1 AND added_to_cart = 1 THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),0)
        AS DECIMAL(10,2)
    ) AS cart_to_purchase_rate,

    CAST(
        100.0 * SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),0)
        AS DECIMAL(10,2)
    ) AS cart_abandonment_rate
FROM dbo.vw_ecommerce_analysis;

--Channel Performance Analysis

SELECT
    marketing_channel_name,

    COUNT(*) AS sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    CAST(
        100.0 * SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS add_to_cart_rate,

    CAST(
        100.0 * SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS conversion_rate,

    CAST(
        100.0 * SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        / NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        )
        AS DECIMAL(10,2)
    ) AS cart_abandonment_rate,

    CAST(SUM(revenue) AS DECIMAL(18,2)) AS total_revenue

FROM dbo.vw_ecommerce_analysis

GROUP BY marketing_channel_name

ORDER BY conversion_rate DESC;

-- Device Performance Analysis

SELECT
    device_name,

    COUNT(*) AS sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    CAST(
        100.0 * SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS add_to_cart_rate,

    CAST(
        100.0 * SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS conversion_rate,

    CAST(
        100.0 * SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        / NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        )
        AS DECIMAL(10,2)
    ) AS cart_abandonment_rate,

    CAST(SUM(revenue) AS DECIMAL(18,2)) AS total_revenue

FROM dbo.vw_ecommerce_analysis

GROUP BY device_name

ORDER BY conversion_rate DESC;


-- User Type Analysis

SELECT
    user_type_name,

    COUNT(*) AS sessions,

    COUNT(DISTINCT customer_id) AS unique_customers,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    CAST(
        100.0 * SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS add_to_cart_rate,

    CAST(
        100.0 * SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS conversion_rate,

    CAST(
        100.0 * SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        / NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        )
        AS DECIMAL(10,2)
    ) AS cart_abandonment_rate,

    CAST(SUM(revenue) AS DECIMAL(18,2)) AS total_revenue

FROM dbo.vw_ecommerce_analysis

GROUP BY user_type_name

ORDER BY conversion_rate DESC;


-- Funnel Stage Analysis

SELECT
    funnel_stage,
    COUNT(*) AS sessions,

    CAST(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(10,2)
    ) AS session_share,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    CAST(SUM(revenue) AS DECIMAL(18,2)) AS total_revenue

FROM dbo.vw_ecommerce_analysis

GROUP BY funnel_stage

ORDER BY sessions DESC;

-- Product Category Analysis
SELECT
    product_category_name,

    COUNT(*) AS sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    CAST(
        100.0 *
        SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS add_to_cart_rate,

    CAST(
        100.0 *
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS conversion_rate,

    CAST(
        100.0 *
        SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        / NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        )
        AS DECIMAL(10,2)
    ) AS cart_abandonment_rate,

    CAST(SUM(revenue) AS DECIMAL(18,2)) AS total_revenue

FROM dbo.vw_ecommerce_analysis

GROUP BY product_category_name

ORDER BY conversion_rate DESC;

USE ecommerce_analysis;
GO

-- 9.9.1 Overall funnel consistency
SELECT
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END) AS add_to_cart_sessions,
    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END) AS purchased_sessions,
    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END) AS abandoned_sessions
FROM dbo.fact_ecommerce;


-- 9.9.2 Revenue validation
SELECT
    SUM(revenue) AS total_revenue,
    SUM(CASE WHEN purchased = 1 THEN revenue ELSE 0 END) AS purchased_revenue
FROM dbo.fact_ecommerce;

-- 9.9.3 Check impossible business states
SELECT COUNT(*) AS invalid_rows
FROM dbo.fact_ecommerce
WHERE
    purchased = 1
    AND cart_abandoned = 1;