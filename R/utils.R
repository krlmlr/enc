ellipsis <- function(x) {
  N <- 6
  if (length(x) > N) {
    x <- c(x[seq_len(N)], paste0("... (", length(x), " total)"))
  }
  paste(x, collapse = ", ")
}
