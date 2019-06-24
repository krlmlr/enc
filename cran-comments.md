Minor release to address CRAN failures and upstream changes.

## Test environments

* local Ubuntu 18.04 install, R 3.6.0
* ubuntu 16.04 (on travis-ci), R-devel, R-release, R-oldrel
* win-builder (devel, release, and oldrel)

## R CMD check results

OK (NOTE on win-builder regarding TLS protocol version: https://win-builder.r-project.org/9JIR9W601n41/00check.log, can't replicate)

## Downstream dependency

roxygen2md works with the submitted version of enc.
