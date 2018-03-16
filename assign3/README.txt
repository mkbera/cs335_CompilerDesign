#################### CS335: Compiler Design -- Assignment 3 ####################

----------------------------- BUILDING THE PARSER ------------------------------

In order to prepare the parser, use the following commands

	$ cd path/to/asgn3
	$ make

**NOTE**
The line which actually builds the parser is commented in the  Makefile,  as  it
takes a long time to complete.	 If  you  wish	to	remake	the  parser,  it  is
recommended to uncomment this line, or	separately	run  the  commented  command
given in the 'all' rule.


------------------------------ RUNNING THE PARSER ------------------------------

After building the parser, you can run the parser from the 'asg3'  directory  as
follows

	$ bin/parser path/to/java/file [path/to/output/html/file]
	$ chrome / firefox path/to/output/html/file

The default output file will be created as 'out.html',	in	the  'asgn3'  folder


--------------------------- SOME CHANGES IN GRAMMAR ----------------------------

## Array Access

Before the square brackets, there needs to be a 'colon' (':'), i.e. the (i, j)th
element    of	 Array	  'arr'    can	  be	accessed	as	  =>	a:[i][j]


---------------------------------- TOOLS USED ----------------------------------

For this assignment, we have made use of 'jison' which is available as	an	open
source plugin for node.js.	The docs are  available  at  'https://zaa.ch/jison/'


---------------------------------- ALGORITHM -----------------------------------

For our grammar, we have used the **LR(1)**  grammar  to  generate	the  parser.
Although this option makes the parser generation slower, however it  allowed  us
to  write simpler rules.


------------------------------ FILES DESCRIPTION -------------------------------

src/includes/tokens.jison	:	Contains   the	 required	tokens	 for   lexer
src/includes/grammar.jison	:	Contains the grammar  and tokens used  by  jison
								for buiding the parser
src/grammar.js	 			:	Contains the grammar  rules in the  json  format
src/parsgen.js	 			:	Creates  grammar.jison from the tokens.jison and
								the grammar.js files
src/index.js   				:   Uses the generated	parser to parse the	required
								test file
out.html                    :   Contains the final parsed  output in HTML format

The generated parser is saved in node_modules/parser/index.js
