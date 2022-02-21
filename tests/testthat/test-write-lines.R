test_that("sanity check", {
  expect_snapshot({
    charToRaw("\n")
    charToRaw("\r")
    charToRaw("\r\n")
  })
})

test_that("can write text to output file", {
  path <- tempfile("enc")

  test_write_lines_enc <- function(...) {
    write_lines_enc(path = path, ...)
    readBin(path, raw(1), 100)
  }

  expect_snapshot({
    test_write_lines_enc("ascii")
    test_write_lines_enc("ascii", sep = "\r\n")
    test_write_lines_enc("\u00fc")
    test_write_lines_enc("\u00fc", sep = "\r\n")
    test_write_lines_enc("\u00fc", file_encoding = "latin1")
    test_write_lines_enc("\u00fc", file_encoding = "latin1", sep = "\r\n")
    test_write_lines_enc("\u4e2d")
    test_write_lines_enc("\u4e2d", sep = "\r\n")
    test_write_lines_enc("\u4e2d", file_encoding = "GB2312")
    test_write_lines_enc("\u4e2d", file_encoding = "GB2312", sep = "\r\n")
  })
})
