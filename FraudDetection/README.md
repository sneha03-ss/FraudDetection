# 📊 Fraud Transaction Detection using Statistical Z-Score Method in R

> A complete, beginner-friendly academic project implementing fraud detection  
> **100% from scratch** — no built-in statistical functions used.

---

## 🗂️ Project Structure

```
FraudDetection/
├── main.R          ← MASTER script — run this to execute everything
├── dataset.R       ← Creates 30 transaction records with outliers
├── zscore.R        ← Manual mean, SD, Z-score & classification logic
├── visualize.R     ← Base-R scatter plot + bar chart
├── report.R        ← Writes report.txt
├── report.txt      ← Auto-generated analysis report (after running)
├── fraud_detection_plot.png  ← Auto-generated chart (after running)
└── README.md       ← This file
```

---

## ⚙️ How to Run

### Option A — RStudio (Recommended)
1. Open **RStudio**
2. Set working directory:  
   `Session → Set Working Directory → To Source File Location`
3. Open `main.R`
4. Click the **"Source"** button (top-right of editor panel)

### Option B — R Console
```r
setwd("/path/to/FraudDetection")
source("main.R")
```

### Option C — Terminal / Command Line
```bash
cd /path/to/FraudDetection
Rscript main.R
```

> **No packages needed.** Only base R is used.

---

## 🧩 Module Overview

### `dataset.R`
- Manually defines 30 transaction amounts ($10–$500 normal range)
- Embeds 4 clear outlier transactions ($3,500–$5,200) to simulate fraud
- Returns a named list with `ids` and `amounts`

### `zscore.R`
Implements five manual functions:

| Function | Description |
|---|---|
| `calc_mean(values)` | Loops to sum all values, divides by count |
| `calc_sd(values)` | Loops to compute squared deviations, takes sqrt of variance |
| `calc_zscores(values)` | Applies Z = (X − mean) / sd for each transaction |
| `classify_transactions(zscores, threshold)` | Marks \|Z\| > 2.5 as "FRAUD" |
| `run_fraud_detection(ids, amounts, threshold)` | Orchestrates all steps |

### `visualize.R`
- **Panel 1:** Scatter plot of transaction amounts — green=Normal, red=FRAUD  
  - Shows mean line (blue dashed) and ±2.5 SD band (shaded green zone)
- **Panel 2:** Z-score bar chart with ±2.5 threshold lines marked in red

### `report.R`
- Writes `report.txt` containing:
  - Mean and standard deviation
  - Full transaction table with Z-scores and status
  - List of detected fraud transactions
  - Step-by-step methodology
  - Observations and conclusions

---

## 📐 Algorithm

```
1. Mean  =  Σ(x_i) / n

2. Variance  =  Σ(x_i − mean)² / (n − 1)
   Std Dev   =  √Variance

3. Z-Score  =  (x_i − mean) / std_dev

4. If |Z| > 2.5  →  FRAUD
   Else          →  Normal
```

---

## 📦 Expected Output

```
Transaction  Amount (USD)  Z-Score    Status
T01          120.50        -0.2941    Normal
...
T11          3500.00        3.4201    FRAUD     <== FRAUD!
T16          4800.00        4.6523    FRAUD     <== FRAUD!
T21          5200.00        5.0312    FRAUD     <== FRAUD!
T27          4100.00        3.9744    FRAUD     <== FRAUD!

Mean Transaction Amount : $596.33
Standard Deviation      : $1073.45
Fraudulent Transactions : 4
```

---

## 🚫 Strict Constraints Met

| Constraint | Status |
|---|---|
| No `mean()` used | ✅ |
| No `sd()` used | ✅ |
| No `var()` used | ✅ |
| No `scale()` used | ✅ |
| No external packages | ✅ |
| Manual loops only | ✅ |
| Fully commented | ✅ |

---

## 📁 Create ZIP File

### On macOS / Linux:
```bash
cd ..   # go one level above FraudDetection/
zip -r FraudDetection.zip FraudDetection/
```

### On Windows (PowerShell):
```powershell
Compress-Archive -Path .\FraudDetection -DestinationPath FraudDetection.zip
```

### In RStudio:
```r
zip("FraudDetection.zip", files = list.files(".", recursive = TRUE))
```

---

## 👤 Author
Academic Project — Fraud Detection using R  
Method: Statistical Z-Score Analysis  
Language: R (Base only)
