#' Setup a standardized folder and file structure for a research analysis project.
#'
#' This starts the project by setting up a common folder and file infrastructure,
#' as well as adding some useful files to start the project.
#'
#' @param path A path to a new directory.
#'
#' @return Project setup with folders and files necessary for a standard research project.
#' @export
#'
#' @examples
#' \dontrun{
#' # Use a temporary location
#' new_proj_name <- fs::path_temp("my_project")
#' setup_project(new_proj_name)
#' }
setup_project <-
    function(path) {
        stopifnot(is.character(path))
        proj_path <- fs::path_abs(path)

        if (grepl(" ", basename(proj_path))) {
            rlang::warn("Project name has a space in it, replacing with a dash (-).")
            proj_path <- path_remove_spaces(proj_path)
        }

        fs::dir_create(proj_path)

        withr::with_dir(
            new = proj_path,
            code = {
                proj_name <- fs::path_file(proj_path)
                add_rproj_file(proj_name)
                add_description_file(proj_name)
                create_directories()
                add_git_ignore_files()
                add_r_scripts()
                include_readmes(proj_name)
            })
    }

# Create files ------------------------------------------------

create_directories <- function() {
    fs::dir_create(c("data", "etl", "data/raw", "reports"))
}

add_description_file <- function(proj_name) {
    use_template("basic-description", "DESCRIPTION",
                 data = list(ProjectName = proj_name))
}

add_r_scripts <- function(proj_name) {
    use_template("init.R", "init.R")
    use_template("etl.R", "etl/001_dw.R")
}

include_readmes <- function(proj_name) {
    use_template(
        "README.md",
        "README.md",
        data = list(ProjectName = proj_name)
    )

    use_template("data_README.md", "data/README.md")
}

add_git_ignore_files <- function() {
    base::writeLines(c(".Rhistory", ".RData", ".Rproj.user"), ".gitignore")
    base::writeLines(c(""), "data/.gitkeep")
    base::writeLines(c(""), "data/raw/.gitkeep")
    base::writeLines(c(""), "reports/.gitkeep")
}

# Utilities -----------------------------------------------------

path_remove_spaces <- function(path) {
    path_as_vector <- fs::path_split(path)[[1]]
    last_dir <- length(path_as_vector)
    path_as_vector[last_dir] <- gsub(" +", "-", path_as_vector[last_dir])
    fs::path_join(path_as_vector)
}
