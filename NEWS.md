# enc 0.2.2

- Remove clever code that breaks enc on R-devel.


# enc 0.2.1

- Use `LEVELS` macro instead of low-level access of opaque structure (#23).
- Fix `write_lines_enc()` on Windows systems: input is always transformed to UTF-8 before writing (#21).
- Fix test on systems with latin-1 encoding.
- Remove documentation link absent in current rlang.


# enc 0.2.0

- Fix transformation of non-ASCII text on Windows (#18, @yutannihilation).


# enc 0.1

Initial release.

- `utf8` class with constructor, coercion, combination, formatting, printing, and checked updates.
- `to_encoding()` performs deep encoding conversion of objects, including names and other attributes. Variants: `to_utf8()`, `to_native()`, `to_latin1()` and `to_alien()`.
- `encoding()`, returns `"ASCII"` for pure ASCII strings and behaves identically to `base::Encoding()` otherwise.
- `all_utf8()`, returns a logical scalar that indicates if all elements of a character vector are UTF-8 encoded; this includes pure ASCII strings.
- `read_lines_enc()`, `try_read_lines_enc()`, and `write_lines_enc()` for robust reading and writing of text files. Returns/accepts objects of class `utf8`.
- `transform_lines_enc()`, with robust handling if only some files could be transformed in `transform_lines_enc()`. Uses `try_read_lines_enc()`, therefore only warns if file is missing. Auto-detects and maintains EOL delimiter.
