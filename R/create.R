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
        use_template("base-etl.R", file_name)
        cli::cli_alert_success("Creating an etl file.")
    }
    invisible()
}

#' List project templates within \pkg{prodigenr}.
#'
#' Get a list of available templates in a package.
#'
#' @return Vector of templates available
#' @export
#' @examples
#' template_list
#'
template_list <- c("etl")
