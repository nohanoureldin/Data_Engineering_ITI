# Python Analytics Libraries – Data Analysis Project

A data analysis project using Python's core analytics libraries to explore, clean, and visualize a user dataset. The project covers the full data analysis pipeline — from loading raw data to producing visual insights.

---

## Project Structure

```
├── Project.ipynb        # Main Jupyter Notebook with full analysis
├── read.py              # Data reading/loading utilities
└── users.csv            # Raw dataset (208 users, 52 columns)
```

---

## Dataset

The dataset (`users.csv`) contains **208 user records** across **52 columns**, covering:

- **Personal info** – name, age, gender, birth date, blood group
- **Physical attributes** – height, weight, eye color, hair color/type
- **Contact & identity** – email, phone, username, IP, MAC address
- **Location** – address, city, state, country, coordinates
- **Banking** – card number, card type, currency, IBAN
- **Company** – department, job title, company address
- **Crypto** – coin, wallet, network

---

## Analysis Overview

### 1. Data Exploration
- Shape of the dataset (208 rows × 52 columns)
- Column names and data types
- Missing value detection (`maidenName` had 148 missing values)
- Duplicate row check (0 duplicates found)
- Summary statistics for all numeric columns
- Value counts for gender, role, and blood group distributions

### 2. Data Cleaning
- Dropped the `maidenName` column (too many missing values)
- Converted `birthDate` to datetime format
- Note: Data was pre-normalized (nested JSON fields already flattened into columns)

### 3. Analysis & Visualizations

| Question | Visualization |
|---|---|
| Average age of users | Printed statistic |
| Average age by gender | Bar chart |
| Number of users per gender | Count plot |
| Top 10 cities with most users | Horizontal bar chart |
| Height & weight distribution | Histograms with KDE |
| Relationship between age and height/weight | Regression plots |

---

## Libraries Used

| Library | Purpose |
|---|---|
| `pandas` | Data loading, cleaning, and exploration |
| `numpy` | Numerical operations |
| `matplotlib` | Base plotting |
| `seaborn` | Statistical data visualization |

---

## Getting Started

```bash
jupyter notebook Project.ipynb
```

---

## Key Findings

- The dataset has **no duplicate rows** and only one column (`maidenName`) with missing values.
- The average user age is approximately **33 years**.
- Average height is **~175.7 cm** and average weight is **~75.0 kg**.
- Gender distribution and age are relatively balanced across the dataset.

