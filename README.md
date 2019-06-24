
# enc

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis-CI Build
Status](https://travis-ci.org/krlmlr/enc.svg?branch=master)](https://travis-ci.org/krlmlr/enc)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/krlmlr/enc?branch=master&svg=true)](https://ci.appveyor.com/project/krlmlr/enc)
[![codecov](https://codecov.io/gh/krlmlr/enc/branch/master/graph/badge.svg)](https://codecov.io/gh/krlmlr/enc)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/enc)](https://cran.r-project.org/package=enc)
<!-- badges: end -->

Portable tools for UTF-8 character data

## R and character encoding

The [character
encoding](https://en.wikipedia.org/wiki/Character_encoding) of
determines the translation of the letters, digits, or other codepoints
(atomic components of a text) into a sequence of bytes. A byte sequence
may translate into valid text in one character encoding, but give
nonsense in other character encodings.

For historic reasons, R can store strings in different ways:

1.  in the “native” encoding, the default encoding of the operating
    system
2.  in [UTF-8](https://en.wikipedia.org/wiki/UTF-8), the most prevalent
    and versatile encoding nowadays
3.  in “latin1”, a popular encoding in Western Europe
4.  as “bytes”, leaving the interpretation to the user

On OS X and Linux, the “native” encoding is often UTF-8, but on Windows
it is not. To add to the confusion, the encoding is a property of
individual strings in a character vector, and not of the entire vector.

## Why UTF-8?

When working with text, it is advisable to use UTF-8, because it allows
encoding virtually any text, even in foreign languages that contain
symbols that cannot be represented in your system’s native encoding. The
UTF-8 encoding possesses several nice technical properties, and is by
far the predominant encoding on the Web. Standardization on a
“universal” encoding faciliates data exchange.

Because of R’s special handling of strings, some care must be taken to
make sure that you’re actually using the UTF-8 encoding. Many functions
in R will hide encoding issues from you, and transparently convert to
UTF-8 as necessary. However, some functions (such as reading and writing
files) will stubbornly prefer the native encoding.

The enc package provides helpers for converting all textual components
of an object to UTF-8, and for reading and writing files in UTF-8 (with
a LF end-of-line terminator by default). It also defines an S3 class for
tagging all-UTF-8 character vectors and ensuring that updates maintain
the UTF-8 encoding. Examples for other packages that use UTF-8 by
default are:

  - [readr](http://readr.tidyverse.org/),
    [readxl](http://readxl.tidyverse.org/), and
    [haven](http://haven.tidyverse.org/) for data input and output

  - [stringi](https://cran.r-project.org/package=stringi) and
    [stringr](http://stringr.tidyverse.org/) for string manipulation

  - [testthat](http://testthat.r-lib.org/) and
    [roxygen2](https://cran.r-project.org/package=roxygen2) for package
    development

## Example

``` r
library(enc)
utf8(c("a", "ä"))
#> [1] "a" "ä"
as_utf8(1)
#> [1] "1"

a <- utf8("ä")
a[2] <- "ö"
class(a)
#> [1] "utf8"

data.frame(abc = letters[1:3], utf8 = utf8(letters[1:3]))
#>   abc utf8
#> 1   a    a
#> 2   b    b
#> 3   c    c
```

Install the package from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("krlmlr/enc")
```
