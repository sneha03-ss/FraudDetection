
# Fraud Detection Project 

setwd("C:/Users/sneha/Downloads/FraudDetection/FraudDetection")


cat("   FRAUD TRANSACTION DETECTION — Z-Score Method in R\n")


# STEP 1: Load all project modules
cat("[1/5] Loading project modules...\n")

source("dataset.R")     # transaction data
source("zscore.R")      # manual statistics & classification
source("visualize.R")   # base-R plotting

cat("      All modules loaded successfully.\n\n")

# STEP 2: Load the dataset

cat("[2/5] Creating transaction dataset...\n")

data     <- get_transaction_data()
ids      <- data$ids
amounts  <- data$amounts

cat(sprintf("      Dataset ready: %d transactions loaded.\n\n",
            length(amounts)))

# STEP 3: Run fraud detection algorithm

cat("[3/5] Running Z-Score fraud detection algorithm...\n")

result <- run_fraud_detection(ids, amounts, threshold = 2.5)

cat(sprintf("      Detection complete. Threshold = ±%.1f SD\n\n",
            result$threshold))


# STEP 4: Print full results table to console

cat("[4/5] Printing results...\n\n")

cat(sprintf("  %-12s  %-12s  %-10s  %-10s\n",
            "Transaction", "Amount (USD)", "Z-Score", "Status"))


for (i in 1:length(result$ids)) {
  
  # Highlight fraud transactions
  marker <- if (result$statuses[i] == "FRAUD") " <== FRAUD!" else ""
  
  cat(sprintf("  %-12s  %-12.2f  %-10.4f  %-10s%s\n",
              result$ids[i],
              result$amounts[i],
              result$zscores_rounded[i],
              result$statuses[i],
              marker))
}



# Summary statistics
cat("  SUMMARY STATISTICS\n")
cat("  ------------------\n")
cat(sprintf("  Mean Transaction Amount : $%.2f\n",  result$mean_val))
cat(sprintf("  Standard Deviation      : $%.2f\n",  result$std_dev))
cat(sprintf("  Z-Score Threshold       :  ±%.1f\n", result$threshold))
cat(sprintf("  Total Transactions      :  %d\n",    length(result$ids)))
cat(sprintf("  Fraudulent Transactions :  %d\n",    result$fraud_count))
cat(sprintf("  Normal Transactions     :  %d\n",
            length(result$ids) - result$fraud_count))
cat(sprintf("  Fraud Rate              :  %.1f%%\n",
            100 * result$fraud_count / length(result$ids)))
cat("\n")


# STEP 5: Generate visualization & report

cat("[5/5] Generating visualization and saving report...\n\n")

# Save plot
save_plot(result, filepath = "fraud_detection_plot.png")

# Generate report
source("report.R")
write_report(result, filepath = "report.txt")

cat("   PROJECT COMPLETE — All outputs generated successfully!\n")


cat("Files created:\n")
cat(" - fraud_detection_plot.png\n")
cat(" - report.txt\n")