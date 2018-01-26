var MyLexer = require('genlexer');
var lexer = new MyLexer();


function runLexer(lexer) {
    var tokens = {};
    var firstToken = lexer.nextToken();

    while (!lexer.isEOF(firstToken)) {
        if (firstToken.name == "invalid") {
            console.log(">> ERROR:" + firstToken.value + " is not a valid syntax");
            return;
        }

        if (!(firstToken.name in tokens)) {
            tokens[firstToken.name] = 0;
        }
        tokens[firstToken.name] += 1;

        console.log(firstToken);
        console.log("");
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

        data = data.replace(/;/g, " ; ")

        lexer.setInput(data);
        runLexer(lexer);
    });


    return;
}

main(lexer);
