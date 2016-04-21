#' try_rbind_page
#'
#' attempt to data.table::rbindlist the page returned by the mongo cursor
#' @param lst List object of the returned MongoDB data
try_rbind_page <- function(lst){

  lst <- tryCatch({
    rbindlist(lst)
  },
  error = function(cond){
    ## causes of errors:
    ## - unsupported data type (e.g. 'raw' oid)
    message("error rbinding - need to fix")
    return(lst <- "temp")
  },
  warning = function(cond){
    message('warning message')
  })
}
