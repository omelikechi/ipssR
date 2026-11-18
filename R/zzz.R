.onLoad <- function(libname, pkgname) {
  if (!reticulate::py_module_available("ipss")) {
    message("Python package 'ipss' not found. Installing into reticulate's environment...")
    reticulate::py_install("ipss", pip = TRUE)
  }
}
