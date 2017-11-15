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
  as_utf8(lines)
}

#' @rdname read_lines_enc
#' @description `try_read_lines_enc()` is a variant that returns an
#'   empty character vector on error, with a warning.
#' @export
try_read_lines_enc <- function(path, file_encoding = "UTF-8", n = -1L, ok = TRUE,
                               skipNul = FALSE) {
  tryCatch(
    read_lines_enc(
      path, file_encoding = file_encoding, ok = ok, skipNul = skipNul),
    error = function(e) {
      warning("Cannot read ", path, ": ", conditionMessage(e))
      character()
    }
  )
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
#' @inheritParams read_lines_enc
#' @export
write_lines_enc <- function(text, path, file_encoding = "UTF-8", sep = "\n") {
  raw_data <- get_raw_file_data(as.character(text), file_encoding, sep)
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
#' The line ending separator of the input file is used if it can be read and
#' contains at least one, otherwise [native_eol()] is used.
#'
#' @family file functions
#' @param path A vector of file paths.
#' @param fun A function that returns a character vector.
#' @param write_back Should the results of the transformation be written back
#'   to the file?
#' @param verbose Should the function show a message with a list of changed
#'   files?
#' @return A named logical vector of the same length as `path` that indicates
#'   if a file has changed (`TRUE` or `FALSE`), or if an error occurred (`NA`)
#' @inheritParams base::readLines
#' @inheritParams read_lines_enc
#' @inheritParams write_lines_enc
#' @param file_encoding The encoding to assume for the input file.
#' @export
transform_lines_enc <- function(path, fun, file_encoding = "UTF-8", ok = TRUE,
                                skipNul = FALSE, write_back = TRUE,
                                verbose = interactive()) {
  ret <- vapply(
    stats::setNames(nm = path), transform_lines_enc_one, logical(1L),
    fun = fun, file_encoding = file_encoding, ok = ok, skipNul = skipNul,
    write_back = write_back)

  if (verbose) {
    if (!any(ret, na.rm = TRUE)) {
      message("No files changed.")
    } else {
      message("Files changed: ", ellipsis(names(ret)[which(ret)]))
    }
    invisible(ret)
  } else {
    ret
  }
}

transform_lines_enc_one <- function(path, fun, file_encoding = "UTF-8", ok = TRUE,
                                    skipNul = FALSE, write_back = TRUE) {
  text <- try_read_lines_enc(path, file_encoding = file_encoding, ok = ok, skipNul = skipNul)
  sep <- detect_sep(path)
  tryCatch(
    {
      new_text <- as.character(fun(text))
      if (!isTRUE(identical(unclass(text), unclass(new_text)))) {
        if (write_back) {
          write_lines_enc(new_text, path, file_encoding = file_encoding, sep = sep)
        }
        TRUE
      } else {
        FALSE
      }
    },

    error = function(e) {
      warning("When processing ", path, ": ", conditionMessage(e), call. = FALSE)
      NA
    }
  )
}
