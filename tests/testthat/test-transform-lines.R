context("transform-lines")

all_texts <- list(
  character(),
  letters[1:3],
  "\u00fc",
  "\u4e2d"
)

all_texts_length_two <- list(
  rep("\u00fc", 3),
  rep("ab", 2),
  rep("\u4e2d", 2)
)

add_one <- function(x) c(x, "")
remove_one <- function(x) x[-length(x)]
error_if_long <- function(x) {
  len_x <- length(x)
  if (len_x > 2) {
    stop()
  } else if (len_x > 1) {
    x
  } else {
    add_one(x)
  }
}

setup_paths <- function(..., text = all_texts) {
  root <- tempfile("enc")
  dir.create(root)
  f <- function(...) file.path(root, ...)
  paths <- f(letters[seq_along(text)])

  Map(function(x, y) write_lines_enc(x, y, ...), text, paths)
  paths
}

test_that("identity transformation works", {
  paths <- setup_paths()
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_message(
    ret <- transform_lines_enc(paths, identity, verbose = TRUE),
    "No files changed"
  )
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_equal(digest_before, digest_after)
  expect_false(any(ret))
  expect_equal(names(ret), paths)
})

test_that("errors are caught and returned as NA if some files are transformerd", {
  paths <- setup_paths()
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_warning(
    ret <- transform_lines_enc(paths, error_if_long),
    "When processing")
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_equal(digest_before[is.na(ret)], digest_after[is.na(ret)])
  expect_true(is.na(ret[2]))
  expect_true(all(ret[-2]))
})

test_that("errors are caught and returned as NA if no files are transformerd", {
  paths <- setup_paths(text = all_texts_length_two)
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_warning(
    ret <- transform_lines_enc(paths, error_if_long),
    "When processing")
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_equal(digest_before[is.na(ret)], digest_after[is.na(ret)])
  expect_true(is.na(ret[1]))
  expect_true(all(!ret[-1]))
})


test_that("forward-reverse transformation works for CRLF", {
  paths <- setup_paths(sep = "\r\n")
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  ret <- transform_lines_enc(paths, add_one)
  expect_message(
    ret <- transform_lines_enc(paths, remove_one, verbose = TRUE),
    paste0("Files changed: ", paths[ret][[1]]),
    fixed = TRUE
  )
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_equal(digest_before, digest_after)
  expect_true(all(ret))
})

test_that("remove transformation works for latin1", {
  paths <- setup_paths(file_encoding = "latin1", text = all_texts[-4])
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  ret <- transform_lines_enc(paths, remove_one, file_encoding = "latin1")
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_equal(digest_before[!ret], digest_after[!ret])
  expect_false(ret[1])
  expect_true(all(ret[-1]))
})

test_that("remove transformation works for GB2312", {
  paths <- setup_paths(file_encoding = "GB2312", text = all_texts[-3])
  digest_before <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  ret <- transform_lines_enc(paths, add_one, file_encoding = "GB2312")
  digest_after <- vapply(paths, function(x) digest::digest(file = x), character(1L))
  expect_true(all(digest_before != digest_after))
  expect_true(all(ret))
})

test_that("transform missing file", {
  path <- tempfile("enc")
  expect_warning(
    expect_true(transform_lines_enc(path, add_one)),
    "cannot open file")
  expect_warning(transform_lines_enc(path, identity), NA)
})
