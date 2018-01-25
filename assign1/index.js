var MyLexer = require('genlexer');
var lexer = new MyLexer();


var dict = {
    boolean: 0,
    break: 0,
    byte: 0,
    case: 0,
    char: 0,
    class: 0,
    const: 0,
    continue: 0,
    default: 0,
    do: 0,
    double: 0,
    else: 0,
    extends: 0,
    float: 0,
    for: 0,
    if: 0,
    import: 0,
    instanceof: 0,
    int: 0,
    long: 0,
    new: 0,
    return: 0,
    short: 0,
    static: 0,
    super: 0,
    switch: 0,
    this: 0,
    void: 0,
    while: 0,
    integer: 0,
    float: 0
};


function runLexer(lexer) {
    var firstToken = lexer.nextToken();

    while (!lexer.isEOF(firstToken)) {
        //if (!(firstToken.name in dict)) {
            //console.log("\t>> ERROR:\t" + firstToken.value + " is not a valid syntax");
            //return;
        //}
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

        lexer.setInput(data);
        runLexer(lexer);
    });


    return;
}

main(lexer);
