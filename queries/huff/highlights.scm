(natspec_line) @comment
(natspec_block) @comment
(comment_line) @comment
(comment_block) @comment

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

(declaration_macro name: (identifier) @function)
(declaration_fn name: (identifier) @function)
(declaration_jumptable name: (identifier) @function)
(declaration_jumptable_packed name: (identifier) @function)
(declaration_table name: (identifier) @function)
(declaration_test name: (identifier) @function)
(interface_function name: (identifier) @function)
(interface_event name: (identifier) @function)
(error_definition name: (identifier) @function)

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

(parameter name: (identifier) @variable.parameter)

(opcode) @variable
"jump" @variable
"jumpi" @variable

(template_parameter_call) @variable.parameter

(macro_call name: (identifier) @function)

(constant_definition name: (identifier) @variable)
(constant_reference) @variable

(number_decimal) @number
(number_hex) @number

(jumpdest_label name: (identifier) @label)
(jumpdest name: (identifier) @label)
(jumptable_body (identifier) @label)

((macro_call name: (identifier) @function)
 (#match? @function "^[A-Z][A-Z0-9_]*$")) ; All caps suggests macro

(builtin_function) @function.builtin
(builtin_function args: (identifier) @function)
"__ERROR" @function.builtin
"__EVENT_HASH" @function.builtin
"__FUNC_SIG" @function.builtin
"__RIGHTPAD" @function.builtin
"__codesize" @function.builtin
"__tablesize" @function.builtin
"__tablestart" @function.builtin

"#include" @keyword.import
(control_include path: (string_literal) @string)

(modifier_indexed) @keyword

(string_literal) @string

(decorator) @attribute
(decorator_item name: (identifier) @attribute)
(decorator_item args: (string_literal) @string)
(decorator_item args: (number) @number)

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
