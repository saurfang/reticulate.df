PANDAS <- NULL; PY_FEATHER <- NULL; PY_BULTIN <- NULL

.onLoad <- function(libname, pkgname) {

  if (reticulate::py_available(initialize = TRUE)) {
    if (reticulate::py_module_available("pandas")) {
      PANDAS <<- reticulate::import("pandas", delay_load = TRUE)
    }

    if (reticulate::py_module_available("feather")) {
      PY_FEATHER <<- reticulate::import("feather", delay_load = TRUE)
    }

    PY_BULTIN <<- reticulate::import_builtins()
  }
}
