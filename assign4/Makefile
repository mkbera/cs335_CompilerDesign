all:
	jison -p lr -o src/node_modules/parser/index.js src/includes/grammar.jison
	mkdir -p out
	mkdir -p bin
	cp src/irgen bin/irgen
	chmod +x bin/irgen

clean:
	rm -r bin out
