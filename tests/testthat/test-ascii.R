context("ascii")

test_that("ASCII encoding detected works", {
  expect_equal(
    Encoding2(c(
      "a",
      iconv("ä", to = "UTF-8"),
      iconv("ä", to = "latin1"),
      as_unknown("ä")
    )),
    c("ASCII", "UTF-8", "latin1", "unknown"))
})
