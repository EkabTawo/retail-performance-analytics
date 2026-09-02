-- ============================================================
-- Retail Performance Analytics
-- PostgreSQL Database Schema
-- ============================================================

CREATE SCHEMA IF NOT EXISTS retail;

DROP TABLE IF EXISTS retail.transactions;

CREATE TABLE retail.transactions (
    transaction_id BIGSERIAL PRIMARY KEY,
    invoice_no VARCHAR(20) NOT NULL,
    stock_code VARCHAR(20) NOT NULL,
    description TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    invoice_date TIMESTAMP NOT NULL,
    unit_price NUMERIC(12, 4) NOT NULL,
    customer_id INTEGER,
    country VARCHAR(100) NOT NULL,
    revenue NUMERIC(14, 3) NOT NULL,
    invoice_year INTEGER NOT NULL,
    invoice_month INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    day_of_week VARCHAR(20) NOT NULL
);

CREATE INDEX idx_transactions_invoice_date
    ON retail.transactions(invoice_date);

CREATE INDEX idx_transactions_customer_id
    ON retail.transactions(customer_id);

CREATE INDEX idx_transactions_stock_code
    ON retail.transactions(stock_code);

CREATE INDEX idx_transactions_country
    ON retail.transactions(country);

CREATE INDEX idx_transactions_invoice_no
    ON retail.transactions(invoice_no);