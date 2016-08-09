context("encoding")

test_that("encoding is always UTF-8", {
  expect_equal(Encoding(utf8("\u00e4")), "UTF-8")
  expect_equal(Encoding(utf8(enc2latin1("\u00e4"))), "UTF-8")
  expect_equal(Encoding(utf8(enc2utf8("\u00e4"))), "UTF-8")
  expect_equal(Encoding(utf8(c(enc2native("\u00e4"), enc2alien("\u00e4")))),
               rep("UTF-8", 2))
})
