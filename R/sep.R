detect_sep <- function(path) {
  # Eats all errors, but is called only in transform_lines_enc(),
  # which already warns if file can't be opened
  con <- tryCatch(
    file(path, "rb"),
    error = function(e) {
      NULL
    }
  )

  if (is.null(con)) return(native_eol())

  on.exit(close(con), add = TRUE)

  repeat {
    byte <- readBin(con, raw(1L))
    if (length(byte) == 0) return(native_eol())
    if (byte == 0x0d) return("\r\n")
    if (byte == 0x0a) return("\n")
  }
}

#' The native end-of-line identifier on the current platform
#'
#' Returns CRLF on Windows and LF on Linux/OS X.
#' @keywords internal
native_eol <- if (.Platform$OS.type == "windows") {
  function() "\r\n"
} else {
  function() "\n"
}
