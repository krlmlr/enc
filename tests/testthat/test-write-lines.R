context("write-lines")

test_that("can write text to output file", {
  root <- tempfile("enc")
  dir.create(root)
  f <- function(...) file.path(root, ...)
  r <- function(...) file.path("output", ...)
  write_lines_enc("ascii", f("ascii.txt"))
  write_lines_enc("ascii", f("ascii-crlf.txt"), sep = "\r\n")
  write_lines_enc("\u00fc", f("latin1-utf8.txt"))
  write_lines_enc("\u00fc", f("latin1-utf8-crlf.txt"), sep = "\r\n")
  write_lines_enc("\u00fc", f("latin1.txt"), file_encoding = "latin1")
  write_lines_enc("\u00fc", f("latin1-crlf.txt"), file_encoding = "latin1", sep = "\r\n")
  write_lines_enc("\u4e2d", f("gb2312-utf8.txt"))
  write_lines_enc("\u4e2d", f("gb2312-utf8-crlf.txt"), sep = "\r\n")
  write_lines_enc("\u4e2d", f("gb2312.txt"), file_encoding = "GB2312")
  write_lines_enc("\u4e2d", f("gb2312-crlf.txt"), file_encoding = "GB2312", sep = "\r\n")

  for (file in dir(f())) {
    eval(bquote(
      expect_equal(digest::digest(file = f(file)), digest::digest(file = .(r(file))))))
  }
})
