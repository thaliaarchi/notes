# Whitespace steganography

## File embedding

Whitespace programs can be embedded in file formats, that parse using file
trailers.

- [JPEG](https://en.wikipedia.org/wiki/JPEG#Syntax_and_structure): Programs
  could be encoded in COM comment markers just after the SOI start of image
  marker.
- [PDF](https://en.wikipedia.org/wiki/PDF): Parsing starts with the
  cross-reference table at the end of the file. Files start with a comment
  containing the version, like `%PDF-1.7`, followed by LF, so a nop instruction
  sequence starting with LF would need to be prepended to the program.
- [ZIP](https://en.wikipedia.org/wiki/ZIP_(file_format)#Combination_with_other_file_formats)
  (as well as formats derived from it, such as [JAR](https://en.wikipedia.org/wiki/JAR_(file_format)),
  [WAR](https://en.wikipedia.org/wiki/WAR_(file_format)) and [EAR](https://en.wikipedia.org/wiki/WAR_(file_format))):
  Parsing starts with a central directory, located at the end of the archive,
  which specifies the offsets for each files, so arbitrary data can precede the
  files. Some tools like gzip don't process archives that don't start with a
  file entry at offset 0.

Formats that won't work:

- [GIF](https://en.wikipedia.org/wiki/GIF): Parses with a header.
- [TAR](https://en.wikipedia.org/wiki/Tar_(computing)): Starts with a file
  entry.
