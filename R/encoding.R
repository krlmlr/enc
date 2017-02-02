#' Encoding information
#'
#' The `encoding` function returns `"ASCII"` if the entire value
#' consists of ASCII symbols only, and works identically to
#' [Encoding()] otherwise.
#' The `all_utf8` function is an efficient variant of
#' \code{all(encoding(x) \%in\% c("ASCII", "UTF-8"))}.
#'
#' @inheritParams base::Encoding
#' @export
#' @examples
#' encoding("a")
#' encoding("\u00fc")
#' all_utf8(enc2utf8(c("a", "\u00fc")))
#'
#' # Platform-dependent:
#' all_utf8(enc2native(c("a", "\u00fc")))
encoding <- function(x) {
  .Call(C_encoding, x)
}

#' @rdname encoding
#' @export
all_utf8 <- function(x) {
  .Call(C_all_utf8, x)
}
