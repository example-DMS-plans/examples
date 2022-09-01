library(tidyverse)
library(googlesheets4)

# options(gargle_verbosity = "debug")

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
                              token = get_gs4_token(), 
                              file_out = "raw_data.RDS")
{
    gs4_deauth()
    gs4_auth(token = token)
    dat <- read_sheet(DATA_URL, col_types = "c")
    saveRDS(dat, file_out)
}

process_raw_data <- function(file_in = "raw_data.RDS")
{
    dat <- readRDS(file_in)
}

decrypt_gs4_token <- function()
{
    token_BIN <- NULL
    if (gargle:::secret_can_decrypt("gargle"))
    {
        path <- "inst/secret/gs4-auth.token"
        raw <- readBin(path, "raw", file.size(path))
        token_BIN <- sodium::data_decrypt(bin = raw, 
                                      key = gargle:::secret_pw_get("gargle"), 
                                      nonce = gargle:::secret_nonce())
    }
    
    invisible(token_BIN)
}

write_gs4_token <- function(token_BIN, file_out = "token.RDS")
{
    writeBin(token_BIN, file_out)
}

get_gs4_token <- function()
{
    token_BIN <- decrypt_gs4_token()
    write_gs4_token(token_BIN)
    readRDS("token.RDS")
}