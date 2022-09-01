library(tidyverse)
library(googlesheets4)

download_raw_data <- function(DATA_URL, file_out = "raw_data.RDS")
{
    gs4_deauth() # skip using authentication (since we are accessing a public sheet)
    dat <- read_sheet(DATA_URL, col_types = "c")
    saveRDS(dat, file_out)
}
