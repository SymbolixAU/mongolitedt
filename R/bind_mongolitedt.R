#' @import mongolite
#' @importFrom Rcpp evalCpp
#' @import data.table
#' @useDynLib mongolitedt
#' @export
bind_mongolitedt <- function(mongo){

  unlock_environment(mongo)

  mongo$finddt <- function(query = '{}', fields = '{"_id":0}', sort = '{}', skip = 0, limit = 0, pagesize = 1000){
    cur <- mongolite:::mongo_collection_find(col, query = query, sort = sort, fields = fields, skip = skip, limit = limit)
    mongo_stream_in_dt(cur, pagesize = pagesize, verbose = verbose)
  }

}
