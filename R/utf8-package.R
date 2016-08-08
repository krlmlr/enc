#' @useDynLib utf8, .registration = TRUE, .fixes = "C_"
"_PACKAGE"

#' @export
encoding <- function(x) {
  .Call(C_encoding, x)
}

#' @export
all_utf8 <- function(x) {
  .Call(C_all_utf8, x)
}
