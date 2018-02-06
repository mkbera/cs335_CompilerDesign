## BUILDING THE LEXER ##

We use the 'jacob' module of node.js to generate a lexer. The 'tokens.l' file specifies the required tokens to be generated for the given regular expressions. The command required to generate the lexer is:

node src/node_modules/jacob/cmd/cmd.js -t src/tokens.l -l bin/node_modules/genlexer/index.js

The generated lexer is a module which can be called through another js file.


## RUNNING THE LEXER ##

As mentioned above, we can use the generated lexer module through another js file which in our case is index.js. To run this file, we need to provide it a program to output tokens.

node index.js filename

One can also just call 'bin/lexer filename' to run the index.js file.

**NOTE:** If there is an error stating node not found (on linux) try linking
(symlink) nodejs to node

	sudo ln -s /usr/bin/nodejs /usr/bin/node
