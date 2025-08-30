;; ==========================
;; Huff Tree-sitter Locals
;; ==========================

;; --------------------------
;; Scope definitions
;; --------------------------

;; Macro definitions create their own scope
(declaration_macro 
  (macro_body) @local.scope)

;; Function definitions create their own scope  
(declaration_fn
  (macro_body) @local.scope)

;; Test definitions create their own scope
(declaration_test
  (macro_body) @local.scope)

;; Table definitions create their own scope
(declaration_table
  (macro_body) @local.scope)

;; --------------------------
;; Variable/identifier definitions
;; --------------------------

;; Macro name definitions
(declaration_macro
  name: (identifier) @local.definition.function)

;; Function name definitions  
(declaration_fn
  name: (identifier) @local.definition.function)

;; Test name definitions
(declaration_test
  name: (identifier) @local.definition.function)

;; Constant name definitions
(constant_definition
  name: (identifier) @local.definition.constant)

;; Error name definitions
(error_definition  
  name: (identifier) @local.definition.type)

;; Interface function name definitions
(interface_function
  name: (identifier) @local.definition.function)

;; Interface event name definitions
(interface_event
  name: (identifier) @local.definition.function)

;; Table name definitions
(declaration_table
  name: (identifier) @local.definition.constant)

;; Jumptable name definitions  
(declaration_jumptable
  name: (identifier) @local.definition.constant)

;; Jump label definitions (local to macro scope)
(jumpdest_label
  name: (identifier) @jumpdest_declaration)

;; Parameter name definitions
(parameter
  name: (identifier) @local.definition.parameter)

;; --------------------------
;; Variable/identifier references
;; --------------------------

;; Macro calls (references to defined macros)
(macro_call  
  name: (identifier) @local.reference)

;; Constant references
(constant_reference) @local.reference

;; Builtin function arguments that reference identifiers
(builtin_function
  args: (identifier) @local.reference)

;; Jump label references (when used as jump targets)
(macro_call
  name: (identifier) @local.reference
  (#match? @local.reference "^[a-z_][a-z0-9_]*$"))

;; Jumptable entries (references to labels)
(jumptable_body
  (identifier) @local.reference)

;; --------------------------
;; Import/include handling
;; --------------------------

;; Include statements don't create local scope but import external definitions
(control_include) @local.import

;; Include paths are external file references
(control_include
  path: (string_literal) @local.import)

;; --------------------------
;; Special Huff constructs
;; --------------------------

;; Template parameter calls
(template_parameter_call) @local.reference

;; Decorator references
(decorator_item  
  name: (identifier) @local.reference)

;; --------------------------
;; Built-in identifiers (global scope)
;; --------------------------

;; EVM opcodes are built-in and always available
(opcode) @local.definition.builtin

;; Built-in functions are global
[
  "__ERROR"
  "__EVENT_HASH" 
  "__FUNC_SIG"
  "__RIGHTPAD"
  "__codesize"
  "__tablesize"
  "__tablestart"
] @local.definition.builtin
