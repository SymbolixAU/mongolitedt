#' Bind_mongolitedt
#'
#' Bind functions to a mongolite::mongo object
#' @param mongo A mongolite::mongo connection object to which the functions are bound
#' @return mongo The mongo object with additional functions
#' @export
bind_mongolitedt <- function(mongo){

  ## test mongo is correct type/class/object

  ## Rcpp::sourceCpp('./src/unlock.cpp')
  unlock_environment(mongo)

  ## assign new finddt function
  mongo$finddt <- function(query = '{}', fields = '{"_id":0}', sort = '{}', skip = 0, limit = 0, pagesize = 1000){
    cur <- mongo_collection_find(col, query = query, sort = sort, fields = fields, skip = skip, limit = limit)
    mongo_stream_in_dt(cur, pagesize = pagesize, verbose = verbose)
  }

  mongo$aggregatedt <- function(pipeline = '{}', pagesize = 1000){
    cur <- mongo_collection_aggregate(col, pipeline)
    mongo_stream_in_dt(cur, pagesize = pagesize, verbose = verbose)
  }

  environment(mongo$finddt) <- environment(mongo$find)
  environment(mongo$aggregatedt) <- environment(mongo$find)
}






