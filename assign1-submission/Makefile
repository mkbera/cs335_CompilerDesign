main: src/tokens.l
	mkdir -p bin/node_modules
	mkdir -p bin/node_modules/genlexer
	chmod +x bin/lexer
	node bin/node_modules/jacob/cmd/cmd.js -t src/tokens.l -l bin/node_modules/genlexer/index.js
