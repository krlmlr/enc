detect_sep <- function(path) {
  con <- file(path, "rb")
  on.exit(close(con), add = TRUE)

  repeat {
    byte <- readBin(con, raw(1L))
    if (length(byte) == 0) return(native_sep())
    if (byte == 0x0d) return("\r\n")
    if (byte == 0x0a) return("\n")
  }
}

native_sep <- if (.Platform$OS.type == "windows") {
  function() "\r\n"
} else {
  function() "\n"
}
