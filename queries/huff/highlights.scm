(natspec_line) @Comment
(natspec_block) @Comment
(comment) @Comment

"#define" @Define
"macro" @Macro
"fn" @Keyword
"jumptable" @Keyword
"jumptable__packed" @Keyword
"function" @Keyword
"event" @Keyword
"error" @keyword
"constant" @Keyword
"table" @Keyword
"test" @Keyword
"takes" @Keyword
"returns" @Keyword

(macro name: (identifier) @Function)
(fn name: (identifier) @Function)
(jumptable name: (identifier) @Function)
(jumptable_packed name: (identifier) @Function)
(table name: (identifier) @Function)
(test name: (identifier) @Function)
(function name: (identifier) @Function)
(event name: (identifier) @Function)
(error name: (identifier) @Function)

(type) @Type
"view" @Keyword
"pure" @Keyword
"payable" @Keyword
"nonpayable" @Keyword
"memory" @Keyword
"storage" @Keyword
"calldata" @Keyword

(parameter name: (identifier) @Identifier)

(opcode) @constant.macro

(macro_call name: (identifier) @Function)

(constant name: (identifier) @Identifier)
(referenced_constant) @Identifier
(referenced_parameter) @Identifier

(number) @Number

(type array_size: (number) @Number)

(jumpdest_label name: (identifier) @Label)
(jumpdest name: (identifier) @Label)
(jumptable_body (jumpdest name: (identifier)) @Label)

((macro_call name: (identifier) @Function)
 (#match? @Function "^[A-Z][A-Z0-9_]*$")) ; All caps suggests macro

(builtin_function) @Function.builtin
(builtin_function args: (identifier) @Function)
"__ERROR" @function.builtin
"__EVENT_HASH" @function.builtin
"__FUNC_SIG" @function.builtin
"__RIGHTPAD" @function.builtin
"__codesize" @function.builtin
"__tablesize" @function.builtin
"__tablestart" @function.builtin

"#include" @Include
(import path: (string_literal) @String)

(string_literal) @String

(decorator) @attribute
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
