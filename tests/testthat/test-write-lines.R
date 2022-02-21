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

  ascii <- "ascii"
  u_umlaut <- "\u00fc"
  middle <- "\u4e2d"

  expect_snapshot({
    test_write_lines_enc(ascii)
    test_write_lines_enc(ascii, sep = "\r\n")
    test_write_lines_enc(u_umlaut)
    test_write_lines_enc(u_umlaut, sep = "\r\n")
    test_write_lines_enc(u_umlaut, file_encoding = "latin1")
    test_write_lines_enc(u_umlaut, file_encoding = "latin1", sep = "\r\n")
    test_write_lines_enc(middle)
    test_write_lines_enc(middle, sep = "\r\n")
    test_write_lines_enc(middle, file_encoding = "GB2312")
    test_write_lines_enc(middle, file_encoding = "GB2312", sep = "\r\n")
  })
})
