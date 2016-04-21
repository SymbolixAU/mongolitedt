#' Read in MongoDB data
#' @param cur MongoDB Cursor
#' @param pagesize Pagesize
#' @param verbose Verbose
mongo_stream_in_dt <- function(cur, pagesize = 1000, verbose = TRUE){

  # Type validation
  stopifnot(is.numeric(pagesize))
  stopifnot(is.logical(verbose))

  # Read data page by page and rbindlist into data.table
  count <- 0
  dt <- data.table()
  repeat {
    page <- mongolite:::mongo_cursor_next_page(cur, pagesize)
    ## page is a list, with a 'date' flag on dates
    count <- count + length(page)

    ## remove any 'raw' columns
    # classes <- unique(unlist(lapply(page, function(x) lapply(x, class) != "raw")))
    page <- lapply(page, function(x) x[lapply(x, class)!="raw"])

    dt_page <- try_rbind_page(page)
    # dt_page <- rbindlist(page)
    classes <- lapply(dt_page, class) == "list"
    cols <- names(classes[classes])
    for(j in cols) set(dt_page, j = j, value = unlist(dt_page[[j]]))

    # page is a list
    if(nrow(dt) == 0){
      dt <- dt_page
    }else{
      dt <- rbindlist(list(dt, dt_page), use.names=T)
    }

    cat("\r Found", count, "records...")

    if(length(page) < pagesize)
      break
  }
  return(dt)
}


