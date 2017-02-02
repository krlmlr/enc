#' Reads from a text file
#'
#' This function is a drop-in replacement for [readLines()] from disk files.
#' It always returns text in the UTF-8 encoding and never warns on missing EOL
#' on the last line.
#'
#' @seealso [readr::read_lines()] for a faster alternative.
#' @family file functions
#' @param path Path to the file
#' @inheritParams base::readLines
#' @param file_encoding The encoding to assume for the input file.
#' @export
read_lines_enc <- function(path, file_encoding = "UTF-8", n = -1L, ok = TRUE,
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
#'
#' @seealso [readr::write_lines()] for a faster alternative.
#' @family file functions
#' @param file_encoding The encoding for the output file.
#' @inheritParams base::writeLines
#' @inheritParams read_lines
#' @export
write_lines_enc <- function(text, path, file_encoding = "UTF-8", sep = "\n") {
  raw_data <- get_raw_file_data(text, file_encoding, sep)
  writeBin(raw_data, path)
}

get_raw_file_data <- function(text, file_encoding = "UTF-8", sep = "\n") {
  if (length(text) == 0) return(raw())
  text_enc <- iconv(text, from = "UTF-8", to = file_encoding, toRaw = TRUE)
  sep_enc <- rep(list(charToRaw(sep[[1L]])), length(text_enc))

  text_sep_matrix <- matrix(c(text_enc, sep_enc), nrow = 2, byrow = TRUE)
  unlist(text_sep_matrix)
}

#' Transform a text file
#'
#' Reads a file from disk, applies a function on the contents, and optionally
#' writes the file back if different.
#'
#' @family file functions
#' @param path A vector of file paths.
#' @param fun A function that returns a character vector.
#' @param write_back Should the results of the transformation be written back
#'   to the file?
#' @return A named logical that indicates if the file has changed, NA if an
#'   error occurred
#' @inheritParams base::readLines
#' @inheritParams read_lines_enc
#' @param file_encoding The encoding to assume for the input file.
#' @export
transform_lines <- function(path, fun, file_encoding = "UTF-8", ok = TRUE,
                            skipNul = FALSE, write_back = TRUE) {
  vapply(
    stats::setNames(nm = path), transform_lines_one, logical(1L),
    fun = fun, file_encoding = file_encoding, ok = ok, skipNul = skipNul, write_back = TRUE)
}

transform_lines_one <- function(path, fun, file_encoding = "UTF-8", ok = TRUE,
                                skipNul = FALSE, write_back = TRUE) {
  text <- read_lines_enc(path, file_encoding = file_encoding, ok = ok, skipNul = skipNul)
  new_text <- fun(text)
  if (!isTRUE(identical(text, new_text))) {
    if (write_back) {
      write_lines_enc(path, file_encoding = file_encoding)
    }
    TRUE
  } else {
    FALSE
  }
}
