--------------------------------    BUILDING THE PARSER   -----------------------------------------
Use the following command:
$ make


--------------------------------	RUNNING THE PARSER	-------------------------------------------
Use the following commands:
$ bin/parser test/test.java
$ firefox out.html


----------------------------    SOME CHANGES IN GRAMMAR   -----------------------------------------
Array Access:
    ith element of Array "a" => a:[i]

Method Declaration:
    The return type of method is declared in a different way:
    For a method "sample()" with return type int following will be the decleration:
    public sample() : int {
        //your code goes here
    }


-------------------------------------	TOOLS USED	-------------------------------------------------
JISON PARSER : https://zaa.ch/jison/


-------------------------------------	ALGORITHM	-------------------------------------------------
The parser is LR(1) parser.


-----------------------------------	FILES DESCRIPTION	---------------------------------------------
src/includes/tokens.jison	:	Contains the required tokens for lexer
src/includes/grammar.jison	:	Contains the grammar and tokens used by jison for buiding the parser
src/grammar.js 				:	Contains the grammar rules in the json format
src/parsgen.js				:	Creates grammar.jison from /includes/tokens.jison and /grammar.js
src/index.js                :   Uses the generated parser to parse the required test file
out.html                    :   Contains the final parsed output in HTML format

The generated parser is saved in node_modules/parser/index.js