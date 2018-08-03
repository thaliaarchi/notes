## Ideas

- `Object.prototype.valueOf` for comparisons
- Maintain registry of CSS2 system colors, currentColor, and color variables to use when comparing. When not set, they aren't comparable. A variable is always equivalent to itself.
- Since `currentColor` is dependent on element, should it ever compare equal?
- Allow loading of CSS2 system colors from browser colors

## Webkit

Functions from [CSS source](https://github.com/WebKit/webkit/tree/master/Source/WebCore/css)
- red
- green
- blue
- alpha

Functions from [StyleColor.cpp source](https://github.com/WebKit/webkit/blob/master/Source/WebCore/css/StyleColor.cpp)
- isCurrentColor
- colorFromKeyword
- isColorKeyword
- isSystemColor

CSS color keywords
- https://github.com/WebKit/webkit/blob/master/Source/WebCore/css/makevalues.pl#L152
- https://github.com/WebKit/webkit/blob/master/Source/WebCore/css/CSSValueKeywords.in#L173

## Mozilla

https://developer.mozilla.org/en-US/docs/Web/CSS/color_value
- HTML only recognizes the 16 basic color keywords found in CSS1, using a specific algorithm to convert unrecognized values (often to completely different colors). The other color keywords should only be used in CSS and SVG.
- Unlike HTML, CSS will completely ignore unknown keywords.
- The color keywords all represent plain, solid colors, without transparency.
- Several keywords are aliases for each other:
- Though many keywords have been adapted from X11, their RGB values may differ from the corresponding color on X11 systems since manufacturers sometimes tailor X11 colors to their specific hardware.
- Also has:
  - Mozilla System Color Extensions
  - Mozilla Color Preference Extensions

## CSSWG

- Consider [default color value](https://github.com/w3c/csswg-drafts/issues/1851)
- [Inheritance of currentColor](https://github.com/w3c/csswg-drafts/issues/1510)
- https://github.com/w3c/csswg-drafts/issues/883

## Chrome

Chrome uses [Quick Color Management System](chrome://credits/)
- https://github.com/jrmuizel/qcms/tree/v4
- https://hg.mozilla.org/mozilla-central/file/tip/gfx/qcms

Blink
- [`WebColorName.cpp`](https://chromium.googlesource.com/chromium/blink/+/master/Source/web/WebColorName.cpp)