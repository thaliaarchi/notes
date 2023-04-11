# Whitespace steganography

## Source code embedding

Whitespace programs can be embedded in text files, by modifying spaces in the
target to match the Whitespace program. Edwin's [embed.hs](https://web.archive.org/web/20030430004837/http://compsoc.dur.ac.uk/whitespace/embed.hs)
did this by simply substituting spaces, but that may not always be semantically
equivalent. Instead, for source code, a more sophisticated embedder should
tokenize the target file. Strings and code blocks should typically be left
as-is.

Considerations for various programming and markup languages:

- JSON: Strings should be preserved.
- [HTML](https://en.wikipedia.org/wiki/HTML): HTML [whitespace handling](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Whitespace)
  is defined by its [tokenization state machine](https://html.spec.whatwg.org/multipage/parsing.html#tokenization)
  and dynamically affected by CSS.
  - Valid locations for space, tab, and LF (incomplete):
    - between a [tag name](https://html.spec.whatwg.org/multipage/parsing.html#tag-name-state)
      and an [attribute name](https://html.spec.whatwg.org/multipage/parsing.html#before-attribute-name-state)
    - in [double-](https://html.spec.whatwg.org/multipage/parsing.html#attribute-value-(double-quoted)-state)
      and [single-quoted attributes](https://html.spec.whatwg.org/multipage/parsing.html#attribute-value-(single-quoted)-state)
  - Invalid locations for space, tab, and LF (incomplete):
    - between `<` and a [tag name](https://html.spec.whatwg.org/multipage/parsing.html#tag-name-state)
    - in [unquoted attributes](https://html.spec.whatwg.org/multipage/parsing.html#attribute-value-(unquoted)-state)

## Binary file embedding

Whitespace programs can be embedded in file formats, that parse using file
trailers or have comment fields at the start.

Formats that would work:

- [PDF](https://en.wikipedia.org/wiki/PDF): Parsing starts with the
  cross-reference table at the end of the file. Files start with a comment
  containing the version, like `%PDF-1.7`, followed by LF, so a nop instruction
  sequence starting with LF would need to be prepended to the program.
- [ZIP](https://en.wikipedia.org/wiki/ZIP_(file_format)#Combination_with_other_file_formats):
  Parsing starts with a central directory, located at the end of the archive,
  which specifies the offsets for each files, so arbitrary data can precede the
  files. Some tools like gzip don't process archives that don't start with a
  file entry at offset 0.
  - [APK](https://en.wikipedia.org/wiki/Apk_(file_format)) is a ZIP archive.
  - [EPUB](https://en.wikipedia.org/wiki/EPUB) is packaged in a ZIP archive.
  - [JAR](https://en.wikipedia.org/wiki/JAR_(file_format)), [EAR](https://en.wikipedia.org/wiki/EAR_(file_format)),
    and [WAR](https://en.wikipedia.org/wiki/WAR_(file_format)) are ZIP archives.
  - [Office Open XML](https://en.wikipedia.org/wiki/Office_Open_XML) (.docx,
    .docm, .pptx, .pptm, .xlsx, and .xlsm) are ZIP archives of XML files.
  - [OpenDocument Format](https://en.wikipedia.org/wiki/OpenDocument) (.odt,
    .fodt, .ods, .fods, .odp, .fodp, .odg, .fodg, and .odf) are XML files,
    sometimes in ZIP archives.
  - [XPI](https://en.wikipedia.org/wiki/XPInstall) (Mozilla extension) is a ZIP
    archive.

Formats that may possibly work:

- [BMP](https://en.wikipedia.org/wiki/BMP_file_format): The offset of the pixel
  array is specified in the header, so arbitrary data could potentially be
  included between the headers and data. However, the headers would need to be
  valid UTF-8.
- [FLAC](https://en.wikipedia.org/wiki/FLAC): A program could be stored in the
  optional [VORBIS_COMMENT](https://xiph.org/flac/format.html#def_VORBIS_COMMENT)
  block, but the STREAMINFO block before it would need to be valid UTF-8.

Formats that won't work:

- [7z](https://en.wikipedia.org/wiki/7z): Although data may occur between
  headers and it has a comment property, the magic number is not valid UTF-8.
- [GIF](https://en.wikipedia.org/wiki/GIF): The contents of the header are
  invalid as UTF-8.
- [gzip](https://en.wikipedia.org/wiki/Gzip): Although it has an optional
  comment field, the sequence for the magic number and compression method,
  1F 8B 08, is invalid as UTF-8.
- [JPEG](https://en.wikipedia.org/wiki/JPEG#Syntax_and_structure): Although it
  has a COM comment marker, the start of image marker, FF D8, is invalid as
  UTF-8.
- [TAR](https://en.wikipedia.org/wiki/Tar_(computing)): It starts with a file
  entry and has no mechanism for comments.
- [PNG](https://en.wikipedia.org/wiki/PNG): The magic number is invalid as
  UTF-8.
