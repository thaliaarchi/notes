.PHONY: all
all: wspace/instruction_prefix_tree.svg wspace/instruction_prefix_tree.png

.PHONY: clean
clean:
		rm -f wspace/instruction_prefix_tree.svg wspace/instruction_prefix_tree.png

%.svg: %.gv
		dot -Tsvg < $< > $@
# npm -g install svgo
		svgo $@

%.png: %.gv
		dot -Tpng < $< > $@
