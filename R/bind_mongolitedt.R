#' @export
bind_mongolitedt <- function(){

  ## test mongo is correct type/class/object
  ## sum(class(mongo) %in% c("mongo", "jeroen")) >= 2
  ## inherits(mongo, "mongo")
  ## is(mongo, "mongo")
#  unlock_environment(mongo)

  ## assign new finddt function
#  mongo$finddt <- function(query = '{}', fields = '{"_id":0}', sort = '{}', skip = 0, limit = 0, pagesize = 1000){
    ##cur <- mongolite:::mongo_collection_find(col, query = query, sort = sort, fields = fields, skip = skip, limit = limit)
    mongo_stream_in_dt()
#  }

#   mongo$aggregatedt <- function(pipeline = '{}', pagesize = 1000){
#     cur <- mongolite:::mongo_collection_aggregate(col, pipeline)
#     mongolitedt:::mongo_stream_in_dt(cur, pagesize = pagesize, verbose = verbose)
#   }

  # environment(mongo$finddt) <- environment(mongo$find)
  # environment(mongo$aggregatedt) <- environment(mongo$find)
}





