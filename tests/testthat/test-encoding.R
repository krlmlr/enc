context("encoding")

test_that("encoding is always UTF-8", {
  expect_equal(Encoding(utf8("ä")), "UTF-8")
  expect_equal(Encoding(utf8(iconv("ä", to = "latin1"))), "UTF-8")
  expect_equal(Encoding(utf8(iconv("ä", to = "utf-8"))), "UTF-8")
})

test_that("encoding cannot be reset", {
  a <- utf8("ä")
  expect_warning(Encoding(a) <- "latin1", "cannot change")

  a <- utf8("ä")
  expect_warning(Encoding(a) <- "unknown", "cannot change")

  a <- utf8("ä")
  expect_warning(Encoding(a) <- "bogus", "cannot change")

  a <- utf8("ä")
  Encoding(a) <- "UTF-8"
  expect_identical(a, utf8("ä"))
})
