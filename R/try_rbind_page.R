#' rbind page
#'
#' attempt to **data.table::rbindlist** the page object returned by the mongo cursor
#' @param lst List object of the returned MongoDB data
try_rbind_page <- function(lst){

  lst <- tryCatch({
    data.table::rbindlist(lst, use.names = TRUE, fill = TRUE)
  },
  error = function(cond){
    ## causes of errors:
    ## - unsupported data type (e.g. 'raw' oid)
    message("Error coercing list into data.table. Please ensure the query returns a structure that can be used by data.table::rbindlist(), and that all data types are supported")
    #return(lst <- "temp")
  },
  warning = function(cond){
    message('warning message')
  })
}
