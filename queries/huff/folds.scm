(macro_body
  "{" @fold.start
  "}" @fold.end) @fold

(jumptable_body
  "{" @fold.start
  "}" @fold.end) @fold

(natspec_block) @fold

(parameter_list
  "(" @fold.start
  ")" @fold.end) @fold

(decorator
  "#[" @fold.start
  "]" @fold.end) @fold

(macro
  (macro_body) @fold)

(fn
  (macro_body) @fold)

(test
  (macro_body) @fold)

(table
  (macro_body) @fold)

(constant
  "=" @fold.start) @fold

(function
  "returns" @fold.start) @fold

(builtin_function
  "(" @fold.start
  ")" @fold.end) @fold

(macro_call
  "(" @fold.start
  ")" @fold.end) @fold
