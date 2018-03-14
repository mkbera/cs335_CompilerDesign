all:
	mkdir -p src/node_modules/parser
	node src/parsergen.js src/includes/grammar.jison
	jison -p slr -o src/node_modules/parser/index.js src/includes/grammar.jison
	mkdir -p out
	mkdir -p bin
	cp src/parser bin/parser
	chmod +x bin/parser

clean:
	# rm -r bin src/node_modules/parser out
	rm -r bin out
