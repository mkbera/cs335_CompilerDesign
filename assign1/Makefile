main: src/tokens.l
	mkdir -p src/node_modules
	mkdir -p src/node_modules/genlexer
	mkdir -p bin
	cp src/lexer bin/lexer
	chmod +x bin/lexer
	node src/node_modules/jacob/cmd/cmd.js -t src/tokens.l -l src/node_modules/genlexer/index.js

clean:
	rm -r bin
