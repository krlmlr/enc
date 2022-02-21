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
      test_write_lines_enc("中")
    Output
      [1] e4 b8 ad 0a
    Code
      test_write_lines_enc("中", sep = "\r\n")
    Output
      [1] e4 b8 ad 0d 0a
    Code
      test_write_lines_enc("中", file_encoding = "GB2312")
    Output
      [1] d6 d0 0a
    Code
      test_write_lines_enc("中", file_encoding = "GB2312", sep = "\r\n")
    Output
      [1] d6 d0 0d 0a

