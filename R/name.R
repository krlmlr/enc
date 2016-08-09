methods::setOldClass(c("utf8_name", "name"))

#' A simple class for storing UTF-8 encoded language symbols
#'
#' R assumes that language symbols are encoded in the "native" encoding,
#' but \code{\link[base]{as.name}} ignores the declared encoding of the input.
#' This class works around that problem by wrapping the \code{name} class
#' and providing suitable conversion functions, providing UTF-8 encoded language
#' symbols regardless of the native encoding
#'
#' @name utf8_name
#' @examples
#' utf8_name("a")
#' utf8_name("ä")
#' utf8_name(to_latin1("ä"))
NULL

# Construction ------------------------------------------------------------

#' @rdname utf8_name
#' @param x An atomic character value
#' @export
utf8_name <- function(x) {
  as.utf8_name(x)
}

#' @rdname utf8_name
#' @export
is.utf8_name <- function(x) inherits(x, "utf8_name")

# Coercion in -------------------------------------------------------------

#' @rdname utf8_name
#' @param ... Arguments passed on to further methods.
#' @export
as.utf8_name <- function(x, ...) UseMethod("as.utf8_name", x)

#' @rdname utf8_name
#' @export
as.utf8_name.default <- function(x, ...) {
  as.utf8_name(as.character(x))
}

#' @rdname utf8_name
#' @export
as.utf8_name.character <- function(x, ...) {
  structure(as.name(enc2utf8(x)), class = "utf8_name")
}

#' @rdname utf8_name
#' @export
as.utf8_name.utf8_name <- function(x, ...) {
  x
}

# Coercion out ------------------------------------------------------------

#' @rdname utf8_name
#' @export
as.character.utf8_name <- function(x, ...) {
  x <- as.character(unclass(x))
  Encoding(x) <- "UTF-8"
  x
}

#' @rdname utf8_name
#' @export
as.utf8.utf8_name <- function(x, ...) {
  as.utf8(as.character(x))
}

#' @rdname utf8_name
#' @export
as.name.utf8_name <- function(x, ...) {
  as.name(enc2native(as.character(x)))
}

# Output ------------------------------------------------------------------

#' @rdname utf8_name
#' @export
print.utf8_name <- function(x, ...) {
  cat(tickit(as.character(x)), "\n", sep = "")
  invisible(x)
}

is_syntactic <- function(x) make.names(x) == x

tickit <- function(x) {
  needs_ticks <- !is_syntactic(x)
  x[needs_ticks] <- paste0("`", gsub("`", "\\\\`", x[needs_ticks]), "`")
  x
}
