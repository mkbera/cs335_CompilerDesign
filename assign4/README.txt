#################### CS335: Compiler Design -- Assignment 4 ####################

----------------------------- BUILDING THE IRGEN ------------------------------

In order to build the parser, use the following commands

	$ cd path/to/asgn4
	$ make

**NOTE**
The line which actually builds the parse is commented in the  Makefile,  as  it
takes a long time to complete.	 If  you  wish	to	remake	the  parser,  it  is
recommended to uncomment this line, or	separately	run  the  commented  command
given in the 'all' rule.


------------------------------ RUNNING THE IRGEN ------------------------------

After building the parser, you can run the parser from the 'asg4'  directory as
follows

	$ bin/irgen path/to/java/file [path/to/output/html/file]
	$ chrome / firefox path/to/output/html/file

The default output file  will be  created  as 'out.ir',  in the  'asgn4'  folder


--------------------------- SOME CHANGES IN GRAMMAR ----------------------------

## Array Access

Before the square brackets, there needs to be a 'colon' (':'), i.e. the (i, j)th
element    of	 Array	  'arr'    can	  be	accessed	as	  =>	a:[i][j]

This was done to avoid a  reduce/reduce conflict, for which we couldn't find any
other workaround.

## Array Declaration

Array declaration will follow the following format:

	int[d1][...][dn] arr;

		OR

	int[d1][...][dn] arr = { { ... }, ... { ... } }

where each dimension is an integer literal


---------------------------------- TOOLS USED ----------------------------------

For this assignment, we have made use of 'jison' which is available as	an	open
source plugin for node.js.	The docs are  available  at  'https://zaa.ch/jison/'


------------------------------ FILES DESCRIPTION -------------------------------

src/includes/tokens.jison	:	Contains   the	 required	tokens	 for   lexer
src/includes/grammar.jison	:	Contains the grammar  and tokens used  by  jison
								for buiding  the parser along with the  semantic
								actions for each rule
src/index.js   				:   Uses the generated	parser to parse the	required
								test file
symbol-table.js				:	contains   the   class   symboltable   with  the
								structure of the  symbol table and functions for
								building the symbol table.
