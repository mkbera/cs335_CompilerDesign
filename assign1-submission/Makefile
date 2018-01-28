main: src/tokens.l
	mkdir -p src/node_modules
	mkdir -p src/node_modules/genlexer
	chmod +x bin/lexer
	node src/node_modules/jacob/cmd/cmd.js -t src/tokens.l -l src/node_modules/genlexer/index.js
