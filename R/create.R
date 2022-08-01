#' Create a standarized file inside the etl folder
#'
#' @param prefix How to name your file
#'
#' @return A created `.R` file in the `etl/` folder.
#'
#' @examples
#' \dontrun{
#' create_etl('001_dw')
#' create_etl('002_dw_users')
#' }
#'
#' @export
create_etl <- function(prefix = "001") {
    if (!is_rproj_folder()) {
        rlang::abort(c(
            "The folder does not contain an `.Rproj` file.",
            "Please use this function while in the project created from `setup_project().`"
        ))
    }

    file_name <- normalizePath(file.path("etl", paste0(prefix, ".R")), mustWork = FALSE)

    if (file.exists(file_name)) {
        msg <- paste0("The file '", paste0(prefix, ".R"), " already exists in the etl folder.")
        rlang::abort(msg)
    } else {
        usethis::use_template("etl.R", file_name)
        cli::cli_alert_success(paste0("Created an etl file: ", file_name))
    }
    invisible()
}
