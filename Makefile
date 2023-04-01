.PHONY: all
all: wspace/opcode_prefix_tree.svg wspace/opcode_prefix_tree.png

%.svg: %.gv
		dot -Tsvg < $< > $@
# npm -g install svgo
		svgo $@

%.png: %.gv
		dot -Tpng < $< > $@
