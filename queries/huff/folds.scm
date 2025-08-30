(macro_body
  "{" @fold.start
  "}" @fold.end) @fold

(jumptable_body
  "{" @fold.start
  "}" @fold.end) @fold

(comment_block) @fold

(natspec_block) @fold

(parameter_list
  "(" @fold.start
  ")" @fold.end) @fold

(decorator
  "#[" @fold.start
  "]" @fold.end) @fold

(declaration_macro
  (macro_body) @fold)

(declaration_fn
  (macro_body) @fold)

(declaration_test
  (macro_body) @fold)

(declaration_table
  (macro_body) @fold)

(constant_definition
  "=" @fold.start) @fold

(interface_function
  "returns" @fold.start) @fold

(builtin_function
  "(" @fold.start
  ")" @fold.end) @fold

(macro_call
  "(" @fold.start
  ")" @fold.end) @fold
