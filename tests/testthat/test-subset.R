context("subset")

test_that("range subsetting keeps class", {
  expect_identical(utf8(1:3)[2], utf8(2))
  expect_identical(utf8(1:3)[2:3], utf8(2:3))
})

test_that("range updating keeps class", {
  x <- utf8(1:3)
  x[2] <- 4
  expect_identical(x, utf8(c(1,4,3)))
  x <- utf8(1:4)
  x[2:3] <- 5:6
  expect_identical(x, utf8(c(1,5,6,4)))
})

test_that("index subsetting keeps class", {
  expect_identical(utf8(1:3)[[2]], utf8(2))
})

test_that("index updating keeps class", {
  x <- utf8(1:3)
  x[[2]] <- 4
  expect_identical(x, utf8(c(1,4,3)))
})
