context("update")

test_that("Update keeps encoding", {
  x <- utf8(c("a", "\u00e4"))

  x2 <- x
  x2[2] <- "\u00e4"
  expect_identical(x, x2)

  x2 <- x
  x2[2] <- iconv("\u00e4", to = "latin1")
  expect_identical(x, x2)

  x2 <- x
  x2[2] <- iconv("\u00e4", to = "utf8")
  expect_identical(x, x2)

  x2 <- x
  x2[[2]] <- "\u00e4"
  expect_identical(x, x2)

  x2 <- x
  x2[[2]] <- iconv("\u00e4", to = "latin1")
  expect_identical(x, x2)

  x2 <- x
  x2[[2]] <- iconv("\u00e4", to = "utf8")
  expect_identical(x, x2)
})

test_that("Concatenation keeps encoding", {
  expect_is(c(utf8("\u00e4"), "a"), "utf8")
})
