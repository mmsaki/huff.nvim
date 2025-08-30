;; ==========================
;; Huff Tree-sitter Highlights
;; Standard Neovim highlight groups
;; ==========================

;; --------------------------
;; Natspec / Documentation
;; --------------------------
(natspec_line) @comment
(natspec_block) @comment

(natspec_tag_title) @attribute
(natspec_tag_author) @attribute
(natspec_tag_notice) @attribute
(natspec_tag_dev) @attribute
(natspec_tag_param) @attribute
(natspec_tag_return) @attribute

(comment_line) @comment
(comment_block) @comment

;; --------------------------
;; Declarations - Keywords
;; --------------------------
"#define" @keyword.directive.define
"macro" @keyword
"fn" @keyword
"jumptable" @keyword
"jumptable__packed" @keyword
"function" @keyword
"event" @keyword
"error" @keyword
"constant" @keyword
"table" @keyword
"test" @keyword

"takes" @keyword
"returns" @keyword

;; --------------------------
;; Function/Macro Names
;; --------------------------
(declaration_macro name: (identifier) @function)
(declaration_fn name: (identifier) @function)
(declaration_jumptable name: (identifier) @function)
(declaration_jumptable_packed name: (identifier) @function)
(declaration_table name: (identifier) @function)
(declaration_test name: (identifier) @function)
(interface_function name: (identifier) @function)
(interface_event name: (identifier) @function)
(error_definition name: (identifier) @function)

;; --------------------------
;; Interface Types and Extensions
;; --------------------------
(interface_primitives) @type.builtin
"view" @keyword
"pure" @keyword
"payable" @keyword
"nonpayable" @keyword
"external" @keyword
"internal" @keyword
"public" @keyword
"private" @keyword
"memory" @keyword
"storage" @keyword
"calldata" @keyword

;; --------------------------
;; Parameter Names
;; --------------------------
(parameter name: (identifier) @variable.parameter)

;; --------------------------
;; Opcodes
;; --------------------------
(opcode) @variable
;; Jump opcodes within jumpdest
"jump" @variable
"jumpi" @variable

;; --------------------------
;; Template Parameters
;; --------------------------
(template_parameter_call) @variable.parameter

;; --------------------------
;; Macro Calls
;; --------------------------
(macro_call name: (identifier) @function)

;; --------------------------
;; Constants
;; --------------------------
(constant_definition name: (identifier) @variable)
(constant_reference) @variable

;; --------------------------
;; Numbers
;; --------------------------
(number_decimal) @number
(number_hex) @number

;; --------------------------
;; Jump Targets
;; --------------------------
(jumpdest_label name: (identifier) @label)
(jumpdest name: (identifier) @label)
(jumptable_body (identifier) @label)

((macro_call name: (identifier) @function)
 (#match? @function "^[A-Z][A-Z0-9_]*$")) ; All caps suggests macro

;; --------------------------
;; Builtin Functions
;; --------------------------
(builtin_function) @function.builtin
(builtin_function args: (identifier) @function)
"__ERROR" @function.builtin
"__EVENT_HASH" @function.builtin
"__FUNC_SIG" @function.builtin
"__RIGHTPAD" @function.builtin
"__codesize" @function.builtin
"__tablesize" @function.builtin
"__tablestart" @function.builtin

;; --------------------------
;; Control/Import
;; --------------------------
"#include" @keyword.import
(control_include path: (string_literal) @string)

;; --------------------------
;; Parameter Modifiers
;; --------------------------
(modifier_indexed) @keyword

;; --------------------------
;; String Literals
;; --------------------------
(string_literal) @string

;; --------------------------
;; Decorators
;; --------------------------
(decorator) @attribute
(decorator_item name: (identifier) @attribute)
(decorator_item args: (string_literal) @string)
(decorator_item args: (number) @number)

;; --------------------------
;; Operators and Punctuation
;; --------------------------
"=" @operator
":" @punctuation.delimiter
"," @punctuation.delimiter
"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"#[" @punctuation.bracket
