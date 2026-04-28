
# dataset.R
# Fraud Detection Project - Dataset Module
# Description: Manually creates transaction amount dataset
#              with clear outliers to simulate fraud cases


get_transaction_data <- function() {


  # Transaction amounts in USD
  # Normal transactions range roughly from $10 to $500
  # Fraudulent transactions are extreme outliers (very high)

  transaction_amounts <- c(
    120.50,   # T01  - Normal
    230.00,   # T02  - Normal
     85.75,   # T03  - Normal
    310.20,   # T04  - Normal
    150.00,   # T05  - Normal
     45.30,   # T06  - Normal
    275.90,   # T07  - Normal
    190.00,   # T08  - Normal
     60.10,   # T09  - Normal
    410.00,   # T10  - Normal
    3500.00,  # T11  - FRAUD (extreme high)
    130.75,   # T12  - Normal
    220.40,   # T13  - Normal
     99.99,   # T14  - Normal
    175.60,   # T15  - Normal
    4800.00,  # T16  - FRAUD (extreme high)
    305.00,   # T17  - Normal
     72.50,   # T18  - Normal
    260.30,   # T19  - Normal
    145.80,   # T20  - Normal
    5200.00,  # T21  - FRAUD (extreme high)
    380.00,   # T22  - Normal
    115.25,   # T23  - Normal
    200.00,   # T24  - Normal
     55.00,   # T25  - Normal
    340.90,   # T26  - Normal
    4100.00,  # T27  - FRAUD (extreme high)
     90.60,   # T28  - Normal
    165.00,   # T29  - Normal
    250.00    # T30  - Normal
  )

  # Transaction IDs corresponding to each amount

  transaction_ids <- c(
    "T01", "T02", "T03", "T04", "T05",
    "T06", "T07", "T08", "T09", "T10",
    "T11", "T12", "T13", "T14", "T15",
    "T16", "T17", "T18", "T19", "T20",
    "T21", "T22", "T23", "T24", "T25",
    "T26", "T27", "T28", "T29", "T30"
  )


  # Return as a named list so other modules can access both

  return(list(
    ids     = transaction_ids,
    amounts = transaction_amounts
  ))
}
