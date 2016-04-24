#' Bind Mongolitedt
#'
#' Binds methods to a \code{mongolite::mongo} object. The data returned from the MongoDB query
#' must be able to be coerced into a \code{data.table}.
#'
#' @param mongo A \code{mongolite::mongo} connection object to which the methods are bound
#' @return mongo The mongo object with additional methods
#' @import mongolite
#' @importFrom Rcpp evalCpp
#' @importFrom data.table rbindlist
#' @useDynLib mongolitedt
#' @aliases mongolitedt
#' @examples
#' \dontrun{
#' ## create mongolite::mongo connection
#' mongo <- mongolite::mongo(collection = "test", db = "test", url = "mongodb://localhost")
#'
#' ## bind mongolitedt methods
#' bind_mongolitedt(mongo)
#'
#' ## finddt
#' mongo$finddt()
#'
#' ## aggregatedt
#' mongo$aggregatedt()
#' }
#' @section Methods:
#' \describe{
#'  \item{\code{aggregatedt(pipeline = '{}', pagesize = 1000)}}{Execute a pipeline using the Mongo aggregation framework. Will return all data as a single data.table}
#'  \item{\code{finddt(query = '{}', fields = '{"_id" : 0}', sort = '{}', skip = 0, limit = 0, pagesize = 1000)}}{Retrieve \code{fields} from records matching \code{query}. Will return all data as a single data.table}
#'  }
#' @export
bind_mongolitedt <- function(mongo){

  ## test mongo is correct type/class/object
  ## sum(class(mongo) %in% c("mongo", "jeroen")) >= 2
  ## inherits(mongo, "mongo")
  ## is(mongo, "mongo")
  unlock_environment(mongo)

  ## assign new finddt function
  mongo$finddt <- function(query = '{}', fields = '{"_id":0}', sort = '{}', skip = 0, limit = 0, pagesize = 1000){
    ##cur <- mongolite:::mongo_collection_find(col, query = query, sort = sort, fields = fields, skip = skip, limit = limit)
    mongo_stream_in_dt()
  }

#   mongo$aggregatedt <- function(pipeline = '{}', pagesize = 1000){
#     cur <- mongolite:::mongo_collection_aggregate(col, pipeline)
#     mongolitedt:::mongo_stream_in_dt(cur, pagesize = pagesize, verbose = verbose)
#   }

    print("exported function\n")
  # environment(mongo$finddt) <- environment(mongo$find)
  # environment(mongo$aggregatedt) <- environment(mongo$find)
}





