source("init.R")

# Reset connections
almond::reset_mysql_connections()
# See active connections
almond::list_mysql_connections()

# Create DB Connection
conn <- almond::db_model$new(
  list(
    host = "x",
    user = "x",
    password = "x",
    dbname = ""
  )
)

query <- ""

df <- conn$query(query)

load(paste0(data_path, "file.Rda"))
load(paste0(raw_data_path, "raw.Rda"))

iris %>% dplyr::select(Sepal.Length)
x <- data.table::setDT(data.frame(1,2))

load(paste0(data_path, "raw.Rda"))