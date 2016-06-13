context("update")

test_that("Update keeps encoding", {
  x <- utf8(c("a", "ä"))

  x2 <- x
  x2[2] <- "ä"
  expect_identical(x, x2)

  x2 <- x
  x2[2] <- iconv("ä", to = "latin1")
  expect_identical(x, x2)

  x2 <- x
  x2[2] <- iconv("ä", to = "utf8")
  expect_identical(x, x2)

  x2 <- x
  x2[[2]] <- "ä"
  expect_identical(x, x2)

  x2 <- x
  x2[[2]] <- iconv("ä", to = "latin1")
  expect_identical(x, x2)

  x2 <- x
  x2[[2]] <- iconv("ä", to = "utf8")
  expect_identical(x, x2)
})
