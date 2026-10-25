# Amazon India Apparel Sales Analysis

An end-to-end analysis of Amazon India apparel sales (31 Mar to 29 Jun 2022) using **Python**, **PostgreSQL** and **Power BI**. The project cleans raw order data, loads it into a database, answers business questions with SQL, explores it in Python, and presents the results in a 5-page Power BI dashboard.

**Tools:** Python (pandas, seaborn, matplotlib, SQLAlchemy) | PostgreSQL | Power BI (DAX, Power Query) | Git/GitHub

---

## Project Workflow

```
Raw CSV  ->  Python (clean)  ->  PostgreSQL (store + SQL analysis)  ->  Power BI (dashboard)
                  |
                  +->  EDA report (charts + insights)
```

1. **Data acquisition:** unzip the Amazon Sale Report and take a first look at the data.
2. **Data understanding:** check data types, nulls, duplicates, and the quality of each column.
3. **Data cleaning:** fix the issues found, add new columns, and load the clean data into PostgreSQL.
4. **EDA:** explore the data with charts and write up the findings.
5. **SQL analysis:** answer business questions directly from the database.
6. **Dashboard:** build a 5-page Power BI report on top of the PostgreSQL table.

---

## About the Data

| Item | Detail |
|---|---|
| Source | Amazon Sale Report (public e-commerce dataset) |
| Period | 31 Mar 2022 to 29 Jun 2022 |
| Raw size | 128,975 rows, 24 columns |
| Clean size | 128,968 rows, 21 columns |
| Unique orders | 120,378 |

**Each row is one item in an order.** An order with 2 products has 2 rows, so use `COUNT(DISTINCT order_id)` for orders and `COUNT(*)` for items.

---

## Data Cleaning Decisions

| Issue | Decision |
|---|---|
| Repeated Order IDs (8,597) | These are multi-item orders, not duplicates. **Kept them**, and removed only the 7 rows that were fully identical. |
| Unused columns | Dropped `index`, `sku`, `asin`, `ship_postal_code`, `promotion_ids`, `ship_city` and a junk `Unnamed: 22` column |
| Column names | Lowercase with underscores (for example `ship-state` became `ship_state`) |
| Text values | Trimmed spaces and standardised capitalisation |
| State names | Fixed spelling variants (for example Rajshthan, Rj to Rajasthan; Orissa to Odisha; Pb to Punjab) |
| Missing `amount` | Cancelled orders set to 0. About 230 non-cancelled items filled with the average amount of real sales |
| Missing `courier_status` | Filled with `Not Available` (cancelled orders were never shipped) |
| Missing `fulfilled_by` | Filled with `Not Applicable` (Amazon-fulfilled orders are not Easy Ship) |
| Missing `currency` | Filled with `INR` (it is the only currency in the data) |
| `date` | Converted from text (MM-DD-YY) to a real date |
| New columns | `revenue`, `month`, `month_num`, `day_name` |

### How `revenue` is defined

`revenue` is the order amount for every item that was **not cancelled**, and 0 for cancelled items. It includes delivered, in-transit and pending items, and also a small share of returned items (about 1.8% of the amount), so it represents **sales value**, not confirmed delivered revenue. In Power BI it is shown as `Total_sales`.

---

## Key Findings

- **About 1 in 7 items is cancelled.** Of 128,968 items, 60.3% were shipped, 22.3% delivered and **14.2% cancelled**. Only 1.5% were returned.
- **Two categories drive the business.** Set and Kurta make up **77.7%** of all items. Sizes M, L and XL are about 51%.
- **Sales fell every month.** From INR 26.3M in April to 24.0M in May (-8.7%) and 21.4M in June (-10.7%). Sales per day dropped about 15.7% from April to June.
- **Sunday is the best day, Thursday the weakest.** Sunday earns INR 11.0M and Thursday INR 9.5M, about 16% less.
- **Sales are concentrated.** Maharashtra (INR 12.2M, 17.0%) and Karnataka (INR 9.7M, 13.4%) together bring in 30.5% of sales, and the top 10 states bring in 78.7%.
- **Customers buy mid-priced items.** The median item is INR 625, and only about 11% of items cost more than INR 1,000.
- **Cancellation rates are similar across categories** (about 12% to 14.6%), so cancellations look like a business-wide issue, not a single-product problem.

**Suggested next step:** find out why sales are falling (check whether the drop is in Set and Kurta or in specific states) and what drives the cancellations.

---

## Power BI Dashboard

A 5-page report built on a star schema: `FactSales` linked to `DimDate`, `DimProduct`, `DimLocation` and `DimStatus`.

| Page | What it shows |
|---|---|
| Home Page | Navigation |
| Executive Overview | Headline KPIs |
| Order Analysis | Order status, cancelled items, cancellation rate by category, sales by category and state |
| Product Analysis | Average item value, top state, top category, size and style breakdowns |
| Trend Analysis | Total sales, average daily sales, sales by month, by weekday and daily trend |

**Key measures:** `Total_sales`, `Total orders`, `Total order items`, `Cancelled Order Items`, `Cancelled Item Value`, `Item Cancellation Rate`, `Average Item Value`, `Avg Daily Sales`, `Top Category`, `Top State`.

### Dashboard preview

![Order Analysis](Power%20BI/screenshots/order_analysis.png)
![Product Analysis](Power%20BI/screenshots/product_analysis.png)
![Trend Analysis](Power%20BI/screenshots/trend_analysis.png)

---

## SQL Analysis

The SQL files answer business questions on revenue by state and month, cancellations by category, Amazon vs Merchant fulfilment, and the value lost to cancellations.

| File | Purpose |
|---|---|
| `01_database_&_table_creation.sql` | Creates the `amazon_sales` table |
| `02_data_checks.sql` | Checks the load: row count, date range, unique orders, revenue total |
| `03_business_questions.sql` | Business questions with queries and answers |

---

## Repository Structure

```
amazon-india-apparel-sales-analysis/
├── Data/                                  (raw zip and cleaned CSV)
├── Notebooks/
│   ├── 01_Data_Acquisition.ipynb
│   ├── 02_Data_Understanding.ipynb
│   ├── 03_Data_Cleaning.ipynb
│   └── 04_Exploratory_Data_Analysis.ipynb
├── SQL files/
│   ├── 01_database_&_table_creation.sql
│   ├── 02_data_checks.sql
│   └── 03_business_questions.sql
├── Power BI/
│   └── Amazon_India_Apparel_Sales.pbix
└── README.md
```

---

## How to Run

1. Clone the repository.
2. Install the libraries: `pip install pandas numpy seaborn matplotlib sqlalchemy psycopg2-binary`
3. Run `01_Data_Acquisition.ipynb` to unzip the data.
4. Create a PostgreSQL database named `amazon_db`, then run `01_database_&_table_creation.sql` in pgAdmin.
5. Run notebooks 02 and 03. In notebook 03, set your own PostgreSQL username and password in the connection string before the load step.
6. Run `04_Exploratory_Data_Analysis.ipynb` for the EDA report.
7. Open the `.pbix` file in Power BI Desktop and point the PostgreSQL connection to your database.

---

## Limitations

- The data covers only 3 months, so there is no yearly trend or seasonality.
- March has a single day of data, and June ends on the 29th.
- There is no customer ID, so repeat-customer analysis is not possible.
- Many "Shipped" orders had not yet been marked "Delivered" when the data ends, so confirmed delivered revenue cannot be measured exactly.

---

## Author

**Pratik Sonkusale**
GitHub: [pratiksonkusale-ops](https://github.com/pratiksonkusale-ops)
