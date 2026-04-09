# PlatinumRx Data Analyst Assignment

## Overview
This repo has my solutions for all three phases of the assignment — SQL, Spreadsheets, and Python.

---

## Phase 1: SQL

Two separate scenarios — Hotel and Clinic management systems.

### Hotel System
- Created tables: `users`, `bookings`, `items`, `booking_commercials`
- Used `JOIN`, `GROUP BY`, `HAVING`, and window functions (`RANK`, `DENSE_RANK`) for the queries
- For Q4 and Q5, used CTEs with window functions to rank items/bills per month

### Clinic System
- Created tables: `clinics`, `customer`, `clinic_sales`, `expenses`
- Profit is calculated as `revenue - expenses`, aggregated separately and then joined
- Used `DENSE_RANK` partitioned by city/state for Q4 and Q5

---

## Phase 2: Spreadsheets

File: `Spreadsheets/Ticket_Analysis.xlsx`

Two sheets — `ticket` and `feedbacks`.

### Q1 — Populate ticket_created_at
Used VLOOKUP with `cms_id` as the key to pull `created_at` from the ticket sheet:
