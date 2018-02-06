var MyLexer = require('genlexer');
var table = require('table');

var lexer = new MyLexer();

var tokens_list = [
    "blockcomment_end", "blockcomment_start", "boolean_literal", "brackets_end", "brackets_start",
    "character_literal", "comment", "EOF", "field_invoker", "float_literal", "identifier",
    "integer_literal", "keyword", "op_add", "op_addAssign", "op_and", "op_andand", "op_andAssign",
    "op_assign", "op_decrement", "op_div", "op_divAssign", "op_equalCompare", "op_greater",
    "op_greaterEqual", "op_increment", "op_less", "op_lessEqual", "op_Lshift", "op_LshiftEqual",
    "op_mod", "op_modAssign", "op_mul", "op_mulAssign", "op_not", "op_notequalCompare", "op_or",
    "op_orAssign", "op_oror", "op_Rshift", "op_RshiftEqual", "op_sub", "op_subAssign", "op_xor",
    "op_xorAssign", "paranthesis_end", "paranthesis_start", "separator", "set_end", "set_start",
    "string_literal", "terminator", "null_literal"
]


tokens = {}
tokens_list.forEach(function (token) {
    tokens[token] = [];
});
token = null;


function getNextToken(lexer, line, col) {
    token = null;
    try {
        token = lexer.nextToken();
    } catch (SyntaxError) {
        console.log("Syntax Error: Invalid token at Line: " + line + ", Column: " + col + ";\n");
    }
}


function printTokens() {
    data = [
        ['TOKEN', 'OCCURENCES', 'LEXEMES']
    ];

    line_indices = [0];

    index = 1;
    tokens_list.forEach(function (token) {
        if (tokens[token].length > 0) {
            first = true;
            tokens[token].forEach(function (lexeme) {
                if (first) {
                    line_indices.push(index);
                    data.push([token, tokens[token].length, lexeme]);
                    first = false;
                }
                else {
                    data.push(["", "", lexeme]);
                }
                index += 1;
            });
        }
    });
    line_indices.push(index);

    config = {
        drawHorizontalLine: (index, size) => {
            return (line_indices.indexOf(index) > -1);
        },
        columns: {
            0: {
                width: 20
            },
            1: {
                width: 20,
            },
            2: {
                width: 50,
                wrapWord: true
            }
        }
    };

    console.log(table.table(data, config));
}


function runLexer(lexer) {
    line = 1
    col = 1

    while (true) {
        getNextToken(lexer, line, col);
        if (lexer.isEOF(token)) break;

        if (token == null) return;

        line = token.pos.line + 1;
        col = token.pos.col + 1;

        if (!(token.name in tokens)) {
            console.log("Syntax Error: Invalid token at Line: " + line + ", Column: " + col + "; \t \"" + token.name + "\"\n");
            return;
        }
        tokens[token.name].push(token.value);
    }

    printTokens();
}


function main(lexer) {
    if (process.argv.length < 3) {
        console.log("Filename not specified. Terminating lexer");
        return;
    }

    var fs = require('fs');

    filename = process.argv[2];

    console.log("Reading from file:  " + filename + "\n");

    fs.readFile(filename, 'utf8', function (err, data) {
        if (err) throw err;

        data = data.replace(/;/g, " ; ")

        lexer.setInput(data);
        runLexer(lexer);
    });

    return;
}

main(lexer);
