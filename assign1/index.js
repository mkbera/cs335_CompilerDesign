var MyLexer = require('genlexer');
var lexer = new MyLexer();


var dict = {
    keyword_boolean: "boolean",
    keyword_break: "break",
    keyword_byte: "byte",
    keyword_case: "case",
    keyword_char: "char",
    keyword_class: "class",
    keyword_const: "const",
    keyword_continue: "continue",
    keyword_default: "default",
    keyword_do: "do",
    keyword_double: "double",
    keyword_else: "else",
    keyword_extends: "extends",
    keyword_float: "float",
    keyword_for: "for",
    keyword_if: "if",
    keyword_import: "import",
    keyword_instanceof: "instanceof",
    keyword_int: "int",
    keyword_long: "long",
    keyword_new: "new",
    keyword_return: "return",
    keyword_short: "short",
    keyword_static: "static",
    keyword_super: "super",
    keyword_switch: "switch",
    keyword_this: "this",
    keyword_void: "void",
    keyword_while: "while",
    integer: "int",
    float: "decimal"
};


function runLexer(lexer) {
    var firstToken = lexer.nextToken();

    while (!lexer.isEOF(firstToken)) {
        if (!(firstToken.name in dict)) {
            console.log("\t>> ERROR:\t" + firstToken.value + " is not a valid syntax");
            return;
        }
        console.log(firstToken);
        firstToken = lexer.nextToken();
    }

    console.log("EOF reached");
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

        lexer.setInput(data);
        runLexer(lexer);
    });


    return;
}

main(lexer);