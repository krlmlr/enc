context("to-native")

test_that("umlauts", {
  data <- data.frame(a = I(c("o", "u")))
  colnames_utf8 <- "\u00e4"
  colnames_native <- enc2native(colnames_utf8)
  value_utf8 <- c("\u00f6", "\u00fc")
  value_native <- enc2native(value_utf8)

  colnames(data) <- colnames_utf8
  data[[1]] <- value_utf8

  data_native <- to_native(data)
  expect_equal(Encoding(colnames(data_native)), Encoding(colnames_native))
  expect_equal(Encoding(data_native[[1]]), Encoding(value_native))
  attribute_names <- names(attributes(data_native))
  expect_equal(Encoding(attribute_names), Encoding(enc2native(attribute_names)))
})
