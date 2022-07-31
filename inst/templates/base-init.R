#------------------------------------------
# https://www.mzes.uni-mannheim.de/socialsciencedatalab/article/r-package/
# nolint start
# install.packages("~/{root}/src/packages/almond_0.0.0.9000.tar.gz", 
# repos = NULL, type="source")

# renv::init()
renv::restore()

root_path <- here::here()
data_path <- paste0(root_path, "/data/")
raw_data_path <- paste0(root_path, "/data/raw/")
# nolint end
