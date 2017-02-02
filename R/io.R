#' Reads from a text file
#'
#' This function is a drop-in replacement for [readLines()] from disk files.
#' It always returns text in the UTF-8 encoding and never warns on missing EOL
#' on the last line.
#' @param path Path to the file.
#' @inheritParams base::readLines
#' @param file_encoding The encoding to assume for the input file.
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

#' Writes to a text file
#'
#' This function is a drop-in replacement for [writeLines()] from disk files.
#' It always expects text in the UTF-8 encoding, and by default writes in the
#' UTF-8 encoding with Unix line separators.
#' @param path Path to the file.
#' @param file_encoding The encoding for the output file.
#' @inheritParams base::writeLines
#' @export
write_lines <- function(text, path, file_encoding = "UTF-8", sep = "\n") {
  raw_data <- get_raw_file_data(text, file_encoding, sep)
  writeBin(raw_data, path)
}

get_raw_file_data <- function(text, file_encoding = "UTF-8", sep = "\n") {
  text_enc <- iconv(text, from = "UTF-8", to = file_encoding, toRaw = TRUE)
  sep_enc <- rep(list(charToRaw(sep[[1L]])), length(text_enc))

  text_sep_matrix <- matrix(c(text_enc, sep_enc), nrow = 2, byrow = TRUE)
  unlist(text_sep_matrix)
}
