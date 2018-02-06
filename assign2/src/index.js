require("./prototype");
require("./variables");

var Registers = require("./registers").Registers;
var symbol_table = require("./symbol-table").symbol_table;


var tac;


// -------------------------------------------------- GENERATING INFO FROM TAC -----------------------------------------------------------------------
function get_variables() {
    var variables = [];

    tac.forEach(function (instr) {
        if (instr[1] == "=" && keywords.indexOf(instr[2]) == -1) {
            variables.push(instr[2]);
        }
    });

    return variables.unique();
}


function get_basic_blocks() {
    var splits = [];

    tac.forEach(function (instr, index) {
        switch (instr[1]) {
            case "if": {
                splits.push(parseInt(index + 1))
                splits.push(instr[instr.length - 1] - 1)
                break;
            }
            case "jump": {
                splits.push(index + 1)
                splits.push(instr[instr.length - 1] - 1)
                break;
            }
            case "function": {
                splits.push(index);
                break;
            }
        }
    });

    splits = splits.unique();
    splits.sort(function (a, b) { return a - b });
    splits.push(-1);

    var basic_blocks = [[]];
    var curr = 0;
    tac.forEach(function (instr, index) {
        if (splits[curr] == index) {
            basic_blocks.push([]);
            curr += 1;
        }
        basic_blocks[basic_blocks.length - 1].push(instr);
    });

    return basic_blocks;
}


function get_next_use_table(basic_blocks, variables) {
    var next_use_table = new Array(tac.length).fill(null);;

    var symbol_table = {};
    variables.forEach(function (variable) { symbol_table[variable] = ["live", null]; });

    basic_blocks.forEach(function (block) {
        console.log(block);
        for (var i = block.length - 1; i >= 0; i--) {
            var curr_symbol_table = {};
            variables.forEach(function (variable) { curr_symbol_table[variable] = symbol_table[variable]; });

            var instr = block[i];

            next_use_table[parseInt(instr[0]) - 1] = curr_symbol_table;

            if (math_ops.indexOf(instr[1]) > -1) {
                var dt = instr[2];
                var s1 = instr[3];
                var s2 = instr[4];

                symbol_table[dt] = ["dead", null]

                symbol_table[s1] = ["live", parseInt(instr[0])]
                if (variables.indexOf(s2) > -1) {
                    symbol_table[s2] = ["live", parseInt(instr[0])]
                }
            }
        }
    });

    console.log(next_use_table);
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

    var variables = get_variables();
    var basic_blocks = get_basic_blocks();

    var nest_use_table = get_next_use_table(basic_blocks, variables);

    // var inst = data.split("\n");
    // var num_inst = inst.length;

    // for (i = 0; i < num_inst; i++) {
    //     var fields = inst[i].split("\t");
    //     if (variable_ops.indexOf(fields[0]) > -1) {
    //         identifier_to_class[fields[1]] = new symbol_table(fields[1], "int", null);
    //     }
    //     else if (function_ops.indexOf(fields[0]) > -1) {
    //         identifier_to_class[fields[1]] = new symbol_table(fields[1], "function", "int");
    //     }
    // }
}

main();