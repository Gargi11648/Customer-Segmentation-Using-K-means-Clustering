# Customer Segmentation using K-Means in R

Mini project: segment mall customers by Age, Annual Income and Spending Score using K-Means,
and explore the result in an interactive Shiny dashboard.

## Folder structure
```
customer-segmentation-r/
├── app.R                    # Shiny dashboard
├── report.Rmd               # Project report (knit to HTML/PDF)
├── data/Mall_Customers.csv  # Dataset
├── R/
│   ├── 01_install_packages.R
│   ├── 02_analysis.R        # EDA + K selection + clustering + profiling
│   └── helpers.R
└── outputs/                 # Charts and CSVs are saved here
```

## How to run
1. Open the folder in RStudio (File > Open Project or set it as working directory).
2. `source("R/01_install_packages.R")`   (once)
3. `source("R/02_analysis.R")`           (analysis, saves plots in outputs/)
4. `shiny::runApp()`                     (dashboard)
5. Open `report.Rmd` and click Knit      (report)

## IMPORTANT: dataset
The included `data/Mall_Customers.csv` is a **sample file with the same columns** as the Kaggle dataset
(CustomerID, Genre, Age, Annual Income (k$), Spending Score (1-100)), created so the project runs
out of the box. For your final submission, download the original
**"Mall Customer Segmentation Data"** from Kaggle and replace this file (same name, same columns).
Nothing else needs to change.
