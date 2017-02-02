
mojibake <-
  if (tolower(Sys.info()[["sysname"]]) == "windows") {
    # An umlaut and a Chinese character, one of them can't be represented
    # in the native locale
    cand <- c("\u00f6", "\u6210")
    native <- enc2native(cand)
    different <- cand != native
    stopifnot(any(different))
    n
    Encoding(x) <- "latin1"
    x
  } else {
  function() {
      x <- iconv("\u00f6", from = "UTF-8", to = "latin1")
      Encoding(x) <- "UTF-8"
      x
    }
  }
