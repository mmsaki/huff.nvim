(natspec_line) @Comment
(natspec_block) @Comment
(comment_line) @Comment
(comment_block) @Comment

"#define" @Define
"macro" @Keyword
"fn" @Keyword
"jumptable" @Keyword
"jumptable__packed" @Keyword
"function" @Keyword
"event" @Keyword
"error" @Keyword
"constant" @Keyword
"table" @Keyword
"test" @Keyword
"takes" @Keyword
"returns" @Keyword

(declaration_macro name: (identifier) @Function)
(declaration_fn name: (identifier) @Function)
(declaration_jumptable name: (identifier) @Function)
(declaration_jumptable_packed name: (identifier) @Function)
(declaration_table name: (identifier) @Function)
(declaration_test name: (identifier) @Function)
(interface_function name: (identifier) @Function)
(interface_event name: (identifier) @Function)
(error_definition name: (identifier) @Error)

(interface_primitives) @Type
"view" @Keyword
"pure" @Keyword
"payable" @Keyword
"nonpayable" @Keyword
"external" @Keyword
"internal" @Keyword
"public" @Keyword
"private" @Keyword
"memory" @Keyword
"storage" @Keyword
"calldata" @Keyword

(parameter name: (identifier) @Identifier)

(opcode) @Identifier
"jump" @Identifier
"jumpi" @Identifier

(template_parameter_call
  (template_token) @attribute.builtin)

(macro_call name: (identifier) @Function)

(constant_definition name: (identifier) @Identifier)
(constant_reference) @Constant

(number_decimal) @Number
(number_hex) @Number

(interface_primitives array_size: (number_decimal) @Number)
(jumpdest_label name: (identifier) @Label)
(jumpdest name: (identifier) @Label)
(jumptable_body (identifier) @Label)

((macro_call name: (identifier) @Function)
 (#match? @Function "^[A-Z][A-Z0-9_]*$")) ; All caps suggests macro

(builtin_function) @Keyword
(builtin_function args: (identifier) @Function)
"__ERROR" @Constant
"__EVENT_HASH" @Constant
"__FUNC_SIG" @Constant
"__RIGHTPAD" @Constant
"__codesize" @Constant
"__tablesize" @Constant
"__tablestart" @Constant

"#include" @Include
(control_include path: (string_literal) @String)

(modifier_indexed) @Keyword

(string_literal) @String

(decorator) @Identifier
(decorator_item name: (identifier) @Identifier)
(decorator_item args: (string_literal) @String)
(decorator_item args: (number) @Number)

"=" @Operator
":" @Delimiter
"," @Delimiter
"(" @Delimiter
")" @Delimiter
"{" @Delimiter
"}" @Delimiter
"[" @Delimiter
"]" @Delimiter
"#[" @Delimiter
">" @attribute.builtin
"<" @attribute.builtin
