
# visualize.R

# FUNCTION: plot_fraud_detection
# Creates a 2-panel figure:
#   Panel 1 - Transaction Amounts (scatter)  green=Normal, red=FRAUD
#   Panel 2 - Z-Score Bar Chart              with threshold lines

plot_fraud_detection <- function(result) {

  # --- Unpack result list for convenience ---
  ids       <- result$ids
  amounts   <- result$amounts
  zscores   <- result$zscores
  statuses  <- result$statuses
  mean_val  <- result$mean_val
  std_dev   <- result$std_dev
  threshold <- result$threshold
  n         <- length(ids)

  # --- Assign colors: green for Normal, red for FRAUD ---
  colors <- character(n)
  for (i in 1:n) {
    if (statuses[i] == "FRAUD") {
      colors[i] <- "#E74C3C"   # vivid red
    } else {
      colors[i] <- "#27AE60"   # vivid green
    }
  }

  # --- Set up a 2-row, 1-column layout ---
  par(mfrow = c(2, 1),
      mar   = c(5, 5, 4, 2),   # bottom, left, top, right margins
      bg    = "#F8F9FA")        # light grey background


 
  # PANEL 1: Transaction Amount Scatter Plot
 
  plot(
    x    = 1:n,
    y    = amounts,
    type = "n",                             # blank canvas first
    xlab = "Transaction Index",
    ylab = "Amount (USD)",
    main = "Transaction Amounts — Fraud Detection (Z-Score Method)",
    xaxt = "n",                             # suppress default x-axis
    col.main = "#2C3E50",
    font.main = 2,
    cex.main  = 1.1
  )

  # Draw a subtle horizontal grid
  grid(nx = NA, ny = NULL, col = "#CCCCCC", lty = "dotted")

  # Horizontal dashed line at the mean
  abline(h   = mean_val,
         col = "#3498DB",
         lty = 2,
         lwd = 1.5)

  # Shade +/- 2.5 SD band (the "normal" zone)
  upper_band <- mean_val + threshold * std_dev
  lower_band <- mean_val - threshold * std_dev

  # Draw the normal zone as a filled polygon
  polygon(
    x   = c(0, n + 1, n + 1, 0),
    y   = c(lower_band, lower_band, upper_band, upper_band),
    col = adjustcolor("#27AE60", alpha.f = 0.08),
    border = NA
  )

  # Upper threshold line
  abline(h   = upper_band,
         col = "#E74C3C",
         lty = 2,
         lwd = 1.5)

  # Plot the actual points on top
  points(
    x   = 1:n,
    y   = amounts,
    pch = 19,       # filled circle
    col = colors,
    cex = 1.3
  )

  # Custom x-axis with transaction IDs (every 3rd label to avoid clutter)
  axis(side = 1,
       at   = 1:n,
       labels = ids,
       las  = 2,
       cex.axis = 0.65)

  # Label each FRAUD point with its ID
  for (i in 1:n) {
    if (statuses[i] == "FRAUD") {
      text(x      = i,
           y      = amounts[i],
           labels = ids[i],
           pos    = 4,       # to the right of the point
           col    = "#C0392B",
           cex    = 0.8,
           font   = 2)
    }
  }

  # Legend
  legend(
    x      = "topleft",
    legend = c("Normal Transaction", "Fraudulent Transaction",
               paste0("Mean ($", round(mean_val, 2), ")" ),
               paste0("+", threshold, " SD Threshold")),
    col    = c("#27AE60", "#E74C3C", "#3498DB", "#E74C3C"),
    pch    = c(19, 19, NA, NA),
    lty    = c(NA, NA, 2, 2),
    lwd    = c(NA, NA, 1.5, 1.5),
    pt.cex = 1.2,
    cex    = 0.75,
    bg     = "white",
    box.col = "#CCCCCC"
  )


  # PANEL 2: Z-Score Bar Chart

  bar_cols <- character(n)
  for (i in 1:n) {
    if (statuses[i] == "FRAUD") {
      bar_cols[i] <- "#E74C3C"
    } else {
      bar_cols[i] <- "#27AE60"
    }
  }

  bp <- barplot(
    height  = zscores,
    names.arg = ids,
    col     = bar_cols,
    border  = NA,
    las     = 2,
    cex.names = 0.65,
    main    = paste0("Z-Scores per Transaction  (Threshold = ±", threshold, ")"),
    ylab    = "Z-Score",
    xlab    = "Transaction ID",
    col.main = "#2C3E50",
    font.main = 2,
    cex.main  = 1.1
  )

  # Threshold lines
  abline(h   =  threshold,
         col = "#C0392B",
         lty = 2,
         lwd = 2)
  abline(h   = -threshold,
         col = "#C0392B",
         lty = 2,
         lwd = 2)

  # Zero baseline
  abline(h   = 0,
         col = "#7F8C8D",
         lty = 1,
         lwd = 1)

  # Annotate threshold lines
  text(x      = max(bp) + 0.5,
       y      =  threshold + 0.15,
       labels = paste0("+", threshold),
       col    = "#C0392B",
       cex    = 0.8,
       font   = 2,
       xpd    = TRUE)

  text(x      = max(bp) + 0.5,
       y      = -threshold - 0.15,
       labels = paste0("-", threshold),
       col    = "#C0392B",
       cex    = 0.8,
       font   = 2,
       xpd    = TRUE)

  # Legend for bar chart
  legend(
    x      = "topleft",
    legend = c("Normal", "FRAUD", paste0("±", threshold, " Threshold")),
    fill   = c("#27AE60", "#E74C3C", NA),
    border = c("grey40", "grey40", NA),
    lty    = c(NA, NA, 2),
    lwd    = c(NA, NA, 2),
    col    = c(NA, NA, "#C0392B"),
    cex    = 0.75,
    bg     = "white",
    box.col = "#CCCCCC"
  )

  # Reset layout to single panel
  par(mfrow = c(1, 1))
}



# FUNCTION: save_plot
# Saves the visualization to a PNG file (600 DPI quality)

save_plot <- function(result, filepath = "fraud_detection_plot.png") {

  png(filename = filepath,
      width    = 1200,
      height   = 900,
      res      = 150,
      bg       = "#F8F9FA")

  plot_fraud_detection(result)

  dev.off()

  cat("  [Plot saved to:", filepath, "]\n")
}
