bin/node_modules/genlexer/index.js: src/tokens.l
	mkdir bin/node_modules
	cp -r src/node_modules/genlexer src/node_modules/lodash src/node_modules/table src/node_modules/ajv src/node_modules/ajv-keywords src/node_modules/escape-string-regexp src/node_modules/slice-ansi src/node_modules/fast-deep-equal src/node_modules/fast-json-stable-stringify src/node_modules/has-flag src/node_modules/json-schema-traverse src/node_modules/string-width src/node_modules/strip-ansi src/node_modules/ansi-regex src/node_modules/ansi-styles src/node_modules/chalk src/node_modules/co src/node_modules/color-convert src/node_modules/color-name src/node_modules/is-fullwidth-code-point src/node_modules/supports-color bin/node_modules/
	cp -r src/lexer src/index.js bin/
	chmod +x bin/lexer
	node src/node_modules/jacob/cmd/cmd.js -t src/tokens.l -l bin/node_modules/genlexer/index.js	