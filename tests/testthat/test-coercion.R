context("coercion")

test_that("coercion in", {
  expect_identical(as_utf8("a"), utf8("a"))
  expect_identical(as_utf8("ä"), utf8("ä"))
  expect_identical(as_utf8(1), utf8("1"))
  expect_identical(as_utf8(FALSE), utf8("FALSE"))
})

test_that("coercion out", {
  expect_identical(as.character(utf8("ä")), "ä")
  expect_identical(as_utf8(utf8("ä")), utf8("ä"))
})

test_that("type check", {
  expect_true(is_utf8(utf8("a")))
  expect_true(is_utf8(utf8("ä")))
  expect_false(is_utf8("a"))
  expect_false(is_utf8("ä"))
})

test_that("NULL", {
  expect_null(as_utf8(NULL))
})
