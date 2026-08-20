# 📊 Sales Performance Analysis – SQL & Power BI Dashboard

> 🚀 **Update (v2.0):** This project has been updated from a single flat-table architecture to an optimized **Star Schema Data Model** in Power BI, implementing best practices in dimensional modeling, data normalization, and relationship management.

---

## 📌 Project Overview

This project analyzes sales performance data to uncover key business insights related to revenue, customers, products, regions, and market segments. The workflow demonstrates an end-to-end data analyst pipeline:

$$\text{Raw Data} \longrightarrow \text{SQL Analysis} \longrightarrow \text{Dimensional Modeling (Power Query)} \longrightarrow \text{Star Schema} \longrightarrow \text{Interactive Dashboard}$$

---

## 🎯 Objectives

* Analyze overall revenue, order volumes, and customer distribution.
* Identify top-performing products, categories, states, and market segments.
* Restructure raw flat data into a normalized, high-performance **Star Schema (Fact & Dimension Tables)**.
* Build an interactive, filterable executive dashboard for data-driven decision-making.

---

## 🛠️ Tools & Technologies

* **Database:** MySQL
* **ETL & Data Modeling:** Power Query (M Language)
* **Visualization & DAX:** Power BI Desktop
* **Data Source:** CSV Sales Dataset (`dataset.csv`)
* **Skills Applied:**
  * SQL (DDL, Aggregations, Grouping, Filtering, Integrity Checks)
  * Data Normalization & Star Schema Design
  * Power Query Transformations (Deduplication, Dimension Extraction)
  * DAX Measures & Dynamic Top-N Filtering
  * Visual Storytelling & Dashboard Design

---

## 🗂️ Dataset & Data Architecture

### Dataset Overview
The source dataset (`dataset.csv`) contains transactional sales records with the following core fields:
* **Order Details:** `Row ID`, `Order ID`, `Order Date`, `Ship Date`, `Ship Mode`
* **Customer Details:** `Customer ID`, `Customer Name`, `Segment`
* **Product Details:** `Product ID`, `Product Name`, `Category`, `Sub-Category`
* **Geographic Details:** `Country`, `City`, `State`, `Postal Code`, `Region`
* **Financial Metrics:** `Sales`

---

### Data Model Evolution

#### Previous Architecture (v1.0)
The initial implementation used a single flat table containing all transactional, customer, product, and regional data within one query.

#### Current Architecture (v2.0 – Star Schema)
The flat table was normalized into a star schema using Power Query to eliminate redundancy, optimize engine memory (VertiPaq), and streamline DAX filter propagation.

```text
       ┌────────────────────────┐
       │      dim_customer      │
       ├────────────────────────┤
       │ PK  Customer ID        │
       │     Customer Name      │
       │     Segment            │
       └───────────┬────────────┘
                   │ 1
                   │
                   │ *
       ┌───────────┴────────────┐            ┌────────────────────────┐
       │      Fact_Orders       │ 1        * │      dim_product       │
       ├────────────────────────┼────────────┤────────────────────────┤
       │     Row ID             │            │ PK  Product ID         │
       │     Order ID           │            │     Product Name       │
       │     Order Date         │            │     Category           │
       │     Ship Date          │            │     Sub-Category       │
       │     Ship Mode          │            └────────────────────────┘
       │ FK  Customer ID        │
       │ FK  Product ID         │
       │ FK  Postal Code        │
       │     Sales              │
       └───────────┬────────────┘
                   │ *
                   │
                   │ 1
       ┌───────────┴────────────┐
       │      dim_location      │
       ├────────────────────────┤
       │ PK  Postal Code        │
       │     City               │
       │     State              │
       │     Region             │
       │     Country            │
       └────────────────────────┘


---


* **`Fact_Orders` (Fact Table):** Contains transactional metrics (`Sales`), dates, and foreign keys (`Customer ID`, `Product ID`, `Postal Code`).
* **`dim_customer` (Dimension Table):** Primary key `Customer ID` containing unique customer profiles and segments.
* **`dim_product` (Dimension Table):** Primary key `Product ID` containing product taxonomy (`Category`, `Sub-Category`, `Product Name`).
* **`dim_location` (Dimension Table):** Primary key `Postal Code` containing geographic hierarchies (`City`, `State`, `Region`, `Country`).
* **Relationships:** $1:*$ (One-to-Many), with Single cross-filter direction flowing from Dimension tables to the Fact table.

---

## 🧹 Data Preparation & SQL Analysis

Initial data exploration, validation, and aggregations were conducted in MySQL (`sales_analysis.sql`):
* Standardized column headers for SQL compatibility.
* Verified dataset completeness, row counts, and uniqueness.
* Handled missing values and verified data types.
* Performed exploratory aggregations:
  * Total sales, distinct order count, and customer count.
  * Sales breakdown by Category, Sub-Category, Segment, Region, State, and Product.

---

## 📊 Power BI Dashboard

An interactive dashboard was built in Power BI (`Dashboard.pbix`) visualizing the core business metrics.

### Dashboard Highlights

* **KPI Cards:**
  * Total Sales
  * Total Orders
  * Total Customers
* **Visual Breakdown:**
  * **Sales by Category & Sub-Category:** Revenue distribution across different lines.
  * **Sales by Segment:** Contribution of Consumer, Corporate, and Home Office segments.
  * **Sales by Region:** Regional revenue share.
  * **Top 10 Products by Sales:** Identification of top revenue-driving products.
  * **Top 3 States by Sales:** Dynamically filtered using Top-N visual configuration.

---

## 📁 Repository Structure

```text
Sales-Performance-Analysis/
├── Dashboard.pbix              # Power BI report file with Star Schema data model
├── dashboard_screenshot.png    # Screenshot preview of the interactive dashboard
├── dataset.csv                 # Raw sales dataset (source data)
├── sales_analysis.sql          # SQL scripts for data exploration & analysis
└── README.md                   # Project documentation


---

## 🔍 Key Insights

* **Category Performance:** Technology is the highest revenue-generating category.
* **Segment Contribution:** The Consumer segment contributes the largest share of total sales.
* **Regional Distribution:** The West region leads in overall sales volume.
* **Top Market:** California is the top-performing state by revenue.
* **Pareto Effect:** A small subset of products accounts for a disproportionate share of total revenue.

---

## ⚠️ Limitations

* The dataset does not include profit, cost, or discount information.
* Time-series trend analysis is limited to the available historical date range.

---

## ✅ Conclusion

This project demonstrates practical competency in end-to-end data analytics: performing exploratory data analysis using SQL, implementing Power Query ETL to normalize raw data into a Star Schema, establishing model relationships, and building an executive-ready Power BI dashboard for business decision-makers.
