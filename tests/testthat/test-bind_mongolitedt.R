context("Bind mongolitedt")


skip_mongo_connection <- function() {
  skip("mongodb connection not available")
}

test_that("mongolitedt correctly bound", {

  skip_mongo_connection()

  mongo <- mongolite::mongo(collection = "test",
                            db = "test",
                            url = "mongodb://localhost")

  bind_mongolitedt(mongo)

  expect_true(is.function(mongo$finddt))

})


