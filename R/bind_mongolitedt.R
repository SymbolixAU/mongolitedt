#' @import mongolite
#' @importFrom Rcpp evalCpp
#' @export
bind_mongolitedt <- function(mongo, unlock = TRUE){

  if(unlock){
    R_unlock_environment(mongo)

    mongo$finddt <- function(query = '{}', fields = '{"_id":0}', sort = '{}', skip = 0, limit = 0, pagesize = 1000){
 #     cur <- mongolite:::mongo_collection_find(col, query = query, sort = sort, fields = fields, skip = skip, limit = limit)
      mongo_stream_in_dt(cur, pagesize = pagesize, verbose = verbose)
    }

    environment(mongo$finddt) <- environment(mongo$find)

  }else{
    mongo_stream_in_dt()
  }



}
