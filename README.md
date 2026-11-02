# 📊 Customer Segmentation using K-Means Clustering in R

## 📌 Project Overview

Customer Segmentation using K-Means Clustering is a data analysis project developed in R. It groups mall customers into different segments based on their age, annual income, and spending score.

The project uses the **K-Means Clustering Algorithm**, an unsupervised machine learning technique, to identify customers with similar characteristics. It also includes an interactive dashboard developed using Shiny to visualize customer segments and explore the results.

This project helps businesses understand customer behaviour and develop better marketing strategies.

## 🎯 Objectives

- Analyze customer data using R.
- Perform exploratory data analysis (EDA).
- Identify suitable clusters using the Elbow Method and Silhouette Method.
- Apply K-Means clustering to segment customers.
- Visualize customer groups using interactive charts.
- Analyze the characteristics of each customer segment.
- Suggest marketing strategies for different customer groups.

## ✨ Features

- Customer data analysis and cleaning.
- Age distribution and gender analysis.
- Annual income versus spending score visualization.
- Correlation matrix for numerical variables.
- Elbow Method for selecting the number of clusters.
- Silhouette Method for evaluating cluster selection.
- K-Means clustering with a configurable number of clusters.
- Interactive customer segmentation dashboard.
- Customer segment profiling.
- Filter customers by gender and age range.
- Select clustering features interactively.
- View customer details in a data table.
- Download segmented customer data as a CSV file.
- Generate charts, customer profiles, and analysis outputs.

## 🛠️ Technologies Used

- **R:** Programming language used for data analysis and clustering.
- **Shiny:** Framework for creating the interactive web dashboard.
- **Tidyverse:** Data manipulation and visualization.
- **ggplot2:** Statistical data visualization.
- **Plotly:** Interactive charts.
- **factoextra:** Visualization and evaluation of clustering.
- **cluster:** Cluster analysis and silhouette evaluation.
- **DT:** Interactive data tables.
- **corrplot:** Correlation matrix visualization.
- **R Markdown:** Project report generation.
- **CSV:** Customer dataset storage.

## 📁 Project Structure

```text
customer-segmentation-r/
│
├── app.R
├── report.Rmd
├── README.md
│
├── R/
│   ├── 01_install_packages.R
│   ├── 02_analysis.R
│   └── helpers.R
│
├── data/
│   └── Mall_Customers.csv
│
└── outputs/
```

### File Description

- `app.R` — Main Shiny dashboard application.
- `report.Rmd` — Project report written using R Markdown.
- `README.md` — Project documentation.
- `R/01_install_packages.R` — Installs the required R packages.
- `R/02_analysis.R` — Performs data analysis, generates visualizations, applies clustering, and saves results.
- `R/helpers.R` — Contains helper functions for loading data and performing K-Means clustering.
- `data/Mall_Customers.csv` — Customer dataset used for analysis.
- `outputs/` — Stores generated charts and CSV files.

## 📋 Dataset Description

The project uses a Mall Customers dataset containing customer information.

The dataset includes the following attributes:

| Attribute              | Description                                    |
| ---------------------- | ---------------------------------------------- |
| CustomerID             | Unique identifier for each customer            |
| Genre                  | Customer gender in the original dataset        |
| Age                    | Age of the customer                            |
| Annual Income (k$)     | Annual income measured in thousands            |
| Spending Score (1-100) | Score representing customer spending behaviour |

The application prepares the data for analysis and uses age, income, and spending score to identify customer segments.

**Note:** The included dataset is a sample file. For more representative results, replace it with the original Mall Customer Segmentation dataset while maintaining the expected column names.

## 🧠 Algorithm Used: K-Means Clustering

K-Means is an unsupervised machine learning algorithm that divides data into a specified number of clusters based on similarity.

### Working Process

1. Load the customer dataset.
2. Clean and prepare the data.
3. Select numerical features for clustering.
4. Scale the selected features.
5. Choose the number of clusters using evaluation methods.
6. Apply the K-Means algorithm.
7. Assign each customer to a cluster.
8. Analyze and visualize the resulting customer segments.

### Methods Used to Select K

**1. Elbow Method**

The Elbow Method examines within-cluster variation for different values of K. It helps identify a suitable number of clusters by looking for a point where the improvement begins to decrease.

**2. Silhouette Method**

The Silhouette Method evaluates how well customers fit within their assigned clusters compared with other clusters. It helps assess the quality of the clustering.

## 📊 Customer Segments

The project provides example marketing recommendations for different customer groups.

| Customer Segment   | Suggested Marketing Strategy                                   |
| ------------------ | -------------------------------------------------------------- |
| Premium Spenders   | Loyalty programs, premium offers, and early access to products |
| Careful Wealthy    | Personalized campaigns and quality-focused offers              |
| Budget Enthusiasts | Discount coupons, bundle offers, and festival sales            |
| Low-Value Savers   | Cost-effective promotions                                      |
| Standard Customers | Seasonal offers and cross-selling                              |

The actual cluster assignments depend on the dataset and clustering results. These segment names are illustrative business labels rather than fixed outputs guaranteed by the algorithm.

## 🚀 Installation and Setup

### Prerequisites

Install the following software before running the project:

- R
- RStudio
- Required R packages

### Step 1: Download the Project

Download or clone the repository from GitHub and extract the project folder.

### Step 2: Open the Project

Open RStudio and set `customer-segmentation-r` as your working directory.

Make sure the current working directory is the project root folder containing `app.R`.

### Step 3: Install Required Packages

Run the following command in the RStudio Console:

```r
source("R/01_install_packages.R")
```

This script installs the required packages if they are not already installed.

### Step 4: Run the Data Analysis

Execute:

```r
source("R/02_analysis.R")
```

This performs exploratory data analysis, evaluates the number of clusters, applies K-Means clustering, and saves the generated charts and CSV files in the `outputs/` folder.

### Step 5: Run the Dashboard

Execute:

```r
shiny::runApp()
```

The Shiny dashboard will open in your default web browser.

### Step 6: Generate the Project Report

1. Open `report.Rmd` in RStudio.
2. Click the **Knit** button.
3. Select the required output format if prompted.
4. The generated report will include the analysis, visualizations, and clustering results.

The report requires the packages used in its setup code, including `corrplot` and `rmarkdown`.

## 🖥️ Dashboard Modules

The interactive dashboard contains four main sections.

### 1. Segments

Displays an interactive scatter plot of customer income and spending scores, with colours representing the assigned clusters.

### 2. Segment Profile

Displays a summary of the customer groups and a chart showing the number of customers in each segment.

### 3. Choose K

Provides Elbow Method and Silhouette Method visualizations to help users evaluate the number of clusters.

### 4. Customers

Displays customer records, their assigned segments, and an option to download the results as a CSV file.

Users can also adjust the number of clusters, selected features, gender, and age range through the sidebar.

## 📈 Expected Outcomes

The project helps users:

- Understand customer characteristics.
- Identify groups with similar spending behaviour.
- Compare customers based on age and annual income.
- Explore patterns in customer spending.
- Develop targeted marketing strategies.
- Make data-driven business decisions.

Results depend on the dataset, selected features, filters, and number of clusters.

## 🔮 Future Scope

The project can be improved by:

- Comparing K-Means with hierarchical clustering and other algorithms.
- Applying Principal Component Analysis (PCA).
- Adding more customer attributes.
- Improving cluster evaluation and interpretation.
- Connecting the dashboard to a database.
- Deploying the Shiny application online.
- Adding interactive business reports and advanced visualizations.

## 📚 References

- R Documentation: K-Means Clustering (`stats::kmeans`)
- Shiny Documentation: [https://shiny.posit.co/](https://shiny.posit.co/)
- Tidyverse Documentation: [https://www.tidyverse.org/](https://www.tidyverse.org/)
- Plotly for R: [https://plotly.com/r/](https://plotly.com/r/)
- factoextra Package: [https://rpkgs.datanovia.com/factoextra/](https://rpkgs.datanovia.com/factoextra/)
- Kaggle: Mall Customer Segmentation Data

## 👩‍💻 Author


**Project Title:** Customer Segmentation using K-Means Clustering in R
**Project Type:** Data Analysis and Machine Learning
**Programming Language:** R

## 📄 License

This project was developed for educational and academic purposes.
