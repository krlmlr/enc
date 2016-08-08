## utf8 0.0-5 (2016-08-09)

- New `encoding()`, returns `"ASCII"` for pure ASCII strings and behaves identical to `base::Encoding()` otherwise.
- New `all_utf8()`, returns an atomic logical that indicates if all elements of a character vector are UTF-8 encoded; this includes pure ASCII stringsi (#1).
- Remove `Encoding<-` override, with documentation (#7).


# utf8 0.0-4 (2016-06-14)

- Implement `c.utf8()`.


# utf8 0.0-3 (2016-06-13)

- Pass `R CMD check`.


# utf8 0.0-2 (2016-06-13)

- Updating the encoding is a no-op for `utf8` objects.


# utf8 0.0-1 (2016-06-13)

- Initial release
- `utf8` class with constructor, coercion, formatting, printing, and checked updates
