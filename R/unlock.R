

rcpp_unlock <- function() {
  .Call('mongolitedt_unlock', PACKAGE = 'mongolitedt')
}
