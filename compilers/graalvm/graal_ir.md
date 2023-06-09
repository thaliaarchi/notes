# Graal IR: An Extensible Declarative Intermediate Representation

[[PDF](https://ssw.jku.at/General/Staff/GD/APPLC-2013-paper_12.pdf)]

Input edges (use-def) express data flow dependencies, used for scheduling.

Non-reducible loops are not supported with the `LoopBegin`/`LoopEnd` design.

Phi nodes are tied to merge nodes:

```java
class PhiNode extends Node {
  ...
  MergeNode merge()
  ValueNode valueAt(EndNode pred)
}
```

> While building the graph, we create floating nodes for all nodes where this
> does not require any special analysis or dependency creation. Some operations
> that cannot immediately be represented as floating nodes, such as memory read
> operations, are transformed into floating nodes by later optimization phases
> that insert the appropriate dependencies.
>
> […] this representation simplifies a number of optimizations by removing the
> burden of maintaining a valid schedule or performing code motion. Before
> emitting machine code, the IR is fully scheduled by assigning each node to a
> block in the control-flow graph and by ordering the nodes inside each block.
> During scheduling, simple heuristics are used to apply some code motion
> optimization such as hoisting code out of loops.

Nodes have at most one predecessor.
