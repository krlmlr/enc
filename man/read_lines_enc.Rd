% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/io.R
\name{read_lines_enc}
\alias{read_lines_enc}
\alias{try_read_lines_enc}
\title{Reads from a text file}
\usage{
read_lines_enc(
  path,
  file_encoding = "UTF-8",
  n = -1L,
  ok = TRUE,
  skipNul = FALSE
)

try_read_lines_enc(
  path,
  file_encoding = "UTF-8",
  n = -1L,
  ok = TRUE,
  skipNul = FALSE
)
}
\arguments{
\item{path}{Path to the file}

\item{file_encoding}{The encoding to assume for the input file.}

\item{n}{integer.  The (maximal) number of lines to
    read.  Negative values indicate that one should read up to the end of
    input on the connection.}

\item{ok}{logical.  Is it OK to reach the end of the connection before
    \code{n > 0} lines are read?  If not, an error will be generated.}

\item{skipNul}{logical: should nuls be skipped?}
}
\description{
This function is a drop-in replacement for \code{\link[=readLines]{readLines()}} from disk files.
It always returns text in the UTF-8 encoding and never warns on missing EOL
on the last line.

\code{try_read_lines_enc()} is a variant that returns an
empty character vector on error, with a warning.
}
\seealso{
\code{\link[readr:read_lines]{readr::read_lines()}} for a faster alternative.

Other file functions: 
\code{\link{transform_lines_enc}()},
\code{\link{write_lines_enc}()}
}
\concept{file functions}
