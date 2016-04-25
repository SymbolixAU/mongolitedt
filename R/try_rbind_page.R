#' rbind page
#'
#' attempt to **data.table::rbindlist** the page object returned by the mongo cursor
#' @param lst List object of the returned MongoDB data
try_rbind_page <- function(lst){

  lst <- tryCatch({
    data.table::rbindlist(lst, use.names = TRUE, fill = TRUE)
  },
  error = function(cond){
    msg <- paste0("data.table::rbindlist error:\n", geterrmessage())
    message(msg)
  },
  warning = function(cond){
    msg <- paste0("data.table::rbindlist warning:\n", warnings())
    message(msg)
  })
}
