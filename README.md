# Cowrywise-DataAnalytics-Assessment
This repository contains my SQL solutions for the Cowrywise Data Analyst Technical Assessment. The assessment covers customer behavior insights, transaction trends, account activity monitoring, and customer lifetime value estimation.


---

## Solutions Overview

### Q1: High-Value Customers with Multiple Products
- **Goal:** Identify users with at least one savings and one investment plan, ordered by total deposits.
- **Approach:** Used subqueries to efficiently count both savings and investment plans and join deposit data.
- **Key Tables:** `users_customuser`, `plans_plan`, `savings_savingsaccount`
- **Optimization:** Replaced multiple joins with subqueries to avoid exploding row combinations.

---

### Q2: Transaction Frequency Analysis
- **Goal:** Group customers into High, Medium, and Low frequency categories based on monthly activity.
- **Approach:** Calculated total transactions and active months per customer using `TIMESTAMPDIFF`, then categorized with a `CASE` expression.
- **Key Tables:** `savings_savingsaccount`

---

### Q3: Account Inactivity Alert
- **Goal:** Flag accounts (savings or investments) with no inflow in the past 365 days.
- **Approach:** Pulled the latest transaction date per account and compared it to the current date using `DATEDIFF`. Combined results using `UNION`.
- **Key Tables:** `savings_savingsaccount`, `plans_plan`

---

### Q4: Customer Lifetime Value (CLV)
- **Goal:** Estimate CLV using tenure, total transactions, and average profit per transaction.
- **Approach:** Calculated average profit as `0.001 * confirmed_amount`, and applied the CLV formula.
- **Key Tables:** `users_customuser`, `savings_savingsaccount`

---

## Challenges Faced
- **Table Schema Interpretation:** Some fields (e.g., `is_a_fund`, `is_regular_savings`) were not in expected tables.
- **Query Performance:** Q1 initially caused timeouts; resolved by switching to subqueries and minimizing joins.
- **Data Normalization:** Needed to handle monetary units (e.g., kobo → naira) and ensure consistent grouping logic.

---

## Tools Used
- **SQL Language:** MySQL
- **Environment:** MySQL Workbench
- **Data Source:** Provided `.sql` file (adashi_assessment.sql)

---

## Thank You

Thank you for the opportunity! I look forward to the next steps in the selection process.

— Henry Okatta
