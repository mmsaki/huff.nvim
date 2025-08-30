;; ==========================
;; Huff Tree-sitter Indents
;; ==========================

;; --------------------------
;; Indent increases
;; --------------------------

;; Increase indent inside macro bodies
[
  (macro_body)
] @indent.begin

;; Increase indent inside jumptable bodies
[
  (jumptable_body)  
] @indent.begin

;; Increase indent inside parameter lists (multi-line)
[
  (parameter_list)
] @indent.begin

;; Increase indent inside decorators (multi-line)
[
  (decorator)
] @indent.begin

;; --------------------------
;; Indent decreases  
;; --------------------------

;; Decrease indent at closing braces
[
  "}"
  "]"
  ")"
] @indent.end

;; --------------------------
;; Branch/alignment indents
;; --------------------------

;; Align jump labels with macro content
(jumpdest_label) @indent.branch

;; Align macro calls within macro bodies
(macro_body
  (macro_call) @indent.branch)

;; Align opcodes within macro bodies  
(macro_body
  (opcode) @indent.branch)

;; Align numbers within macro bodies
(macro_body
  (number) @indent.branch)

;; Align builtin functions within macro bodies
(macro_body  
  (builtin_function) @indent.branch)

;; Align constants within macro bodies
(macro_body
  (constant) @indent.branch)

;; --------------------------
;; Special cases
;; --------------------------

;; Don't auto-indent comments that are already aligned
(comment) @indent.auto

;; Handle parameter continuation lines
(parameter) @indent.branch

;; Handle decorator argument continuation  
(decorator_item) @indent.branch

;; --------------------------
;; Zero indent anchors
;; --------------------------

;; Top-level declarations should not be indented
[
  (declaration)
  (interface)  
  (error)
  (control)
  (constant)
] @indent.zero
