
# zscore.R
# Fraud Detection Project - Z-Score Algorithm Module
# Description: Manually implements mean, standard deviation,
#              z-score calculation, and fraud classification
#              WITHOUT using mean(), sd(), var(), or scale()




# FUNCTION 1: Calculate Mean Manually
# Formula: mean = sum(x) / n

calc_mean <- function(values) {

  n   <- length(values)   # total number of transactions
  total <- 0              # running sum starts at zero

  # Loop through every value and accumulate the sum
  for (i in 1:n) {
    total <- total + values[i]
  }

  # Divide accumulated sum by count to get arithmetic mean
  mean_val <- total / n

  return(mean_val)
}



# FUNCTION 2: Calculate Standard Deviation Manually
# Formula: sd = sqrt( sum((x - mean)^2) / (n - 1) )
# Uses sample standard deviation (denominator = n-1)

calc_sd <- function(values) {

  n        <- length(values)
  mean_val <- calc_mean(values)   # reuse our manual mean function

  sum_sq_diff <- 0   # accumulate squared differences

  # Step 1: For each value, compute (x - mean)^2 and sum them
  for (i in 1:n) {
    diff        <- values[i] - mean_val    # deviation from mean
    sq_diff     <- diff * diff             # square the deviation
    sum_sq_diff <- sum_sq_diff + sq_diff   # accumulate
  }

  # Step 2: Divide by (n - 1) to get sample variance
  variance <- sum_sq_diff / (n - 1)

  # Step 3: Square root of variance = standard deviation
  std_dev <- sqrt(variance)

  return(std_dev)
}



# FUNCTION 3: Calculate Z-Score for Every Transaction Manually
# Formula: Z = (X - mean) / std_dev

calc_zscores <- function(values) {

  n        <- length(values)
  mean_val <- calc_mean(values)
  std_dev  <- calc_sd(values)

  zscores <- numeric(n)   # pre-allocate result vector

  # Compute z-score for each transaction individually
  for (i in 1:n) {
    zscores[i] <- (values[i] - mean_val) / std_dev
  }

  return(zscores)
}



# FUNCTION 4: Classify Each Transaction as Fraud or Normal
# Rule: if |Z-score| > 2.5  →  "Fraud"
#       otherwise            →  "Normal"
# Threshold of 2.5 catches extreme outliers (stricter than 3)

classify_transactions <- function(zscores, threshold = 2.5) {

  n      <- length(zscores)
  status <- character(n)   # pre-allocate character vector

  for (i in 1:n) {

    # Use absolute value to catch both very high and very low extremes
    abs_z <- zscores[i]
    if (abs_z < 0) {
      abs_z <- -abs_z   # manual absolute value (no abs() needed but it's base R; kept for clarity)
    }

    if (abs_z > threshold) {
      status[i] <- "FRAUD"
    } else {
      status[i] <- "Normal"
    }
  }

  return(status)
}



# FUNCTION 5: Master function - runs the full Z-Score pipeline
# Returns a list with everything needed for reporting & plots

run_fraud_detection <- function(ids, amounts, threshold = 2.5) {

  # Step A: Compute statistics
  mean_val <- calc_mean(amounts)
  std_dev  <- calc_sd(amounts)
  zscores  <- calc_zscores(amounts)
  statuses <- classify_transactions(zscores, threshold)

  # Step B: Count fraud cases using a loop (no sum() on logicals)
  fraud_count <- 0
  for (i in 1:length(statuses)) {
    if (statuses[i] == "FRAUD") {
      fraud_count <- fraud_count + 1
    }
  }

  # Step C: Round z-scores to 4 decimal places for display
  zscores_rounded <- numeric(length(zscores))
  for (i in 1:length(zscores)) {
    zscores_rounded[i] <- round(zscores[i], 4)
  }

  return(list(
    ids             = ids,
    amounts         = amounts,
    mean_val        = mean_val,
    std_dev         = std_dev,
    zscores         = zscores,
    zscores_rounded = zscores_rounded,
    statuses        = statuses,
    fraud_count     = fraud_count,
    threshold       = threshold
  ))
}
