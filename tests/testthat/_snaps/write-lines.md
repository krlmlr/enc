# sanity check: input files

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
    Code
      digest::digest(file = r("ascii.txt"))
    Output
      [1] "6736f98897a3effe84d1f2e4b9f0b973"
    Code
      digest::digest(file = r("ascii-crlf.txt"))
    Output
      [1] "b2380d51ba72407934a96ed17fb6b16a"
    Code
      digest::digest(file = r("latin1-utf8.txt"))
    Output
      [1] "b1308e45d7501076cd34ebb17d843a9b"
    Code
      digest::digest(file = r("latin1-utf8-crlf.txt"))
    Output
      [1] "5dee80ff20fe15eb0def0b4fefdaa5e2"
    Code
      digest::digest(file = r("latin1.txt"))
    Output
      [1] "81f5d90beb6eb7f639bdbf700aaa0eff"
    Code
      digest::digest(file = r("latin1-crlf.txt"))
    Output
      [1] "61b55e58f9281cdefc4c6ca01691838d"
    Code
      digest::digest(file = r("gb2312-utf8.txt"))
    Output
      [1] "9d8dbd98625cd6e5bb78a54d8331ec16"
    Code
      digest::digest(file = r("gb2312-utf8-crlf.txt"))
    Output
      [1] "86c7554822fe2d6a00f612c3b846ae5e"
    Code
      digest::digest(file = r("gb2312.txt"))
    Output
      [1] "3096d490573786a76f1c2791e196829c"
    Code
      digest::digest(file = r("gb2312-crlf.txt"))
    Output
      [1] "2dcd98a4e67a362c532b4a863a7f3ead"

