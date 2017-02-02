context("transform-lines")

test_that("identity transformation works", {
  text <- list(
    character(),
    "\u00fc",
    "\u4e2d",
    letters[1:3]
  )

  root <- tempfile("utf8")
  dir.create(root)
  f <- function(...) file.path(root, ...)
  paths <- f(letters[seq_along(text)])

  Map(write_lines_enc, text, paths)
  digest_before <- vapply(paths, digest::digest, character(1L))
  ret <- transform_lines(paths, identity)
  digest_after <- vapply(paths, digest::digest, character(1L))
  expect_equal(digest_before, digest_after)
  expect_false(any(ret))
  expect_equal(names(ret), paths)
})
