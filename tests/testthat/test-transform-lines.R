context("transform-lines")

all_texts <- list(
  character(),
  letters[1:3],
  "\u00fc",
  "\u4e2d"
)

add_one <- function(x) c(x, "")
remove_one <- function(x) x[-length(x)]

setup_paths <- function(..., text = all_texts) {
  root <- tempfile("utf8")
  dir.create(root)
  f <- function(...) file.path(root, ...)
  paths <- f(letters[seq_along(text)])

  Map(function(x, y) write_lines_enc(x, y, ...), text, paths)
  paths
}

test_that("identity transformation works", {
  paths <- setup_paths()
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  ret <- transform_lines(paths, identity)
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_equal(digest_before, digest_after)
  expect_false(any(ret))
  expect_equal(names(ret), paths)
})

test_that("forward-reverse transformation works for CRLF", {
  paths <- setup_paths(sep = "\r\n")
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  ret <- transform_lines(paths, add_one)
  ret <- transform_lines(paths, remove_one, sep = "\r\n")
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_equal(digest_before, digest_after)
  expect_true(all(ret))
})

test_that("remove transformation works for latin1", {
  paths <- setup_paths(file_encoding = "latin1", text = all_texts[-4])
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  ret <- transform_lines(paths, remove_one, file_encoding = "latin1")
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_equal(digest_before[!ret], digest_after[!ret])
  expect_false(ret[1])
  expect_true(all(ret[-1]))
})

test_that("remove transformation works for GB2312", {
  paths <- setup_paths(file_encoding = "GB2312", text = all_texts[-3])
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  ret <- transform_lines(paths, add_one, file_encoding = "GB2312")
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_true(all(digest_before != digest_after))
  expect_true(all(ret))
})
