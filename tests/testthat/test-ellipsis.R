context("ellipsis")

test_that("ellipsis", {
  expect_equal(ellipsis(letters[1:3]), "a, b, c")
  expect_equal(ellipsis(letters), "a, b, c, d, e, f, ... (26 total)")
})
