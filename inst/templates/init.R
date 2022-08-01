#------------------------------------------
renv::restore() # nolint - renv::init()

root_path <- here::here()
data_path <- paste0(root_path, "/data/")
raw_data_path <- paste0(root_path, "/data/raw/")
