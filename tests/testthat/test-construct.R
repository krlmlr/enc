context("construct")

test_that("can construct from character vector", {
  expect_identical(utf8(letters), as.utf8(letters))
})

test_that("constructor takes only one argument", {
  expect_error(utf8("a", "b"))
})

test_that("can construct empty utf8", {
  expect_identical(utf8(), as.utf8(character()))
})
