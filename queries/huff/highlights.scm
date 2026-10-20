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
"{" @Delimiter
"}" @Delimiter
".." @Operator

(builtin_function name: _ @function.builtin)
"FREE_STORAGE_POINTER" @function.builtin
(noop) @constant.builtin
(boolean) @boolean

"calldata" @Keyword
"constant" @Keyword
"error" @keyword
"event" @Keyword
"fn" @Keyword
"function" @Keyword
"indexed" @Keyword
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

["if" "else"] @keyword.conditional
["for" "in" "step"] @keyword.repeat

(binary_expression operator: _ @Operator)
(unary_expression operator: _ @Operator)

(builtin_function args: (identifier) @Function)
(builtin_function [
  table: (identifier) @Type
  args: [
    (referenced_parameter) @PreProc
    (referenced_constant) @Identifier]])
(comment) @Comment
(constant name: (identifier) @Identifier)
(constant value: (identifier) @Identifier)
(decorator) @attribute
(decorator_item args: (number) @Number)
(decorator_item args: (string_literal) @String)
(decorator_item args: (identifier) @variable.builtin)
(decorator_item name: (identifier) @Identifier)
(named_argument name: (identifier) @variable.parameter)
(named_argument value: (identifier) @variable.builtin)
(error name: (identifier) @Function)
(event name: (identifier) @Function)
(fn name: (identifier) @Function)
(for_statement variable: (identifier) @variable)
(function name: (identifier) @Function)
(import path: (string_literal) @String)
(jumpdest name: (identifier) @Label)
(jumpdest_label name: (identifier) @Label)
(jumptable name: (identifier) @Type)
(jumptable_packed name: (identifier) @Type)
(macro name: (identifier) @Function)
(macro_call name: (identifier) @Function)
(macro_call args: (identifier) @Label)
(macro_invocation args: (identifier) @Label)
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
