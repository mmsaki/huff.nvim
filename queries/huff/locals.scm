(declaration_macro 
  (macro_body) @local.scope)

(declaration_fn
  (macro_body) @local.scope)

(declaration_test
  (macro_body) @local.scope)

(declaration_table
  (macro_body) @local.scope)

(declaration_macro
  name: (identifier) @local.definition.function)

(declaration_fn
  name: (identifier) @local.definition.function)

(declaration_test
  name: (identifier) @local.definition.function)

(constant_definition
  name: (identifier) @local.definition.constant)

(error_definition  
  name: (identifier) @local.definition.type)

(interface_function
  name: (identifier) @local.definition.function)

(interface_event
  name: (identifier) @local.definition.function)

(declaration_table
  name: (identifier) @local.definition.constant)

(declaration_jumptable
  name: (identifier) @local.definition.constant)

(jumpdest_label
  name: (identifier) @jumpdest_declaration)

(parameter
  name: (identifier) @local.definition.parameter)

(macro_call  
  name: (identifier) @local.reference)

(constant_reference) @local.reference

(builtin_function
  args: (identifier) @local.reference)

(macro_call
  name: (identifier) @local.reference
  (#match? @local.reference "^[a-z_][a-z0-9_]*$"))

(jumptable_body
  (identifier) @local.reference)

(control_include) @local.import

(control_include
  path: (string_literal) @local.import)

(template_parameter_call) @local.reference

(decorator_item  
  name: (identifier) @local.reference)

(opcode) @local.definition.builtin

[
  "__ERROR"
  "__EVENT_HASH" 
  "__FUNC_SIG"
  "__RIGHTPAD"
  "__codesize"
  "__tablesize"
  "__tablestart"
] @local.definition.builtin
