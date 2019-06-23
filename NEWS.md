# enc 0.2.0

- Fix transformation of non-ASCII text on Windows (#18, @yutannihilation).


## enc 0.1 (2017-11-12)

Initial release.

- `utf8` class with constructor, coercion, combination, formatting, printing, and checked updates.
- `to_encoding()` performs deep encoding conversion of objects, including names and other attributes. Variants: `to_utf8()`, `to_native()`, `to_latin1()` and `to_alien()`.
- `encoding()`, returns `"ASCII"` for pure ASCII strings and behaves identically to `base::Encoding()` otherwise.
- `all_utf8()`, returns a logical scalar that indicates if all elements of a character vector are UTF-8 encoded; this includes pure ASCII strings.
- `read_lines_enc()`, `try_read_lines_enc()`, and `write_lines_enc()` for robust reading and writing of text files. Returns/accepts objects of class `utf8`.
- `transform_lines_enc()`, with robust handling if only some files could be transformed in `transform_lines_enc()`. Uses `try_read_lines_enc()`, therefore only warns if file is missing. Auto-detects and maintains EOL delimiter.
