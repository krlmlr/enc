## enc 0.0-17 (2017-11-10)

- Prepare CRAN release.


## enc 0.0-16 (2017-10-23)

- Test up to and including R 3.1.


## enc 0.0-15 (2017-10-23)

- All methods now use snake_case.
- Use the tic package for testing.


## enc 0.0-11 (2017-08-22)

- More robust handling if only some files could be transformed in `transform_lines_enc()` (#16, @lorenzwalthert).
- Fix `write_back` argument to `transform_lines_enc()` (#14, @lorenzwalthert).
- New `try_read_lines_enc()`.
- `transform_lines_enc()` now uses `try_read_lines_enc()`, therefore only warns if file is missing.


## enc 0.0-10 (2017-02-03)

- `transform_lines_enc()` auto-detects EOL delimiter.


## enc 0.0-9 (2017-02-02)

- New `transform_lines_enc()`.
- New `read_lines()` and `write_lines()` for robust reading and writing of text files (#8).


## enc 0.0-8 (2016-08-09)

- Full test coverage.
- Test on AppVeyor.
- Names of `utf8` objects are also stored as `utf8` objects, also on update (#4).


## enc 0.0-7 (2016-08-09)

- New general `to_encoding()` with variants `to_native()`, `to_latin1()` and `to_alien()`. The existing `to_utf8` now uses `to_encoding()` (#3).


## enc 0.0-6 (2016-08-09)

- Fix `R CMD check` errors.
- New `to_utf8()` performs deep conversion to UTF-8, including names and other attributes (#2, #5).


## enc 0.0-5 (2016-08-09)

- New `encoding()`, returns `"ASCII"` for pure ASCII strings and behaves identical to `base::Encoding()` otherwise.
- New `all_utf8()`, returns an atomic logical that indicates if all elements of a character vector are UTF-8 encoded; this includes pure ASCII stringsi (#1).
- Remove `Encoding<-` override, with documentation (#7).


# enc 0.0-4 (2016-06-14)

- Implement `c.utf8()`.


# enc 0.0-3 (2016-06-13)

- Pass `R CMD check`.


# enc 0.0-2 (2016-06-13)

- Updating the encoding is a no-op for `utf8` objects.


# enc 0.0-1 (2016-06-13)

- Initial release
- `utf8` class with constructor, coercion, formatting, printing, and checked updates
