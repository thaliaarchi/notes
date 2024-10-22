# Misc notes

Slide 22 of <https://community-dot-o.llvm.org/slides/WiCT-2023-02-RebeccaSwords.pdf>
has the following example:

```python
rules = [
    ExprTree.make_rule(lambda x, y, z: ((x * y) / z, x * (y / z))),
    ExprTree.make_rule(lambda x: (x / x, ExprNode(1, ()))),
    ExprTree.make_rule(lambda x: (x * 1, x))
]
while not egraph.is_saturated():
    Rule.apply_rules(rules, egraph)
aeclass = egraph.add(ExprTree(ExprNode('a', ())))
assert aeclass.find() == egraph.root.find()
```

Rules expressed as lambdas makes the implicit bindings explicit. If rewrites
were written using slotted e-graphs, then rewriting rewrites might be possible.
(Since I don't think egg-style e-graphs can have forall.) But lambdas can(?) be
represented, so perhaps this is a non-issue.
