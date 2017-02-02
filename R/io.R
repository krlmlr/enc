#' Reads from a text file
#'
#' This function is a drop-in replacement for [readLines()] from disk files.
#' It always returns text in the UTF-8 encoding and never warns on missing EOL
#' on the last line.
#' @param path Path to the file.
#' @inheritParams base::readLines
#' @export
read_lines <- function(path, file_encoding = "UTF-8", n = -1L, ok = TRUE,
                       skipNul = FALSE) {
  con <- file(path, encoding = file_encoding)
  on.exit(close(con), add = TRUE)

  lines <- readLines(
    con, warn = FALSE, n = n, ok = ok, skipNul = skipNul, encoding = "UTF-8")
  Encoding(lines) <- "UTF-8"
  lines
}
