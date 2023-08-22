# The Sea of Nodes and the HotSpot JIT

https://www.youtube.com/watch?v=9epgZ-e6DUU

Sea of nodes
- Designed with emphasis on fast codegen and small IR size
- Always in SSA form, even in final code scheduling and register allocation
- Limited data in nodes
- Data and control use the same graph
- Data is decoupled from CFG and floats around

No basic blocks. Uses phis.

Has an embedded control flow graph.
Doesn't use a program dependence graph, as that would have been too many
experimental ideas.
