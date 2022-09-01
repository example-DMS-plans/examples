source("data_functions.R")

# grab data from google sheets
download_raw_data()

# read in raw data, process and save out
plans_data <- process_raw_data()
saveRDS(plans_data, "plans_data.RDS")
