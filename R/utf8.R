#' @importFrom methods setOldClass
setOldClass(c("utf8", "character"))

#' A simple class for storing UTF-8 strings
#'
#' The values are stored as a [character()] vector.
#' On construction, the [enc2utf8()] function is called on the
#' input.  Subsetting and concatenation operations on an object of this class
#' return an object of this class again.
#' Calls to [Encoding<-()] are not intercepted.
#'
#' @name utf8
#' @examples
#' utf8(letters)
#' utf8("ä")
#' utf8(iconv("ä", to = "latin1"))
NULL

# Construction ------------------------------------------------------------

#' @rdname utf8
#' @param x A vector
#' @export
utf8 <- function(x = character()) {
  as_utf8(x)
}

#' @rdname utf8
#' @export
is_utf8 <- function(x) inherits(x, "utf8")

# Coercion in -------------------------------------------------------------

#' @rdname utf8
#' @param ... Arguments passed on to further methods.
#' @export
as_utf8 <- function(x, ...) UseMethod("as_utf8", x)

#' @rdname utf8
#' @export
as_utf8.default <- function(x, ...) {
  as_utf8(as.character(x))
}

#' @rdname utf8
#' @export
as_utf8.NULL <- function(x, ...) {
  NULL
}

#' @rdname utf8
#' @export
as_utf8.character <- function(x, ...) {
  structure(enc2utf8(x), names = as_utf8(names(x)), class = "utf8")
}

#' @rdname utf8
#' @export
as_utf8.utf8 <- function(x, ...) {
  x
}


# Coercion out ------------------------------------------------------------

#' @rdname utf8
#' @export
as.character.utf8 <- function(x, ...) {
  unclass(x)
}

#' @rdname utf8
#' @inheritParams base::as.data.frame
#' @param nm Name of column in new data frame
#' @export
as.data.frame.utf8 <- forward_to(as.data.frame.difftime)


# Subsetting --------------------------------------------------------------

#' @export
`[[.utf8` <- function(x, ...) {
  utf8(NextMethod())
}

#' @export
`[.utf8` <- function(x, ...) {
  utf8(NextMethod())
}


# Updating ----------------------------------------------------------------

#' @export
`[[<-.utf8` <- function(x, i, value) {
  value <- as_utf8(value)
  structure(NextMethod(), class = "utf8")
}

#' @export
`[<-.utf8` <- function(x, i, j, ..., value) {
  value <- as_utf8(value)
  structure(NextMethod(), class = "utf8")
}

#' @export
c.utf8 <- function(x, ..., recursive = FALSE) {
  as_utf8(NextMethod())
}

#' @export
`names<-.utf8` <- function(x, value) {
  attr(x, "names") <- as_utf8(value)
  x
}


# Output ------------------------------------------------------------------

#' @rdname utf8
#' @export
format.utf8 <- function(x, ...) {
  format(as.character(x), ...)
}

#' @rdname utf8
#' @export
print.utf8 <- function(x, ...) {
  print(as.character(x), ...)
  invisible(x)
}

type_sum.utf8 <- function(x) {
  "utf8"
}
