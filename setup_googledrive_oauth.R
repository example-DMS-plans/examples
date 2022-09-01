library(googledrive)

# set up a local file cache for a new token
options(gargle_oauth_cache = ".secrets")
gargle::gargle_oauth_cache()

# create a new token
drive_auth(email = TRUE, scopes = "https://www.googleapis.com/auth/spreadsheets.readonly")

# check that a new token was created
list.files(".secrets/")
token_file <- file.path(".secrets", list.files(".secrets/")[1])

# setup encryption key
pw_name <- gargle:::secret_pw_name("gargle")
pw <- gargle:::secret_pw_gen()
cat(paste0(pw_name, "=", pw)) # copy the result of this string
usethis::edit_r_environ() # run this to open your .Renviron file
# paste the result into that file
# restart your R session

# encrypt a new token and save it in inst/secrets/gs4-auth.token
gargle:::secret_write(
    package = "gargle", 
    name = "gs4-auth.token", 
    input = token_file
)

# check that the token can be decrypted
stopifnot(!is.null(decrypt_gs4_token()))
