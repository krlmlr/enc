context("to-utf8")

test_that("character vectors", {
  expect_is(to_utf8(letters), "utf8")
  expect_false(inherits(class(to_utf8(letters)), "utf8"))
})

test_that("iris", {
  iris_utf8 <- to_utf8(iris)
  expect_is(colnames(iris_utf8), "utf8")
  expect_true(all_utf8(names(attributes(iris_utf8))))
  expect_is(levels(iris_utf8$Species), "utf8")
})

test_that("mtcars", {
  mtcars_utf8 <- to_utf8(mtcars)
  expect_is(colnames(mtcars_utf8), "utf8")
  expect_true(all_utf8(names(attributes(mtcars_utf8))))
  expect_true(all_utf8(rownames(mtcars_utf8)))
})

test_that("umlauts", {
  data <- data.frame(a = I(c("o", "u")))
  colnames_utf8 <- "\u00e4"
  colnames_native <- enc2native(colnames_utf8)
  value_utf8 <- c("\u00f6", "\u00fc")
  value_native <- enc2native(value_utf8)

  colnames(data) <- colnames_native
  data[[1]] <- colnames_native

  data_utf8 <- to_utf8(data)
  expect_is(colnames(data_utf8), "utf8")
  expect_true(all_utf8(names(attributes(data_utf8))))
})
