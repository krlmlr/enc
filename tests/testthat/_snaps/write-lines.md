# sanity check

    Code
      charToRaw("\n")
    Output
      [1] 0a
    Code
      charToRaw("\r")
    Output
      [1] 0d
    Code
      charToRaw("\r\n")
    Output
      [1] 0d 0a

# can write text to output file

    Code
      test_write_lines_enc("ascii")
    Output
      [1] 61 73 63 69 69 0a
    Code
      test_write_lines_enc("ascii", sep = "\r\n")
    Output
      [1] 61 73 63 69 69 0d 0a
    Code
      test_write_lines_enc("ü")
    Output
      [1] c3 bc 0a
    Code
      test_write_lines_enc("ü", sep = "\r\n")
    Output
      [1] c3 bc 0d 0a
    Code
      test_write_lines_enc("ü", file_encoding = "latin1")
    Output
      [1] fc 0a
    Code
      test_write_lines_enc("ü", file_encoding = "latin1", sep = "\r\n")
    Output
      [1] fc 0d 0a
    Code
      test_write_lines_enc("<U+4E2D>")
    Output
      [1] 3c 55 2b 34 45 32 44 3e 0a
    Code
      test_write_lines_enc("<U+4E2D>", sep = "\r\n")
    Output
       [1] 3c 55 2b 34 45 32 44 3e 0d 0a
    Code
      test_write_lines_enc("<U+4E2D>", file_encoding = "GB2312")
    Output
      [1] 3c 55 2b 34 45 32 44 3e 0a
    Code
      test_write_lines_enc("<U+4E2D>", file_encoding = "GB2312", sep = "\r\n")
    Output
       [1] 3c 55 2b 34 45 32 44 3e 0d 0a

