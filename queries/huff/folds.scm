(builtin_function "(" @fold.start ")" @fold.end) @fold
(constant "=" @fold.start) @fold
(decorator "#[" @fold.start "]" @fold.end) @fold
(fn (macro_body) @fold)
(function "returns" @fold.start) @fold
(jumptable_body "{" @fold.start "}" @fold.end) @fold
(macro (macro_body) @fold)
(macro_body "{" @fold.start "}" @fold.end) @fold
(macro_call "(" @fold.start ")" @fold.end) @fold
(natspec_block) @fold
(parameter_list "(" @fold.start ")" @fold.end) @fold
(table (macro_body) @fold)
(test (macro_body) @fold)
(block "{" @fold.start "}" @fold.end) @fold
