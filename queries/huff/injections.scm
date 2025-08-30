;; ==========================
;; Huff Tree-sitter Injections  
;; ==========================

;; --------------------------
;; String content injections
;; --------------------------

;; Include paths are just file paths - no injection needed
;; (Removed bash injection as it creates unwanted parse nodes)

;; File paths don't need language injection - just treat as strings

;; Decorator string arguments might contain various formats
(decorator_item
  args: (string_literal) @injection.content
  (#match? @injection.content "^\"0x[a-fA-F0-9]+\"$")
  (#set! injection.language "hex"))

;; General hex string literals
((string_literal) @injection.content
  (#match? @injection.content "^\"0x[a-fA-F0-9]+\"$")
  (#set! injection.language "hex"))

;; --------------------------
;; Comment injections
;; --------------------------

;; Inject markdown in natspec comments
((natspec_line) @injection.content
  (#set! injection.language "markdown"))

((natspec_block) @injection.content  
  (#set! injection.language "markdown"))

;; Basic comment block injection for documentation
((comment_block) @injection.content
  (#match? @injection.content "^/\\*\\*")
  (#set! injection.language "markdown"))

;; --------------------------
;; Hex number highlighting  
;; --------------------------

;; Hex numbers could be highlighted with special hex syntax
((number_hex) @injection.content
  (#set! injection.language "hex"))

;; --------------------------
;; Stack comments (EVM bytecode simulation)
;; --------------------------

;; Comments that describe stack states could be highlighted specially
((comment_line) @injection.content
  (#match? @injection.content "//.*\\[.*\\]")
  (#set! injection.language "stackcomment"))

((comment_block) @injection.content
  (#match? @injection.content "/\\*.*\\[.*\\].*\\*/")  
  (#set! injection.language "stackcomment"))
