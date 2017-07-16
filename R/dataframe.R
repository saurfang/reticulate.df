#' Convert from Pandas DataFrame
#'
#' @param convert_unicode whether to convert string columns to unicode so R can read back correctly
#'
#' @inheritParams base::as.data.frame
#' @export
as.data.frame.pandas.core.frame.DataFrame <- function(x, ..., convert_unicode = TRUE) {
  feather_tmp <- tempfile(fileext = "feather")

  dtypes <- Map(function(x) { x$name }, unlist(x$dtypes$values))
  if (convert_unicode) {
    columns <- x$columns$values

    for (i in seq_along(dtypes)) {
      if (dtypes[i] %in% c("object", "category")) {
        # TODO: encode categorical variables as numbers and pass through levels info in-process
        column <- columns[i]
        reticulate::py_set_attr(x, column, x$get(column)$astype(PY_BULTIN$unicode))
      }
    }
  }

  PY_FEATHER$write_dataframe(x, feather_tmp)

  df <- feather::read_feather(feather_tmp)

  if (convert_unicode) {
    for (i in seq_along(dtypes)) {
      if (dtypes[i] == "category") {
        # TODO: recover ordering of the original categorical variables
        column <- columns[i]
        df[[column]] <- factor(df[[column]])
      }
    }
  }

  df
}

#' Convert to Pandas DataFrame
#'
#' @param x R data.frame to be converted
#'
#' @export
as_pandas <- function(x) {
  feather_tmp <- tempfile(fileext = "feather")

  feather::write_feather(x, feather_tmp)

  PY_FEATHER$read_dataframe(feather_tmp)
}
