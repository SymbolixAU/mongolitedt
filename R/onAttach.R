.onAttach <- function(libname, pkgname) {

  if (interactive()) {
    packageStartupMessage('mongolitedt is still being developed and is not yet on CRAN.')
    packageStartupMessage('')
  }

}
