# E-Commerce Customer Funnel & Revenue Analysis

**SQL Server | Power BI | DAX | Power Query**

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Business Problem](#2-business-problem)
3. [Project Objectives](#3-project-objectives)
4. [Tools and Technologies](#4-tools-and-technologies)
5. [Project Workflow](#5-project-workflow)
6. [Project Folder Structure](#6-project-folder-structure)
7. [Dataset Overview](#7-dataset-overview)
8. [Data Quality Validation](#8-data-quality-validation)
9. [SQL Analysis](#9-sql-analysis)
10. [Power BI Data Preparation](#10-power-bi-data-preparation)
11. [Power BI Data Model](#11-power-bi-data-model)
12. [DAX Measures and KPI Calculations](#12-dax-measures-and-kpi-calculations)
13. [Dashboard Pages](#13-dashboard-pages)
14. [Key Business Insights](#14-key-business-insights)
15. [Business Recommendations](#15-business-recommendations)
16. [Limitations](#16-limitations)
17. [How to Explore the Project](#17-how-to-explore-the-project)
18. [What I Learned](#18-what-i-learned)

---

## 1. Project Overview

The E-Commerce Customer Funnel & Revenue Analysis project examines customer sessions, purchasing behavior, conversion performance, revenue, and marketing-channel effectiveness using SQL Server and Microsoft Power BI.

The project analyzes 25,000 e-commerce sessions to understand how users interact with the purchasing journey, how frequently sessions result in purchases, how often carts are abandoned, and how performance varies across customer types, devices, marketing channels, product categories, and months.

SQL Server is used for data validation, business analysis, and KPI calculations. Power BI is used to prepare the analytical data, build a dimensional data model, create DAX measures, and develop an interactive dashboard.

The final objective is to translate numerical results into meaningful business insights and practical recommendations.

### Project at a glance

| Item | Details |
|---|---|
| Project name | E-Commerce Customer Funnel & Revenue Analysis |
| Dataset size | 25,000 sessions |
| Database technology | SQL Server |
| Business intelligence tool | Microsoft Power BI |
| Data preparation | Power Query |
| Calculation language | DAX |
| Dashboard pages | 3 |
| Main focus | Conversion, revenue, customer behavior, and cart abandonment |

## 2. Business Problem

An e-commerce business needs to understand whether its website sessions are translating into purchases and which parts of the purchasing journey offer opportunities for improvement.

Total traffic alone does not explain business performance. Customers may visit a website, add products to their carts, and leave without purchasing.

The analysis therefore investigates:

- How many sessions result in purchases?
- How many sessions add products to carts?
- What proportion of cart sessions are abandoned?
- Do new and returning customers convert at different rates?
- How does conversion vary across devices?
- Which marketing channels generate stronger revenue and conversion results?
- Which product categories generate the most revenue?
- How do revenue and conversion change over time?

The business objective is to identify measurable performance gaps and recommend areas for further investigation and optimization.

## 3. Project Objectives

1. Validate the dataset before analysis.
2. Calculate the main e-commerce performance KPIs.
3. Analyze the customer conversion funnel.
4. Measure cart abandonment and cart-to-purchase conversion.
5. Compare new and returning customers.
6. Evaluate performance across mobile, desktop, and tablet.
7. Compare marketing channels using session volume, revenue, and conversion.
8. Analyze product-category performance.
9. Examine monthly revenue and conversion trends.
10. Build an interactive Power BI dashboard.
11. Develop evidence-based business recommendations.

## 4. Tools and Technologies

### SQL Server

SQL Server is the database environment used for querying, validating, aggregating, and analyzing the dataset.

Important SQL concepts used in the analysis include filtering, aggregation, conditional logic, joins, Common Table Expressions (CTEs), subqueries, window functions, and date functions.

### Microsoft Power BI

Power BI transforms analytical results into interactive reports that users can explore through charts, KPI cards, and slicers.

### Power Query

Power Query is the data preparation component inside Power BI. It supports importing data, changing data types, renaming columns, filtering records, and performing other transformations.

### DAX

Data Analysis Expressions (DAX) is the formula language used to calculate measures and analytical KPIs within the Power BI data model.

### Git and GitHub

Git tracks changes to project files. GitHub hosts the repository so the SQL scripts, documentation, screenshots, and dashboard deliverables can be reviewed.

## 5. Project Workflow

The project follows an end-to-end analytical workflow.

### Step 1: Understand the business problem

The first step was to determine what the business needed to understand: customer conversion, cart abandonment, revenue performance, and differences across business segments.

**Why this matters:** Analysis should answer business questions rather than generate charts without a purpose.

### Step 2: Inspect the data

The dataset was examined to understand its columns, record count, identifiers, dates, customer attributes, device information, marketing channels, product categories, funnel status, and revenue fields.

**Why this matters:** The analyst must understand what each row represents before choosing calculations.

### Step 3: Validate data quality

The workflow included checks for missing values, duplicate records, data types, identifiers, and business-rule consistency.

The recorded results included zero null values in the relevant check and zero duplicate records in the relevant check.

**Why this matters:** Incorrect identifiers or inconsistent records can produce inaccurate totals and misleading conclusions.

### Step 4: Perform SQL analysis

SQL queries were used to calculate and validate KPIs and examine customer, device, channel, category, funnel, and time-based performance.

**Why this matters:** SQL makes it possible to aggregate large datasets and answer business questions systematically.

### Step 5: Import data into Power BI

The prepared analytical data was imported into Power BI and checked before modeling.

**Why this matters:** A dashboard depends on the quality and structure of its underlying data.

### Step 6: Build the data model

The model uses a central fact table and supporting dimensions, including `Dim_Date`, `Dim_Product`, and `Dim_Customer`.

**Why this matters:** Relationships allow the report to filter and analyze the fact data consistently.

### Step 7: Create DAX measures

Measures were created for sessions, customers, purchases, cart abandonment, revenue, and conversion rates.

**Why this matters:** Centralized measures provide reusable calculations across multiple visuals.

### Step 8: Build the dashboard

Three report pages were developed:

- Executive Overview
- Funnel & Customer Analysis
- Channel, Product & Time Analysis

**Why this matters:** Each page addresses a different set of business questions.

### Step 9: Validate the results

Power BI KPIs were compared with the validated SQL results. The model and interactive filtering were also checked.

**Why this matters:** A visually attractive dashboard is not reliable if its calculations are incorrect.

### Step 10: Develop recommendations

The final step was to interpret the results, prioritize opportunities, and distinguish observed facts from possible explanations that require further investigation.

## 6. Project Folder Structure

The repository is organized into the following folders:

```text
ecommerce-customer-funnel-analysis/
│
├── README.md
│
├── 01_raw_data/
│   └── Dataset files
│
├── 02_sql/
│   └── SQL analysis scripts
│
├── 03_powerbi/
│   └── Power BI dashboard (.pbix)
│
├── 04_screenshots/
│   ├── Page 1 dashboard
│   ├── Page 2 dashboard
│   ├── Page 3 dashboard
│   └── Data model screenshot
│
└── 05_documentation/
    └── Business insights and recommendations
```

The descriptions above indicate the intended contents. The actual files in each folder should be checked before publishing the repository.

**Dataset note:** Only publish dataset files if their licensing and distribution terms permit public redistribution. Do not publish credentials, connection strings, or confidential information.

## 7. Dataset Overview

The project analyzes 25,000 e-commerce sessions.

The main analytical table is:

`fact_ecommerce`

The fields used in the analysis include:

| Field | Business meaning |
|---|---|
| `customer_id` | Identifier for a customer |
| `product_id` | Identifier for a product |
| `visit_date` | Date associated with a session |
| `device_name` | Device used during the session |
| `user_type_name` | Customer classification, such as new or returning |
| `marketing_channel_name` | Marketing source or channel |
| `product_category_name` | Product category |
| `funnel_stage` | Recorded funnel-stage classification |
| `purchase_status` | Purchase-related status |
| `cart_status` | Cart-related status |
| `revenue` | Revenue value used in the analysis |

These descriptions explain the intended analytical role of the fields. The precise definitions should be confirmed against the original dataset and SQL logic.

### Grain of the data

The project uses session-level analysis. A session represents a visit or interaction period, not necessarily a unique customer or a distinct order.

One customer may generate multiple sessions. Therefore, sessions, customers, and purchase transactions must not be treated as interchangeable quantities.

## 8. Data Quality Validation

Data validation helps identify problems that could affect analytical results.

### Missing-value checks

A missing-value check determines whether important fields contain `NULL` values.

For example, a SQL query can count missing customer identifiers:

```sql
SELECT
    COUNT(*) AS MissingCustomerIDs
FROM fact_ecommerce
WHERE customer_id IS NULL;
```

**Line-by-line explanation:**

- `SELECT` starts a query that returns a result.
- `COUNT(*)` counts the records that satisfy the filter.
- `AS MissingCustomerIDs` assigns a readable name to the output column.
- `FROM fact_ecommerce` specifies the table being examined.
- `WHERE customer_id IS NULL` keeps only rows with missing customer identifiers.
- The semicolon terminates the SQL statement.

This is an illustrative example. It should be included in the final code walkthrough only if it matches the actual validation performed.

### Duplicate checks

A duplicate check identifies repeated records or repeated business keys.

However, a repeated customer ID is not necessarily an error because a customer can have multiple sessions.

The correct duplicate definition depends on the dataset grain and the business key being tested.

### Data-type checks

Data types determine how values are stored and interpreted. Dates should be represented as dates, numeric revenue should be numeric, and identifiers should be handled consistently.

### KPI reconciliation

KPI reconciliation compares the results calculated in SQL with the corresponding Power BI measures.

The objective is to confirm that both tools apply compatible definitions, filters, and aggregation rules.

## 9. SQL Analysis

SQL Server was used to answer business questions through queries and aggregations.

### 9.1 SELECT

`SELECT` specifies the columns or calculated expressions returned by a query.

Example:

```sql
SELECT
    device_name,
    revenue
FROM fact_ecommerce;
```

Explanation:

- `SELECT` starts the output definition.
- `device_name` requests the device column.
- `revenue` requests the revenue column.
- `FROM fact_ecommerce` specifies the source table.
- The semicolon ends the query.

This query returns the selected fields for the records in the table.

### 9.2 WHERE

`WHERE` filters records before the query produces its result.

Example:

```sql
SELECT *
FROM fact_ecommerce
WHERE purchase_status = 'Purchased';
```

Explanation:

- `SELECT *` requests all columns.
- `FROM fact_ecommerce` specifies the table.
- `WHERE` begins the filter condition.
- `purchase_status = 'Purchased'` retains records whose status matches the specified text.

The exact status values must match the dataset.

### 9.3 GROUP BY

`GROUP BY` combines records into groups so that aggregate calculations can be performed for each group.

Example:

```sql
SELECT
    device_name,
    COUNT(*) AS SessionCount
FROM fact_ecommerce
GROUP BY device_name;
```

Explanation:

- `device_name` identifies each group.
- `COUNT(*)` counts records in each group.
- `AS SessionCount` names the calculated output.
- `GROUP BY device_name` produces one result for each device value.

This can help compare session volumes across devices, provided each row represents one session.

### 9.4 Aggregate functions

Common aggregate functions include:

- `COUNT()` — counts records or non-null values, depending on the expression.
- `SUM()` — adds numeric values.
- `AVG()` — calculates an arithmetic average.
- `MIN()` — returns the minimum value.
- `MAX()` — returns the maximum value.

The choice of aggregate function depends on the business question and the data grain.

### 9.5 CASE

`CASE` evaluates conditions and returns a corresponding result.

It is useful for creating conditional classifications or calculations.

### 9.6 JOIN

A `JOIN` combines rows from two or more tables using a matching condition.

For example, a join can connect a fact table to a customer or product table when the identifiers and table relationships support the join.

The join type matters:

- `INNER JOIN` returns matching records.
- `LEFT JOIN` retains all records from the left table and matching records from the right table.

Incorrect joins can multiply rows and inflate revenue, so join keys and table grain must be checked.

### 9.7 Common Table Expressions

A Common Table Expression (CTE) is a named query result defined with `WITH`. It can make a complex query easier to organize into logical stages.

### 9.8 Subqueries

A subquery is a query nested inside another SQL statement. It can be used to filter results, calculate intermediate values, or compare a value with an aggregate.

### 9.9 Window functions

Window functions calculate results across a set of related rows while retaining individual rows in the output.

Examples include `ROW_NUMBER()`, `RANK()`, and aggregate functions used with an `OVER()` clause.

### 9.10 Date functions

Date functions extract or calculate information from dates. They can support month-level reporting, date filtering, and time-based comparisons.

The examples in this section explain the SQL concepts used in analytical workflows. They are not a substitute for documenting the exact SQL statements in the repository's actual scripts.

## 10. Power BI Data Preparation

Power BI was used to import and prepare the analytical data.

Power Query supports data preparation operations such as:

- Checking column names and data types.
- Converting date fields into date data types.
- Converting revenue to an appropriate numeric type.
- Removing unnecessary columns when appropriate.
- Filtering or transforming data when justified by the requirements.

A transformation should not be performed merely because it is available. It should have a clear analytical purpose.

For example, converting a text-formatted date into a date data type allows Power BI to use date-aware filtering and time-based analysis.

The exact sequence of Power Query transformations should be documented from the actual Power Query steps used in the project.

## 11. Power BI Data Model

The project uses a central fact table with supporting dimension tables.

### Main tables

| Table | Purpose |
|---|---|
| `fact_ecommerce` | Stores the main session-level analytical records |
| `Dim_Date` | Provides date attributes for time-based analysis |
| `Dim_Product` | Provides product identifiers for product-related analysis |
| `Dim_Customer` | Provides customer identifiers for customer-related analysis |
| `Measures` | Organizes DAX measures for easier management |

### Relationships

The intended relationship pattern is:

```text
Dim_Date ──────────┐
                   │
Dim_Product ───────┼──── fact_ecommerce
                   │
Dim_Customer ──────┘
```

The dimension tables filter the fact table through active one-to-many relationships with single-direction filtering.

A one-to-many relationship means that the dimension side has one row per relationship key, while the fact side can contain multiple rows for that key.

### Why a date table matters

A dedicated date table supports consistent date filtering, chronological month sorting, and time-based reporting.

The `Dim_Date` table was marked as the model's date table. Its date column should contain valid, unique dates and cover the required reporting period.

### Important modeling limitation

The product dimension was constructed using unique product identifiers because the original data showed repeated product IDs when category attributes were considered.

A product identifier should not be assumed to determine one category unless the underlying data supports that relationship. The model should not arbitrarily assign conflicting categories to products.

## 12. DAX Measures and KPI Calculations

DAX is the formula language used in Power BI to create calculated measures.

Measures respond to the current filter context, which means the same measure can return different results when a user selects a month, device, or customer type.

The following formulas explain the project's KPI logic. Confirm the actual measure names and definitions in the Power BI model before treating these examples as the exact implementation.

### 12.1 Total Sessions

Conceptually, total sessions count the sessions included in the current filter context.

If every row represents exactly one session:

```dax
Total Sessions =
COUNTROWS(fact_ecommerce)
```

Explanation:

- `Total Sessions` is the measure name.
- `=` begins the formula.
- `COUNTROWS()` counts rows in a table.
- `fact_ecommerce` is the table being counted.

This formula is valid only when one row corresponds to one session. If rows are repeated per session, a distinct session identifier may be required instead.

### 12.2 Unique Customers

The purpose of this measure is to count distinct customer identifiers.

A common implementation is:

```dax
Unique Customers =
DISTINCTCOUNT(fact_ecommerce[customer_id])
```

Explanation:

- `Unique Customers` is the measure name.
- `DISTINCTCOUNT()` counts different values rather than every occurrence.
- `fact_ecommerce[customer_id]` specifies the column being counted.

A customer who appears in multiple sessions is counted once within the current filter context.

### 12.3 Add-to-Cart Rate

The business definition is:

Add-to-Cart Rate = Add-to-Cart Sessions ÷ Total Sessions × 100

Using the project's measure names, the calculation can be represented as:

```dax
Add to Cart Rate =
DIVIDE(
    [Add to Cart Sessions],
    [Total Sessions],
    0
)
```

Explanation:

- `DIVIDE()` performs division safely.
- `[Add to Cart Sessions]` refers to an existing measure.
- `[Total Sessions]` refers to another existing measure.
- `0` is the alternate result if the denominator is zero.

The measure returns a decimal ratio. Formatting it as a percentage makes a result of `0.64468` display as approximately `64.47%`.

### 12.4 Conversion Rate

The business definition is:

Conversion Rate = Purchased Sessions ÷ Total Sessions × 100

A common implementation is:

```dax
Conversion Rate =
DIVIDE(
    [Purchased Sessions],
    [Total Sessions],
    0
)
```

This calculates the ratio of purchased sessions to total sessions within the current filter context.

### 12.5 Cart Abandonment Rate

The business definition is:

Cart Abandonment Rate = Abandoned Cart Sessions ÷ Add-to-Cart Sessions × 100

A common implementation is:

```dax
Cart Abandonment Rate =
DIVIDE(
    [Abandoned Sessions],
    [Add to Cart Sessions],
    0
)
```

The numerator and denominator must follow compatible definitions of cart sessions. The measure should not mix distinct customers, total sessions, and cart events without a clear business definition.

### 12.6 Cart-to-Purchase Rate

The business definition is:

Cart-to-Purchase Rate = Purchased Sessions ÷ Add-to-Cart Sessions × 100

A common implementation is:

```dax
Cart to Purchase Rate =
DIVIDE(
    [Purchased Sessions],
    [Add to Cart Sessions],
    0
)
```

This measures the proportion of add-to-cart sessions that resulted in purchase.

### 12.7 Total Revenue

The business definition is the sum of the revenue values included in the current filter context.

A common implementation is:

```dax
Total Revenue =
SUM(fact_ecommerce[revenue])
```

Explanation:

- `Total Revenue` is the measure name.
- `SUM()` adds numeric values.
- `fact_ecommerce[revenue]` specifies the revenue column.

This calculation is valid only if the revenue column and table grain are defined so that each revenue amount is counted once.

### Why DAX measures matter

Measures are reusable. A single conversion-rate measure can be used in a KPI card, a monthly trend chart, or a device comparison chart.

Power BI recalculates the measure as the filter context changes.

## 13. Dashboard Pages

The Power BI report contains three analytical pages.

### Page 1 — Executive Overview

Purpose: provide a high-level summary of business performance.

The page presents KPIs and visualizations covering revenue, sessions, customers, conversion, monthly trends, and category performance.

Business question: **How is the e-commerce business performing overall?**

### Page 2 — Funnel & Customer Analysis

Purpose: examine customer conversion behavior and cart outcomes.

The page includes session and purchase KPIs, a conversion funnel, cart outcomes, conversion by customer type, device analysis, and cart abandonment analysis.

Business question: **Where does conversion leakage occur, and which customer groups should be investigated?**

### Page 3 — Channel, Product & Time Analysis

Purpose: compare performance across marketing channels, product categories, and time periods.

Business question: **Which segments show the strongest performance, and where are there opportunities for further investigation?**

### Interactive features

The report uses slicers and visual interactions to allow users to examine selected segments instead of viewing only overall totals.

All interactive results should be validated against the underlying measure definitions.

## 14. Key Business Insights

The following are the recorded results from the analysis.

### Insight 1: Cart abandonment

- Add-to-cart sessions: 16,117
- Purchased sessions: 5,616
- Abandoned sessions: 10,501
- Cart abandonment rate: 65.15%
- Cart-to-purchase rate: 34.85%

The results identify cart abandonment as a major conversion opportunity.

### Insight 2: Customer type

- Returning customer conversion: 25.65%
- New customer conversion: 18.55%
- Difference: 7.10 percentage points

Returning customers have a higher observed conversion rate than new customers.

### Insight 3: Device performance

- Mobile sessions: 12,600
- Desktop sessions: 9,887
- Tablet sessions: 2,513
- Mobile conversion: 22.32%
- Desktop conversion: 22.46%
- Tablet conversion: 23.20%

Mobile represents 50.4% of sessions. However, the observed conversion rates are relatively similar across devices.

### Insight 4: Marketing channels

Referral recorded the highest observed channel conversion rate at 23.60%, while Display Advertising recorded the lowest at 21.66%.

The recorded revenue was approximately ₹182K for Referral and ₹160K for Display Advertising.

These results compare performance, not profitability. Advertising costs are needed to evaluate return on advertising spend.

### Insight 5: Product categories

Beauty & Personal Care recorded approximately ₹1.29M in revenue and a 20.76% conversion rate.

Books & Media recorded the highest observed category conversion rate at 24.68%.

This illustrates the difference between revenue scale and conversion efficiency.

### Insight 6: Monthly performance

January recorded approximately ₹904.6K in revenue, while November recorded approximately ₹771.5K.

September recorded the highest observed conversion rate at 23.42%, while May recorded the lowest at 21.07%.

The highest-revenue month and highest-conversion month were different.

## 15. Business Recommendations

### Priority 1: Investigate cart abandonment

Examine checkout-step behavior, payment failures, additional costs, and other potential barriers.

The current data identifies abandonment but does not establish its cause.

### Priority 2: Improve new-customer conversion

Investigate the first-time visitor journey, product information, and other potential barriers to purchasing.

Test proposed changes before assuming they will improve conversion.

### Priority 3: Investigate high-revenue categories

Examine why Beauty & Personal Care has substantial revenue but comparatively low conversion. Evaluate product mix, traffic quality, pricing, and other available evidence before choosing an intervention.

### Priority 4: Investigate marketing-channel differences

Study the characteristics of referral traffic and review Display Advertising performance. Consider acquisition costs before making budget-allocation decisions.

### Priority 5: Investigate monthly variation

Compare sessions, conversion, channel mix, and category mix between strong and weak months.

Do not attribute monthly changes to promotions or other external events without supporting data.

### Priority 6: Test device-specific improvements

Mobile represents the largest session segment, but its conversion rate is similar to desktop. Use targeted tests to identify measurable opportunities rather than assuming mobile has a major performance problem.

## 16. Limitations

1. **Causality:** The available data identifies performance patterns but does not establish why customers behave in a particular way.
2. **Cart abandonment:** Checkout-level information is needed to determine the specific reasons for abandonment.
3. **Marketing profitability:** Advertising spend and acquisition costs are not available, so return on advertising spend cannot be established.
4. **Customer lifetime value:** Sufficient longitudinal purchase history may be required for a reliable lifetime-value analysis.
5. **Data grain:** Session counts, customer counts, and transaction counts represent different business concepts and must not be substituted for one another.
6. **Product categories:** Conflicting product-to-category assignments require investigation before product-level category conclusions are treated as definitive.
7. **Recommendations:** Proposed actions require further analysis or controlled experiments before their business impact can be established.

## 17. How to Explore the Project

### Step 1: Read the documentation

Start with this README to understand the business problem, workflow, KPIs, and findings.

### Step 2: Review the SQL scripts

Open the files in `02_sql/` and examine the validation queries and business analysis.

The actual scripts should be documented individually with their purpose, inputs, outputs, and line-by-line explanations.

### Step 3: Open the Power BI dashboard

Open the `.pbix` file in `03_powerbi/` using Power BI Desktop.

Explore the three report pages and test the slicers.

### Step 4: Review the data model

Open Model view to inspect the relationships between the fact table and the supporting dimensions.

### Step 5: Review the business recommendations

Read the supporting documentation in `05_documentation/` to understand the findings and proposed next steps.

## 18. What I Learned

This project demonstrates an end-to-end analytical workflow:

- Translating business questions into measurable KPIs.
- Validating data before drawing conclusions.
- Using SQL to aggregate and analyze structured data.
- Understanding the difference between session-level and customer-level metrics.
- Building a dimensional model in Power BI.
- Creating reusable DAX measures.
- Designing interactive reports.
- Reconciling results across analytical tools.
- Distinguishing observed patterns from unproven causes.
- Communicating findings through business insights and recommendations.

The central lesson is that effective data analysis involves more than writing queries or creating charts. The calculations must be accurate, the definitions must be consistent, and the conclusions must be supported by evidence.
