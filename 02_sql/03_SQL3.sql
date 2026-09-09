-- Overall Funnel Analysis

-- Business Question : At which stage are customers dropping out of the conversion funnel?

SELECT
    funnel_stage,
    COUNT(*) AS sessions,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS session_share,
    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END) AS purchased_sessions,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM dbo.fact_ecommerce
GROUP BY funnel_stage
ORDER BY
    CASE funnel_stage
        WHEN 'Browsing' THEN 1
        WHEN 'Cart' THEN 2
        WHEN 'Purchase' THEN 3
    END;



-- Funnel Conversion Rates
SELECT
    ROUND(
        SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS add_to_cart_rate,

    ROUND(
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS overall_conversion_rate,

    ROUND(
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        NULLIF(SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END), 0),
        2
    ) AS cart_to_purchase_rate,

    ROUND(
        SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        NULLIF(SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END), 0),
        2
    ) AS cart_abandonment_rate
FROM dbo.fact_ecommerce;

--
-- Marketing Channel Analysis
-- Business Question : Which marketing channels generate the strongest conversion, cart performance, and revenue?
SELECT
    marketing_channel_name,
    COUNT(*) AS sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    ROUND(
        SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS add_to_cart_rate,

    ROUND(
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS conversion_rate,

    ROUND(
        SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS cart_abandonment_rate,

    ROUND(SUM(revenue), 2) AS total_revenue

FROM dbo.fact_ecommerce
GROUP BY marketing_channel_name
ORDER BY conversion_rate DESC;

-- 
-- Device Analysis
-- Business Question : Does device type influence customer conversion and cart abandonment?
SELECT
    device_name,
    COUNT(*) AS sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    ROUND(
        SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS add_to_cart_rate,

    ROUND(
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS conversion_rate,

    ROUND(
        SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS cart_abandonment_rate,

    ROUND(SUM(revenue), 2) AS total_revenue

FROM dbo.fact_ecommerce
GROUP BY device_name
ORDER BY conversion_rate DESC;



--
-- Customer Type Analysis
--

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

    ROUND(
        SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS add_to_cart_rate,

    ROUND(
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS conversion_rate,

    ROUND(
        SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS cart_abandonment_rate,

    ROUND(SUM(revenue), 2) AS total_revenue

FROM dbo.fact_ecommerce
GROUP BY user_type_name
ORDER BY conversion_rate DESC;

--
-- Product Category Analysis
-- Business Question : Which product categories perform best and which have conversion/abandonment problems?
SELECT
    product_category_name,
    COUNT(*) AS sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    ROUND(
        SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS add_to_cart_rate,

    ROUND(
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS conversion_rate,

    ROUND(
        SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS cart_abandonment_rate,

    ROUND(SUM(revenue), 2) AS total_revenue

FROM dbo.fact_ecommerce
GROUP BY product_category_name
ORDER BY conversion_rate DESC;

--
-- Time Analysis
--
SELECT
    visit_month_name,
    COUNT(*) AS sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    ROUND(
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS conversion_rate,

    ROUND(
        SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS cart_abandonment_rate,

    ROUND(SUM(revenue), 2) AS total_revenue

FROM dbo.fact_ecommerce
GROUP BY visit_month, visit_month_name
ORDER BY visit_month;

-- Weekday Analysis
SELECT
    visit_weekday_name,
    COUNT(*) AS sessions,

    SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END)
        AS add_to_cart_sessions,

    SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        AS purchased_sessions,

    SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        AS abandoned_sessions,

    ROUND(
        SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS conversion_rate,

    ROUND(
        SUM(CASE WHEN cart_abandoned = 1 THEN 1 ELSE 0 END)
        * 100.0 /
        NULLIF(
            SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS cart_abandonment_rate,

    ROUND(SUM(revenue), 2) AS total_revenue

FROM dbo.fact_ecommerce
GROUP BY visit_weekday, visit_weekday_name
ORDER BY visit_weekday;