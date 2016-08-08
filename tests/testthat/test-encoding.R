context("encoding")

test_that("encoding is always UTF-8", {
  expect_equal(Encoding(utf8("ä")), "UTF-8")
  expect_equal(Encoding(utf8(iconv("ä", to = "latin1"))), "UTF-8")
  expect_equal(Encoding(utf8(iconv("ä", to = "utf-8"))), "UTF-8")
})
