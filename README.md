# 📊 MNC Digital Transformation – Data Analytics Project

## 📌 Overview
This project demonstrates a complete end-to-end data analytics workflow inspired by real-world MNC digital transformation practices. It focuses on generating data using Python, cleaning and transforming it, storing it in a relational database, and finally visualizing insights using Power BI.

---

## 🎯 Project Objectives
- Simulate real-world enterprise data workflows
- Generate and clean data using Python
- Store processed data in a SQL database
- Perform analytical validation using SQL
- Visualize insights through interactive dashboards

---

## 🗂️ Data Generation & Preparation
Business-like datasets are generated using Python to simulate organizational data. Python (Pandas) is used to clean and transform the generated data by handling missing values, removing duplicates, standardizing column names, correcting data types, and ensuring overall data consistency. The final cleaned data is exported into CSV format for further processing.

---

## 🔄 Data Pipeline & Workflow
1. Data generated using Python  
2. Data cleaned and transformed using Pandas  
3. Cleaned data exported as CSV files  
4. CSV files imported into PostgreSQL using SQL COPY commands  
5. Data validated and analyzed in PostgreSQL  
6. PostgreSQL database connected directly to Power BI  
7. Dashboards created for business insights  

---

## 🛠️ Tools & Technologies
- Python (Pandas, NumPy)
- PostgreSQL
- SQL
- Power BI

---

## 📊 Analysis & Insights
SQL-based analysis is performed to generate aggregations, trends, and performance metrics. These insights help in understanding business patterns and supporting data-driven decision-making.

---

## 📁 Repository Structure
```text
├── data/
│   ├── generated_data/
│   └── cleaned_csv/
├── scripts/
│   └── data_generation_and_cleaning.py
├── sql/
│   └── data_import_and_analysis.sql
├── reports/
│   └── MNC_Data_Analytics_Project.pdf
└── README.md
