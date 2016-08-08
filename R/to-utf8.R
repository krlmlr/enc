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

to_utf8.data.frame <- to_utf8.list

to_utf8.character <- function(x, ..., use_class = TRUE) {
  if (use_class)
    x <- as.utf8(x)
  else
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
  mostattributes(x) <- named_to_utf8_except_class(attributes(x))
  x
}

named_to_utf8_except_class <- function(attrib) {
  is_class <- which(names(attrib) == "class")
  if (length(is_class) > 0) {
    attrib[-is_class] <- to_utf8(unname(attrib)[-is_class])
    attrib[[is_class]] <- to_utf8(unname(attrib)[[is_class]], use_class = FALSE)
  } else {
    attrib <- to_utf8(unname(attrib))
  }

  attrib
}
