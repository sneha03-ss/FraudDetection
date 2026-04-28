
# report.R
# Fraud Detection Project — Report Writing Module


write_report <- function(result, filepath = "report.txt") {

  # Open a text connection to the file (overwrites if exists)
  con <- file(filepath, open = "w")

  # ----- Helper: write a line to the file -----
  wl <- function(...) writeLines(paste0(...), con)

  n           <- length(result$ids)
  fraud_count <- result$fraud_count
  normal_count <- n - fraud_count
  fraud_rate  <- 100 * fraud_count / n

  # Collect IDs of fraud transactions for narrative
  fraud_ids <- character(0)
  for (i in 1:n) {
    if (result$statuses[i] == "FRAUD") {
      fraud_ids <- c(fraud_ids, result$ids[i])
    }
  }

  
  wl("     FRAUD TRANSACTION DETECTION — ACADEMIC REPORT")
  wl("     Method: Statistical Z-Score Analysis in R")
  
  wl("")
  wl("Report Generated : ", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
  wl("Threshold Used   :  ±", result$threshold, " Standard Deviations")
  wl("Total Records    :  ", n)
  wl("")

  # ---- Section 1: Summary Statistics ----

  wl("SECTION 1: SUMMARY STATISTICS")
  
  wl("")
  wl("  Mean Transaction Amount  : $", round(result$mean_val, 4))
  wl("  Standard Deviation       : $", round(result$std_dev,  4))
  wl("  Total Transactions       :  ", n)
  wl("  Fraudulent Transactions  :  ", fraud_count)
  wl("  Normal Transactions      :  ", normal_count)
  wl(sprintf("  Fraud Detection Rate     :  %.2f%%", fraud_rate))
  wl("")

  # ---- Section 2: Full Results Table ----
  
  wl("SECTION 2: TRANSACTION-LEVEL RESULTS")
  
  wl("")
  wl(sprintf("  %-12s  %-12s  %-10s  %-10s",
             "Transaction", "Amount (USD)", "Z-Score", "Status"))
  wl(sprintf("  %-12s  %-12s  %-10s  %-10s",
             "----------", "------------", "--------", "------"))

  for (i in 1:n) {
    flag <- if (result$statuses[i] == "FRAUD") "  *** FRAUD ***" else ""
    wl(sprintf("  %-12s  %-12.2f  %-10.4f  %-10s%s",
               result$ids[i],
               result$amounts[i],
               result$zscores_rounded[i],
               result$statuses[i],
               flag))
  }
  wl("")

  # ---- Section 3: Fraud Cases ----
  
  wl("SECTION 3: IDENTIFIED FRAUD TRANSACTIONS")
  
  wl("")

  if (fraud_count == 0) {
    wl("  No fraudulent transactions detected.")
  } else {
    for (i in 1:n) {
      if (result$statuses[i] == "FRAUD") {
        wl(sprintf("  Transaction %-4s  Amount: $%-10.2f  Z-Score: %+.4f",
                   result$ids[i],
                   result$amounts[i],
                   result$zscores_rounded[i]))
      }
    }
  }
  wl("")

  # ---- Section 4: Methodology ----
  
  wl("SECTION 4: METHODOLOGY")

  wl("")
  wl("  The Z-Score method detects statistical outliers by measuring")
  wl("  how many standard deviations a data point lies from the mean.")
  wl("")
  wl("  Step 1 — Mean Calculation (manual loop):")
  wl("    mean = SUM(x_i) / n")
  wl(sprintf("    mean = $%.4f", result$mean_val))
  wl("")
  wl("  Step 2 — Standard Deviation (manual loop):")
  wl("    variance = SUM((x_i - mean)^2) / (n - 1)")
  wl("    std_dev  = SQRT(variance)")
  wl(sprintf("    std_dev  = $%.4f", result$std_dev))
  wl("")
  wl("  Step 3 — Z-Score per Transaction:")
  wl("    Z = (x_i - mean) / std_dev")
  wl("")
  wl("  Step 4 — Classification:")
  wl(sprintf("    |Z| > %.1f  →  FRAUD", result$threshold))
  wl(sprintf("    |Z| ≤ %.1f  →  Normal", result$threshold))
  wl("")

  # ---- Section 5: Observations ----

  wl("SECTION 5: OBSERVATIONS & CONCLUSIONS")

  wl("")
  wl("  1. Out of ", n, " transactions, ", fraud_count,
     " were flagged as fraudulent.")
  wl(sprintf("  2. The fraud detection rate was %.2f%%.", fraud_rate))
  wl("  3. Fraudulent transactions were identified at IDs: ",
     paste(fraud_ids, collapse = ", "))
  wl("  4. All fraudulent transactions showed amounts significantly")
  wl("     above the mean, indicating unusually large purchases.")
  wl("  5. A Z-score threshold of ±2.5 was chosen to reduce")
  wl("     false positives while catching clear outliers.")
  wl("  6. The method is fully manual — no built-in R statistical")
  wl("     functions (mean, sd, var, scale) were used.")
  wl("")

  wl("                      END OF REPORT")


  close(con)

  cat("  [Report saved to:", filepath, "]\n")
}
