#' Deep conversion to an encoding
#'
#' Converts all characters directly or indirectly contained in an object to
#' a specific encoding.
#' This works even if the encoding is different in the elements of a character
#' vector.
#'
#' \describe{
#'   \item{`to_utf8`}{converts to UTF-8, using the [utf8()] class
#'     where possible. Implemented as `to_encoding(x, as_utf8)`}
#'   \item{`to_native`}{converts to the native encoding.
#'     Implemented as `to_encoding(x, enc2native)` on Windows
#'     and as `to_encoding(x, as_utf8)` on Linux and OS X}
#'   \item{`to_latin1`}{converts to the latin-1 encoding}
#'   \item{`to_alien`}{converts to the "other" encoding, i.e.,
#'     UTF-8 on Windows and latin-1 on Linux and OS X.}
#' }
#'
#' @inheritParams base::Encoding
#' @param ... passed on to methods
#' @seealso
#' - [rlang::as_utf8_character()] and [iconv()] for different ways to convert
#'   character vectors to Unicode
#' @export
#' @examples
#' to_utf8(letters)
#' to_utf8(iris)
#' class(levels(to_utf8(iris)$Species))
"to_encoding"

#' @rdname to_encoding
#' @export
to_utf8 <- function(x, ...) to_encoding(x, ..., converter = as_utf8)

iconv_to_native <- if (.Platform$OS.type == "windows") {
  function(x, ...) enc2native(as.character(x))
} else {
  function(x, ...) as_utf8(x)
}

#' @rdname to_encoding
#' @export
to_native <- function(x, ...) to_encoding(x, ..., converter = iconv_to_native)

iconv_to_latin1 <- function(x) {
  unclass(vapply(x, function(xx) iconv(xx, from = encoding(xx), to = "latin1"),
                 character(1L), USE.NAMES = FALSE))
}

#' @rdname to_encoding
#' @export
to_latin1 <- function(x, ...) to_encoding(x, ..., converter = iconv_to_latin1)

iconv_to_alien <- if (.Platform$OS.type == "windows") {
  function(x, ...) as_utf8(x)
} else {
  function(x, ...) iconv_to_latin1(x)
}

#' @rdname to_encoding
#' @export
to_alien <- function(x, ...) to_encoding(x, ..., converter = iconv_to_alien)

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
to_encoding.utf8 <- function(x, ..., converter) {
  if (identical(converter, as_utf8))
    to_encoding.default(x, ..., converter = converter)
  else
    to_encoding.character(x, ..., converter = converter)
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
