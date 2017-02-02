context("read-lines")

test_that("can read latin1 files", {
  latin1 <- read_lines_enc("input/latin1.txt", file_encoding = "latin1")
  utf8 <- read_lines_enc("input/latin1-utf8.txt")
  expect_identical(latin1, utf8)
  expect_identical(encoding(latin1), encoding(utf8))
})

test_that("can read GB2312 files", {
  gb2312 <- read_lines_enc("input/gb2312.txt", file_encoding = "GB2312")
  utf8 <- read_lines_enc("input/gb2312-utf8.txt")
  expect_identical(gb2312, utf8)
  expect_identical(encoding(gb2312), encoding(utf8))
})
