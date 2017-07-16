#' @export
as.data.frame.pandas.core.frame.DataFrame <- function(x, ...) {
  feather_tmp <- tempfile(fileext = "feather")

  PY_FEATHER$write_dataframe(x, feather_tmp)

  feather::read_feather(feather_tmp)
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
