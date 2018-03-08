all:
	mkdir -p src/includes
	mkdir -p src/node_modules/lexer
	mkdir -p src/node_modules/parser
	node src/parsergen.js src/includes/grammar.y
	# node src/node_modules/jacob/cmd/cmd.js -t src/includes/tokens.l -l src/node_modules/lexer/index.js
	node src/node_modules/jacob/cmd/cmd.js -g src/includes/grammar.y -p src/node_modules/parser/index.js
	mkdir -p bin
	cp src/parser bin/parser
	chmod +x bin/parser

clean:
	# rm -r bin src/node_modules/parser src/node_modules/lexer
	rm -r bin src/node_modules/parser
