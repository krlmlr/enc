context("output")

test_that("output", {
  expect_identical(format(utf8(c("a", "bc"))), c("a ", "bc"))
})
