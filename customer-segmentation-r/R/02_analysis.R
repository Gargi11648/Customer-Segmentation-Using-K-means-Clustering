# Customer Segmentation using K-Means  -  full analysis script
# Run from the project root folder:  source("R/02_analysis.R")

suppressPackageStartupMessages({
  library(tidyverse); library(cluster); library(factoextra); library(corrplot)
})
source("R/helpers.R")
dir.create("outputs", showWarnings = FALSE)

# 1. LOAD & CLEAN ------------------------------------------------------------
df <- load_data()
cat("Rows:", nrow(df), " Columns:", ncol(df), "\n")
str(df)
cat("\nMissing values per column:\n"); print(colSums(is.na(df)))
cat("\nDuplicate rows:", sum(duplicated(df)), "\n")
print(summary(df))

# 2. EDA ---------------------------------------------------------------------
p1 <- ggplot(df, aes(Age, fill = Gender)) +
  geom_histogram(bins = 15, colour = "white", position = "dodge") +
  labs(title = "Age Distribution by Gender") + theme_minimal()
ggsave("outputs/01_age_distribution.png", p1, width = 7, height = 4, dpi = 150)

p2 <- ggplot(df, aes(Gender, fill = Gender)) + geom_bar(width = 0.5) +
  labs(title = "Gender Count") + theme_minimal()
ggsave("outputs/02_gender_count.png", p2, width = 5, height = 4, dpi = 150)

p3 <- ggplot(df, aes(Income, Spending, colour = Gender)) + geom_point(size = 2.5, alpha = 0.8) +
  labs(title = "Annual Income vs Spending Score", x = "Annual Income (k$)", y = "Spending Score") +
  theme_minimal()
ggsave("outputs/03_income_vs_spending.png", p3, width = 7, height = 5, dpi = 150)

png("outputs/04_correlation.png", 700, 600, res = 120)
corrplot(cor(df[, c("Age", "Income", "Spending")]), method = "color",
         addCoef.col = "black", tl.col = "black", title = "Correlation Matrix", mar = c(0, 0, 2, 0))
dev.off()

# 3. CHOOSE K ----------------------------------------------------------------
scaled <- scale(df[, c("Age", "Income", "Spending")])
set.seed(123)
elbow <- fviz_nbclust(scaled, kmeans, method = "wss", k.max = 10, nstart = 25) +
  labs(title = "Elbow Method")
sil <- fviz_nbclust(scaled, kmeans, method = "silhouette", k.max = 10, nstart = 25) +
  labs(title = "Silhouette Method")
ggsave("outputs/05_elbow.png", elbow, width = 7, height = 4, dpi = 150)
ggsave("outputs/06_silhouette.png", sil, width = 7, height = 4, dpi = 150)

# 4. K-MEANS -----------------------------------------------------------------
K <- 5   # change if elbow/silhouette plots suggest a different value
res <- run_kmeans(df, k = K)
seg <- res$data

cl <- fviz_cluster(res$model, data = scaled, geom = "point", ellipse.type = "convex",
                   ggtheme = theme_minimal(), main = paste("K-Means Clusters (k =", K, ")"))
ggsave("outputs/07_clusters_pca.png", cl, width = 7, height = 5, dpi = 150)

p4 <- ggplot(seg, aes(Income, Spending, colour = Segment)) + geom_point(size = 2.5) +
  labs(title = "Customer Segments", x = "Annual Income (k$)", y = "Spending Score") +
  theme_minimal() + theme(legend.position = "bottom", legend.direction = "vertical")
ggsave("outputs/08_segments.png", p4, width = 8, height = 6, dpi = 150)

# 5. SEGMENT PROFILE ---------------------------------------------------------
cat("\n=== Segment profile ===\n"); print(res$profile)
cat("\nSilhouette (avg width):",
    round(mean(silhouette(res$model$cluster, dist(scaled))[, 3]), 3), "\n")

write_csv(seg, "outputs/customers_with_segments.csv")
write_csv(res$profile, "outputs/segment_profile.csv")

# 6. BUSINESS RECOMMENDATIONS -------------------------------------------------
cat("
=== Suggested marketing actions ===
Premium Spenders   : loyalty programme, early access to new products, premium offers
Careful Wealthy    : personalised quality-focused campaigns, exclusive deals to raise spend
Budget Enthusiasts : discount coupons, EMI / festival sales, bundle offers
Low-Value Savers   : low-cost promotions only, avoid heavy marketing spend
Standard Customers : seasonal offers and cross-selling to move them upward
")
cat("Done. Check the outputs/ folder.\n")
