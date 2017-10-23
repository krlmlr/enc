context("construct")

test_that("can construct from character vector", {
  expect_identical(utf8(letters), as_utf8(letters))
})

test_that("constructor takes only one argument", {
  expect_error(utf8("a", "b"))
})

test_that("constructor coerces to character", {
  expect_identical(utf8(1:3), utf8(as.character(1:3)))
})

test_that("can construct empty utf8", {
  expect_identical(utf8(), as_utf8(character()))
})

test_that("names are UTF8", {
  expect_is(names(utf8(setNames(nm = letters))), "utf8")
})
