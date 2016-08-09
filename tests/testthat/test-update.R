context("update")

test_that("Update keeps encoding", {
  x <- utf8(c("a", "\u00e4"))

  x2 <- x
  x2[2] <- "\u00e4"
  expect_identical(x, x2)

  x2 <- x
  x2[2] <- to_latin1("\u00e4")
  expect_identical(x, x2)

  x2 <- x
  x2[[2]] <- "\u00e4"
  expect_identical(x, x2)

  x2 <- x
  x2[[2]] <- to_latin1("\u00e4")
  expect_identical(x, x2)
})

test_that("Concatenation keeps encoding", {
  expect_is(c(utf8("\u00e4"), "a"), "utf8")
})

test_that("Updating names keeps encoding", {
  x <- utf8(setNames(nm = "\u00e4"))
  expect_identical(names(x), utf8("\u00e4"))
  names(x) <- to_alien("\u00f6")
  expect_identical(names(x), utf8("\u00f6"))
})
