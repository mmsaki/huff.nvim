;; ==========================
;; Huff Tree-sitter Folds
;; ==========================

;; --------------------------
;; Block structures that should be foldable
;; --------------------------

;; Macro bodies
(macro_body
  "{" @fold.start
  "}" @fold.end) @fold

;; Jumptable bodies  
(jumptable_body
  "{" @fold.start
  "}" @fold.end) @fold

;; Comment blocks
(comment_block
  "/*" @fold.start
  "*/" @fold.end) @fold

;; Natspec blocks
(natspec_block
  "/**" @fold.start
  "*/" @fold.end) @fold

;; Multi-line parameter lists
(parameter_list
  "(" @fold.start
  ")" @fold.end) @fold

;; Decorator blocks (when they span multiple lines)
(decorator
  "#[" @fold.start
  "]" @fold.end) @fold

;; --------------------------
;; Declaration folds
;; --------------------------

;; Macro declarations with bodies
(declaration_macro
  (macro_body) @fold)

;; Function declarations with bodies  
(declaration_fn
  (macro_body) @fold)

;; Test declarations with bodies
(declaration_test
  (macro_body) @fold)

;; Table declarations with bodies
(declaration_table
  (macro_body) @fold)

;; --------------------------
;; Multi-line constructs
;; --------------------------

;; Long constant definitions
(constant_definition
  "=" @fold.start) @fold

;; Long interface function definitions
(interface_function
  "returns" @fold.start) @fold

;; Long builtin function calls with multiple args
(builtin_function
  "(" @fold.start
  ")" @fold.end) @fold

;; Long macro calls with multiple args
(macro_call
  "(" @fold.start
  ")" @fold.end) @fold