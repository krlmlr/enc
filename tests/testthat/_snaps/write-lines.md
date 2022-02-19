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
      digest::digest(r("ascii.txt"))
    Output
      [1] "ab378bf6d0d34e0e3ab9586bef0c38f4"
    Code
      digest::digest(r("ascii-crlf.txt"))
    Output
      [1] "e54f5379d79efdc59bfa9e8df114d444"
    Code
      digest::digest(r("latin1-utf8.txt"))
    Output
      [1] "61810c18a91010e7111a65dcd037c095"
    Code
      digest::digest(r("latin1-utf8-crlf.txt"))
    Output
      [1] "4f7fe14980b2ef231d51590d4c392d56"
    Code
      digest::digest(r("latin1.txt"))
    Output
      [1] "f0bc3d8e43de6507ac133e9256e1a424"
    Code
      digest::digest(r("latin1-crlf.txt"))
    Output
      [1] "28ccbc65bbaa374dbe21df0708fdbbd8"
    Code
      digest::digest(r("gb2312-utf8.txt"))
    Output
      [1] "cb882a817ce794f54a7aacbf766d76fd"
    Code
      digest::digest(r("gb2312-utf8-crlf.txt"))
    Output
      [1] "9ea88e29c7aa01e7fab9a831db02a972"
    Code
      digest::digest(r("gb2312.txt"))
    Output
      [1] "fd98d8fb6eb339a4963465c1847c1330"
    Code
      digest::digest(r("gb2312-crlf.txt"))
    Output
      [1] "48d18932926b0d46d4636cb1ed2252aa"

