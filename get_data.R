source("data_functions.R")

if (!exists("DATA_URL"))
{
    DATA_URL <- Sys.getenv("DATA_URL")
}

# grab data from google sheets
download_raw_data(DATA_URL)