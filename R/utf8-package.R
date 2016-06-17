#' @useDynLib utf8, .registration = TRUE, .fixes = "C_"
"_PACKAGE"

#' @export
Encoding2 <- function(x) {
  .Call(C_encoding, x)
}
