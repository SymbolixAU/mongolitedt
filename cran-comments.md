## Test environments

* local OS X install, R 3.3.0
* ubuntu 12.04 (on travis-ci), R 3.3.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 2 notes

### Explanation of Notes

**"Unexported objects imported by ':::' calls"**

This package (**mongolitedt**) binds new methods to an object created from **mongolite**.

The function `m <- mongolite::mongo()` creates a connection object (`m`) to a **mongodb** database.
`m` has associated methods and is in a locked environment.

The function in this package, `bind_mongolitedt()` unlocks the environment around `m` so it can attach two new methods. Unlocking the environment means I need to use `:::` to call internal functions.

**"Undefined global functions or variables: verbose"**

The initial call to the `mongolite::mongo()` function takes 4 arguments: `mongolite::mongo(collection, db, url, verbose)`, which are then used by the methods assigned to the mongo object (`m`)

The `verbose` argument is thefore defined in the **mongolite** package, and so is not defined in this package.


