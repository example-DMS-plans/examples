source("data_functions.R")

if (!exists("DATA_URL"))
{
    DATA_URL <- Sys.getenv("DATA_URL")
}

# grab data from google sheets
download_raw_data(DATA_URL)

# read in raw data, process and save out
plans_data <- process_raw_data()
saveRDS(plans_data, "plans_data.Rdata")