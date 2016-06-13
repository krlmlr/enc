context("output")

test_that("output", {
  expect_identical(format(utf8(c("a", "bc"))), c("a ", "bc"))
})

test_that("output", {
  expect_output_file(print(utf8(c("a", "bc"))), "output/abc.txt", update = TRUE)
})
