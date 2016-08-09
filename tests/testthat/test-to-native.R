context("to-native")

test_that("character vector", {
  expect_identical(to_native(to_utf8(letters)), to_native(letters))
  expect_identical(to_native(to_alien(to_utf8(letters))), to_native(letters))
  expect_identical(to_native(to_utf8(to_alien(letters))), to_native(letters))
  expect_identical(to_native(to_alien(letters)), to_native(letters))
})

test_that("iris", {
  expect_identical(to_native(to_utf8(iris)), to_native(iris))
  expect_identical(to_native(to_alien(to_utf8(iris))), to_native(iris))
  expect_identical(to_native(to_utf8(to_alien(iris))), to_native(iris))
  expect_identical(to_native(to_alien(iris)), to_native(iris))
})

test_that("mtcars", {
  expect_identical(to_native(to_utf8(mtcars)), to_native(mtcars))
  expect_identical(to_native(to_alien(to_utf8(mtcars))), to_native(mtcars))
  expect_identical(to_native(to_utf8(to_alien(mtcars))), to_native(mtcars))
  expect_identical(to_native(to_alien(mtcars)), to_native(mtcars))
})

test_that("umlauts", {
  umlauts <- c("\u00e4", "\u00f6", "\u00fc")

  expect_identical(to_native(to_utf8(umlauts)), to_native(umlauts))
  expect_identical(to_native(to_alien(to_utf8(umlauts))), to_native(umlauts))
  expect_identical(to_native(to_utf8(to_alien(umlauts))), to_native(umlauts))
  expect_identical(to_native(to_alien(umlauts)), to_native(umlauts))
})
