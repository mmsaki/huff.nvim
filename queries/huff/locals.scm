[
  "__ASSERT_PC"
  "__BYTES"
  "__CODECOPY_DYN_ARG"
  "__EMBED_TABLE"
  "__ERROR"
  "__EVENT_HASH"
  "__FUNC_SIG"
  "__LEFTPAD"
  "__RIGHTPAD"
  "__codesize"
  "__tablesize"
  "__tablestart"
  "__VERBATIM"
] @local.definition.builtin

(macro 
  (macro_body) @local.scope)
(fn
  (macro_body) @local.scope)
(test
  (macro_body) @local.scope)
(table
  (macro_body) @local.scope)
(macro
  name: (identifier) @local.definition.function)
(fn
  name: (identifier) @local.definition.function)
(test
  name: (identifier) @local.definition.function)
(constant
  name: (identifier) @local.definition.constant)
(error
  name: (identifier) @local.definition.function)
(event
  name: (identifier) @local.definition.function)
(table
  name: (identifier) @local.definition.function)
(jumptable
  name: (identifier) @local.definition.function)
(jumpdest_label
  name: (identifier) @local.definition.function)
(parameter
  name: (identifier) @local.definition.parameter)
(macro_call  
  name: (identifier) @local.reference)
(referenced_constant) @local.reference
(referenced_parameter) @local.reference
(builtin_function
  args: (identifier) @local.definition.parameter)
(macro_call
  name: (identifier) @local.definition.parameter
  (#match? @local.definition.parameter "^[a-z_][a-z0-9_]*$"))
(jumptable_body
  (jumpdest) @local.reference)
(import) @local.import
(import
  path: (string_literal) @local.import)
(decorator_item  
  name: (identifier) @local.definition.parameter)
(opcode) @local.definition.builtin
