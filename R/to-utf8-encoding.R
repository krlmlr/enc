#' Deep conversion to an encoding
#'
#' Converts all characters directly or indirectly contained in an object to
#' a specific encoding.
#' \describe{
#'   \item{\code{to_utf8}}{converts to UTF-8, using the \code{\link{utf8}} class
#'     where possible. Implemented as \code{to_encoding(x, as.utf8)}}.
#'   \item{\code{to_native}}{converts to the native encoding.
#'     Implemented as \code{to_encoding(x, enc2native)}}.
#' }
#'
#' @inheritParams base::Encoding
#' @param ... passed on to methods
#' @export
#' @examples
#' to_utf8(letters)
#' to_utf8(iris)
"to_encoding"

#' @rdname to_encoding
#' @export
to_utf8 <- function(x, ...) to_encoding(x, ..., converter = as.utf8)

#' @rdname to_encoding
#' @export
to_native <- function(x, ...) to_encoding(x, ..., converter = enc2native)

to_encoding <- function(x, ...) UseMethod("to_encoding", x)

#' @export
to_encoding.list <- function(x, ...) {
  x[] <- lapply(x, to_encoding, ...)
  names(x) <- to_encoding(names(x), ...)
  attrib_to_encoding(x, ...)
}

#' @export
to_encoding.data.frame <- function(x, ...) {
  to_encoding.list(x, ...)
}

#' @rdname to_encoding
#' @param converter A function that accepts a character value as first argument
#'   and returns a (possibly classed) character with the desired encoding
#' @export
to_encoding.character <- function(x, ..., converter) {
  x <- converter(x)
  attrib_to_encoding(x, ..., converter = converter)
}

#' @export
to_encoding.utf8 <- function(x, ...) {
  to_encoding.default(x)
}

#' @export
to_encoding.default <- function(x, ...) {
  attrib_to_encoding(x, ...)
}

#' @export
to_encoding.NULL <- function(x, ...) {
  NULL
}

attrib_to_encoding <- function(x, ...) {
  mostattributes(x) <- named_to_encoding_except_class(attributes(x), ...)
  x
}

named_to_encoding_except_class <- function(attrib, ..., unclass = FALSE) {
  if (unclass) {
    attrib <- attrib[names(attrib) != "class"]
    is_class <- integer()
  } else {
    is_class <- which(names(attrib) == "class")
  }

  if (length(is_class) > 0) {
    attrib[-is_class] <- to_encoding(unname(attrib)[-is_class], ...)

    # unclass(): The "class" attribute doesn't need to have a class attribute itself
    # unclass = TRUE: To prevent endless recursion
    attrib[[is_class]] <- unclass(to_encoding(unname(attrib)[[is_class]], ..., unclass = TRUE))
  } else {
    attrib <- to_encoding(unname(attrib), ...)
  }

  attrib
}
