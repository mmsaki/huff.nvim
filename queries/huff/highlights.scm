"#[" @Delimiter
"#define" @Define
"#include" @Include
"(" @Delimiter
")" @Delimiter
"," @Delimiter
":" @Delimiter
"=" @Operator
"[" @Delimiter
"]" @Delimiter
"__BYTES" @function.builtin
"__CODECOPY_DYN_ARG" @function.builtin
"__ERROR" @function.builtin
"__EVENT_HASH" @function.builtin
"__FUNC_SIG" @function.builtin
"__LEFTPAD" @function.builtin
"__RIGHTPAD" @function.builtin
"__codesize" @function.builtin
"__tablesize" @function.builtin
"__tablestart" @function.builtin
"__VERBATIM" @function.builtin
"calldata" @Keyword
"constant" @Keyword
"error" @keyword
"event" @Keyword
"fn" @Keyword
"function" @Keyword
"jumptable" @Keyword
"jumptable__packed" @Keyword
"macro" @Keyword
"memory" @Keyword
"nonpayable" @Keyword
"payable" @Keyword
"pure" @Keyword
"returns" @Keyword
"storage" @Keyword
"table" @Keyword
"takes" @Keyword
"test" @Keyword
"view" @Keyword
"{" @Delimiter
"}" @Delimiter

(builtin_function [
  table: (identifier) @Type
  args: [
    (referenced_parameter) @PreProc
    (referenced_constant) @Identifier]])
(comment) @Comment
(constant name: (identifier) @Identifier)
(decorator) @attribute
(decorator_item args: (number) @Number)
(decorator_item args: (string_literal) @String)
(decorator_item name: (identifier) @Identifier)
(error name: (identifier) @Function)
(event name: (identifier) @Function)
(fn name: (identifier) @Function)
(function name: (identifier) @Function)
(import path: (string_literal) @String)
(jumpdest name: (identifier) @Label)
(jumpdest_label name: (identifier) @Label)
(jumptable name: (identifier) @Type)
(jumptable_packed name: (identifier) @Type)
(macro name: (identifier) @Function)
(macro_call name: (identifier) @Function)
(natspec_block) @Comment
(natspec_line) @Comment
(number) @Number
(opcode) @constant.macro
(parameter name: (identifier) @Identifier)
(referenced_constant) @Identifier
(referenced_parameter) @PreProc
(string_literal) @String
(table name: (identifier) @Type)
(test name: (identifier) @Function)
(type array_size: (number) @Number)
(type) @Type
