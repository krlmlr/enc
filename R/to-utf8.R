#' Deep conversion to UTF-8
#'
#' Converts all characters directly or indirectly contained in an object to
#' UTF-8.
to_utf8 <- function(x, ...) UseMethod("to_utf8", x)

to_utf8.utf8 <- function(x, ...) {
  attrib_to_utf8(x)
}

to_utf8.list <- function(x, ...) {
  x[] <- lapply(x, to_utf8)
  names(x) <- to_utf8(names(x))
  attrib_to_utf8(x)
}

to_utf8.character <- function(x, ...) {
  x <- enc2utf8(x)
  attrib_to_utf8(x)
}

to_utf8.default <- function(x, ...) {
  attrib_to_utf8(x)
}

to_utf8.NULL <- function(x, ...) {
  NULL
}

attrib_to_utf8 <- function(x) {
  attrib <- attributes(x)
  attrib[] <- to_utf8(unname(attrib))
  mostattributes(x) <- attrib
  x
}
