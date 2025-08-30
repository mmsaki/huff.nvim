(decorator_item
  args: (string_literal) @injection.content
  (#match? @injection.content "^\"0x[a-fA-F0-9]+\"$")
  (#set! injection.language "hex"))

((string_literal) @injection.content
  (#match? @injection.content "^\"0x[a-fA-F0-9]+\"$")
  (#set! injection.language "hex"))

((number_hex) @injection.content
  (#set! injection.language "hex"))

((comment_line) @injection.content
  (#match? @injection.content "//.*\\[.*\\]")
  (#set! injection.language "stackcomment"))

((comment_block) @injection.content
  (#match? @injection.content "/\\*.*\\[.*\\].*\\*/")  
  (#set! injection.language "stackcomment"))
