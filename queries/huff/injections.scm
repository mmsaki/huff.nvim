(decorator_item
  args: (string_literal) @injection.content
  (#match? @injection.content "^\"0x[a-fA-F0-9]+\"$")
  (#set! injection.language "hex"))

((string_literal) @injection.content
  (#match? @injection.content "^\"0x[a-fA-F0-9]+\"$")
  (#set! injection.language "hex"))

((number) @injection.content
  (#set! injection.language "hex"))
