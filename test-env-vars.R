source("data_functions.R")

get_data_url()
stopifnot(!is.null(decrypt_gs4_token()))
