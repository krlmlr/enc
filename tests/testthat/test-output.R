
test_that("output", {
  expect_identical(format(utf8(c("a", "bc"))), c("a ", "bc"))
})

test_that("print", {
  expect_snapshot({
    print(utf8(c("a", "bc")))
  })
})
