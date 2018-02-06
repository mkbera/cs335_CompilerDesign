var reg = require('./registers');
var smt = require('./symbol-table');

var Registers = reg.Registers;
var SymbolTable = smt.SymbolTable;

var tac;

// -------------------------------------------------- ARRAY PROTOTYPE FUNCTIONS ----------------------------------------------------------------------
Array.prototype.contains = function (v) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] === v) return true;
    }
    return false;
};

Array.prototype.unique = function () {
    var arr = [];
    for (var i = 0; i < this.length; i++) {
        if (!arr.includes(this[i])) {
            arr.push(this[i]);
        }
    }
    return arr;
}


// -------------------------------------------------- EXTRACTING IDENTIFIERS FROM TAC ----------------------------------------------------------------
function get_labels() {
    var labels = [];

    tac.forEach(function (instr) {
        if (instr[0] == "block" || instr[0] == "function") {
            labels.push(instr[1]);
        }
    });

    return labels.unique();
}


function get_variables() {
    var variables = [];

    tac.forEach(function (instr) {
        if (smt.keywords.indexOf(instr[0]) == -1) {
            variables.push(instr[1]);
        }
    });

    return variables.unique();
}


// -------------------------------------------------- MAIN ENTRY CODE --------------------------------------------------------------------------------
function main() {
    if (process.argv.length < 3) {
        console.log("Filename not specified. Terminating lexer");
        return;
    }

    var fs = require("fs");

    filename = process.argv[2];
    console.log("Reading from file:  " + filename + "\n");

    tac = fs.readFileSync(filename, "utf8").split("\n");
    tac.forEach(function (line, index) {
        tac[index] = line.split("\t");
    });

    var labels = get_labels();
    var variables = get_variables();

    // var inst = data.split("\n");
    // var num_inst = inst.length;

    // for (i = 0; i < num_inst; i++) {
    //     var fields = inst[i].split("\t");
    //     if (variable_ops.indexOf(fields[0]) > -1) {
    //         identifier_to_class[fields[1]] = new SymbolTable(fields[1], "int", null);
    //     }
    //     else if (function_ops.indexOf(fields[0]) > -1) {
    //         identifier_to_class[fields[1]] = new SymbolTable(fields[1], "function", "int");
    //     }
    // }
}

main();