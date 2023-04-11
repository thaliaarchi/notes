# Inlay Hints for Whitespace

The syntax of the Whitespace programming language is invisible—it uses only
space, tab, and line feed—so editing a program manually is tedious and most
people will instead develop using a “Whitespace assembly” syntax with readable
opcodes. I am working on a [to-be language server](https://github.com/andrewarchi/yspace)
for Whitespace that will use inlay hints to display the opcodes in the invisible
syntax. The LSP only allows `Type` and `Parameter` values for [`InlayHintKind`](https://github.com/microsoft/vscode/blob/f5edc2642c41b9ae354bfc8ecdccee6c9037c041/src/vscode-dts/vscode.d.ts#L4835),
which is exclusive of this use case ([vscode#151920](https://github.com/microsoft/vscode/issues/151920)).
I propose that this enum be extended to include a variant for this case.

This gist roughly demonstrates how the inlay hints would work for a Whitespace
program: It includes the annotated example from the [Whitespace tutorial](https://web.archive.org/web/20150618184706/http://compsoc.dur.ac.uk/whitespace/tutorial.php)
formatted in the [standard syntax](count.ws), in [Whitespace assembly syntax](count.wsa),
and with [inlay hints for assembly opcodes interspersed](count_inlay.ws).
