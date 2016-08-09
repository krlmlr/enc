context("to-latin1")

test_that("character vector", {
  expect_identical(to_latin1(to_utf8(letters)), to_latin1(letters))
  expect_identical(to_latin1(to_alien(to_utf8(letters))), to_latin1(letters))
  expect_identical(to_latin1(to_utf8(to_alien(letters))), to_latin1(letters))
  expect_identical(to_latin1(to_alien(letters)), to_latin1(letters))
})

test_that("iris", {
  expect_identical(to_latin1(to_utf8(iris)), to_latin1(iris))
  expect_identical(to_latin1(to_alien(to_utf8(iris))), to_latin1(iris))
  expect_identical(to_latin1(to_utf8(to_alien(iris))), to_latin1(iris))
  expect_identical(to_latin1(to_alien(iris)), to_latin1(iris))
})

test_that("mtcars", {
  expect_identical(to_latin1(to_utf8(mtcars)), to_latin1(mtcars))
  expect_identical(to_latin1(to_alien(to_utf8(mtcars))), to_latin1(mtcars))
  expect_identical(to_latin1(to_utf8(to_alien(mtcars))), to_latin1(mtcars))
  expect_identical(to_latin1(to_alien(mtcars)), to_latin1(mtcars))
})

test_that("umlauts", {
  umlauts <- c("\u00e4", "\u00f6", "\u00fc")

  expect_identical(to_latin1(to_utf8(umlauts)), to_latin1(umlauts))
  expect_identical(to_latin1(to_alien(to_utf8(umlauts))), to_latin1(umlauts))
  expect_identical(to_latin1(to_utf8(to_alien(umlauts))), to_latin1(umlauts))
  expect_identical(to_latin1(to_alien(umlauts)), to_latin1(umlauts))
})
