// mygenerator.js
var Parser = require("jison").Parser;

var grammar = {
    "lex": {
        "rules": [
           ["\\s+", "/* skip whitespace */"],
           ["[:]", "return 'colon';"]
        ]
    },

    "bnf": {
        "expressions" :[ "colon", ]
    }
};

var parser = new Parser(grammar);

// generate source, ready to be written to disk
var parserSource = parser.generate();

// you can also use the parser directly from memory

parser.parse(":");
// returns true

// parser.parse("adfe34bc zxg");
// throws lexical error