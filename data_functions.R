library(tidyverse)
library(googlesheets4)

get_data_url <- function()
{
    DATA_URL <- Sys.getenv("DATA_URL", unset = NA)
    if (is.na(DATA_URL))
    {
        stop("did not find a DATA_URL environmental variable")
    }
    invisible(DATA_URL)
}

download_raw_data <- function(DATA_URL = get_data_url(), 
                              file_out = "raw_data.RDS")
{
    gs4_auth(path = rawToChar(get_gs4_token()), 
             email = TRUE, 
             scopes = "https://www.googleapis.com/auth/spreadsheets.readonly")
    dat <- read_sheet(DATA_URL, col_types = "c")
    saveRDS(dat, file_out)
}

process_raw_data <- function(file_in = "raw_data.RDS")
{
    dat <- readRDS(file_in)
}

get_gs4_token <- function()
{
    token <- NULL
    if (gargle:::secret_can_decrypt("gargle"))
    {
        path <- "inst/secret/gs4-auth.token"
        raw <- readBin(path, "raw", file.size(path))
        token <- sodium::data_decrypt(bin = raw, 
                                      key = gargle:::secret_pw_get("gargle"), 
                                      nonce = gargle:::secret_nonce())
    }
    
    invisible(token)
}

