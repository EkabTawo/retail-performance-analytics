-- ============================================================
-- 2. MONTHLY REVENUE
-- ============================================================

CREATE OR REPLACE VIEW retail.dashboard_monthly_revenue AS

WITH monthly_revenue AS (
    SELECT
        invoice_year,
        invoice_month,
        SUM(quantity) AS units_sold,
        COUNT(DISTINCT invoice_no) AS orders,
        SUM(revenue) AS revenue
    FROM retail.transactions_clean
    GROUP BY
        invoice_year,
        invoice_month
),

monthly_with_previous AS (
    SELECT
        invoice_year,
        invoice_month,
        units_sold,
        orders,
        revenue,

        LAG(revenue) OVER (
            ORDER BY invoice_year, invoice_month
        ) AS previous_month_revenue

    FROM monthly_revenue
)

SELECT
    invoice_year,
    invoice_month,

    TO_CHAR(
        MAKE_DATE(invoice_year, invoice_month, 1),
        'Mon YYYY'
    ) AS month_name,

    units_sold,
    orders,

    ROUND(revenue::numeric, 2) AS revenue,

    ROUND(
        (
            revenue
            / NULLIF(orders, 0)
        )::numeric,
        2
    ) AS average_order_value,

    ROUND(
        (
            (
                revenue - previous_month_revenue
            )
            / NULLIF(previous_month_revenue, 0)
            * 100
        )::numeric,
        2
    ) AS month_over_month_growth_pct

FROM monthly_with_previous

ORDER BY
    invoice_year,
    invoice_month;