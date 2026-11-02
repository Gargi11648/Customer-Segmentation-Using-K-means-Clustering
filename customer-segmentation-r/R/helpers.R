# Shared helper functions used by the analysis script, the report and the Shiny app

load_data <- function(path = "data/Mall_Customers.csv") {
  df <- readr::read_csv(path, show_col_types = FALSE)
  df <- dplyr::rename(df,
                      Gender   = Genre,
                      Income   = `Annual Income (k$)`,
                      Spending = `Spending Score (1-100)`)
  df$Gender <- factor(df$Gender)
  df
}

# Name a segment from its average income and spending score
name_segment <- function(income, spending) {
  dplyr::case_when(
    income >= 70 & spending >= 60 ~ "Premium Spenders (High income, High spend)",
    income >= 70 & spending <  40 ~ "Careful Wealthy (High income, Low spend)",
    income <  40 & spending >= 60 ~ "Budget Enthusiasts (Low income, High spend)",
    income <  40 & spending <  40 ~ "Low-Value Savers (Low income, Low spend)",
    TRUE                          ~ "Standard / Average Customers"
  )
}

# Run k-means on scaled features, return df with Cluster + Segment columns
run_kmeans <- function(df, k = 5, features = c("Age", "Income", "Spending"), seed = 123) {
  set.seed(seed)
  scaled <- scale(df[, features])
  km <- kmeans(scaled, centers = k, nstart = 25)
  df$Cluster <- factor(km$cluster)
  prof <- df |>
    dplyr::group_by(Cluster) |>
    dplyr::summarise(Customers = dplyr::n(),
                     Avg_Age = round(mean(Age), 1),
                     Avg_Income = round(mean(Income), 1),
                     Avg_Spending = round(mean(Spending), 1),
                     .groups = "drop") |>
    dplyr::mutate(Segment = name_segment(Avg_Income, Avg_Spending))
  df <- dplyr::left_join(df, prof[, c("Cluster", "Segment")], by = "Cluster")
  list(data = df, model = km, scaled = scaled, profile = prof)
}
