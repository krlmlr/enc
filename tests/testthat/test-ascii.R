context("ascii")

test_that("ASCII encoding detected works", {
  expect_equal(
    encoding(c(
      "a",
      iconv("ä", to = "UTF-8"),
      iconv("ä", to = "latin1"),
      as_unknown("ä")
    )),
    c("ASCII", "UTF-8", "latin1", "unknown"))
})

test_that("encoding() accepts only character vectors", {
  expect_error(encoding(1:3), "character vector")
})

test_that("all_utf8()", {
  expect_true(all_utf8(character()))
  expect_true(all_utf8("a"))
  expect_true(all_utf8(iconv("ä", to = "UTF-8")))
  expect_true(all_utf8(c("a", iconv("ä", to = "UTF-8"))))
  expect_false(all_utf8(iconv("ä", to = "latin1")))
  expect_false(all_utf8(c("a", iconv("ä", to = "latin1"))))
  expect_false(all_utf8(c("a", as_unknown("ä"))))
})

test_that("all_utf8() accepts only character vectors", {
  expect_error(all_utf8(1:3), "character vector")
})
