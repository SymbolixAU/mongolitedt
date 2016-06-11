mongo_stream_in_dt <- function(cur, pagesize = 1000, verbose = TRUE){

  # Type validation
  stopifnot(is.numeric(pagesize))
  stopifnot(is.logical(verbose))

  # Read data page by page and rbindlist into data.table
  count <- 0
  dt <- data.table::data.table()
  repeat {
    page <- mongolite:::mongo_cursor_next_page(cur, pagesize)
    ## page is a list, with a 'date' flag on dates
    count <- count + length(page)

    ## remove any 'raw' columns (e.g., the '_id' oid field)
    page <- lapply(page, function(x) x[lapply(x, class) != "raw"])

    dt_page <- try_rbind_page(page)
    classes <- lapply(dt_page, class) == "list"
    cols <- names(classes[classes])
    for(j in cols) data.table::set(dt_page, j = j, value = unlist(dt_page[[j]]))

    if(nrow(dt) == 0){
      dt <- dt_page
    }else{
      dt <- data.table::rbindlist(list(dt, dt_page), use.names=T, fill = T)
    }

    if(verbose)
      cat("\r Found", count, "records...")

    if(length(page) < pagesize)
      break
  }

  if(verbose) cat("\r Imported", count, "records.\n")
  return(dt)
}


