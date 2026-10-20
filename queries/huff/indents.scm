[
  (macro_body)
  (block)
] @indent.begin

[
  (jumptable_body)  
] @indent.begin

[
  (parameter_list)
] @indent.begin

[
  (decorator)
] @indent.begin

[
  "}"
  "]"
  ")"
] @indent.end

[
 (declaration)
 (import)
 (constant)
 ] @indent.zero

(jumpdest_label) @indent.branch
(macro_body
  (macro_call) @indent.branch)
(macro_body  
  (builtin_function) @indent.branch)
(comment) @indent.auto
(natspec_line) @indent.auto
(natspec_block) @indent.auto
(parameter) @indent.branch
(decorator_item) @indent.branch
