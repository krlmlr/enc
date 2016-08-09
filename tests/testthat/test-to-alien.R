context("to-alien")

test_that("character vector", {
  expect_identical(to_alien(to_utf8(letters)), to_alien(letters))
  expect_identical(to_alien(to_native(to_utf8(letters))), to_alien(letters))
  expect_identical(to_alien(to_utf8(to_native(letters))), to_alien(letters))
  expect_identical(to_alien(to_native(letters)), to_alien(letters))
})

test_that("iris", {
  expect_identical(to_alien(to_utf8(iris)), to_alien(iris))
  expect_identical(to_alien(to_native(to_utf8(iris))), to_alien(iris))
  expect_identical(to_alien(to_utf8(to_native(iris))), to_alien(iris))
  expect_identical(to_alien(to_native(iris)), to_alien(iris))
})

test_that("mtcars", {
  expect_identical(to_alien(to_utf8(mtcars)), to_alien(mtcars))
  expect_identical(to_alien(to_native(to_utf8(mtcars))), to_alien(mtcars))
  expect_identical(to_alien(to_utf8(to_native(mtcars))), to_alien(mtcars))
  expect_identical(to_alien(to_native(mtcars)), to_alien(mtcars))
})

test_that("umlauts", {
  umlauts <- c("\u00e4", "\u00f6", "\u00fc")

  expect_identical(to_alien(to_utf8(umlauts)), to_alien(umlauts))
  expect_identical(to_alien(to_native(to_utf8(umlauts))), to_alien(umlauts))
  expect_identical(to_alien(to_utf8(to_native(umlauts))), to_alien(umlauts))
  expect_identical(to_alien(to_native(umlauts)), to_alien(umlauts))
})
