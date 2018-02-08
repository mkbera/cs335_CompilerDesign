require("./prototype");
require("./descriptor");

global.Registers = require("./registers").Registers;
global.registers_list = require("./registers").registers_list;
global.getReg = require("./registers").getReg;
global.getRegEmpty = require("./registers").getRegEmpty;
global.farthest_nextuse = require("./registers").farthest_nextuse;
global.unloadRegisters = require("./registers").unloadRegisters;

global.Variable = require("./components").Variable;
global.Function = require("./components").Function;

global.SymbolTable = require("./symbol-table").SymbolTable;

global.Assembly = require("./assembly").Assembly;

global.codeGen = require("./translate").codeGen;

global.registers = new Registers();

global.tac;
global.variables;
global.next_use_table;
global.basic_blocks;

global.assembly = new Assembly();

// -------------------------------------------------- EASY PRINTING ----------------------------------------------------------------------------------
function print(p) {
    console.log(p);
}


// -------------------------------------------------- GENERATING INFO FROM TAC -----------------------------------------------------------------------
function getVariables() {
    var variables = [];

    tac.forEach(function (instr) {			//what about instructions like addition
        if (math_ops.indexOf(instr[1]) > -1 && keywords.indexOf(instr[2]) == -1) {
            variables.push(instr[2]);
        }
    });

    return variables.unique();
}


function getBasicBlocks() {
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


function getNextUseTable(basic_blocks, variables) {
    var next_use_table = new Array(tac.length).fill(null);;

    var variable_status = {};
    variables.forEach(function (variable) { variable_status[variable] = ["dead", Infinity]; });

    basic_blocks.forEach(function (block) {
        for (var i = block.length - 1; i >= 0; i--) {
            var curr_variable_status = {};
            variables.forEach(function (variable) { curr_variable_status[variable] = variable_status[variable]; });

            var instr = block[i];

            next_use_table[parseInt(instr[0]) - 1] = curr_variable_status;

            if (math_ops.indexOf(instr[1]) > -1) {
                var dt = instr[2];
                var s1 = instr[3];
                var s2 = instr[4];

                variable_status[dt] = ["dead", Infinity];

                variable_status[s1] = ["live", parseInt(instr[0])];
                if (variables.indexOf(s2) > -1) {
                    variable_status[s2] = ["live", parseInt(instr[0])];
                }
            }
            switch (instr[1]) {
                case "if": {
                    var c1 = instr[3];
                    var c2 = instr[4];

                    variable_status[c1] = ["live", parseInt(instr[0])];

                    if (variables.indexOf(c2) > -1) {
                        variable_status[c2] = ["live", parseInt(instr[0])];
                    }
                    break;
                }
                case "print": {
                    var v1 = instr[2];

                    if (variables.indexOf(v1) > -1) {
                        variable_status[v1] = ["live", parseInt(instr[0])];
                    }
                    break;
                }
                case "=": {
                    var v1 = instr[2];
                    var v2 = instr[3];

                    variable_status[v1] = ["dead", Infinity];

                    if (variables.indexOf(v2) > -1) {
                        variable_status[v2] = ["live", parseInt(instr[0])];
                    }
                    break;
                }
            }
        }
    });
    return next_use_table;
}


// -------------------------------------------------- MAIN ENTRY CODE --------------------------------------------------------------------------------
function main() {
    if (process.argv.length < 3) {
        print("Filename not specified. Terminating lexer");
        return;
    }

    var fs = require("fs");

    filename = process.argv[2];
    // print("Reading from file:  " + filename);

    tac = fs.readFileSync(filename, "utf8").split("\n");
    tac.forEach(function (line, index) {
        tac[index] = line.trim().split("\t");
    });

    variables = getVariables();
    basic_blocks = getBasicBlocks();

    next_use_table = getNextUseTable(basic_blocks, variables);

    assembly.add("global main");
    assembly.add("section .data");

    variables.forEach(function (variable) {
        assembly.add("\t" + variable + "\tDD\t0");
        registers.address_descriptor[variable] = { "type": null, "name": null };
    });

    assembly.add("section .text")
    assembly.add("main:");

    var inst_num = 0;
    basic_blocks.forEach(function (block) {
        block.forEach(function (line) {
            codeGen(line, next_use_table, inst_num);
            inst_num++;
        });
        unloadRegisters();
    });

    assembly.add("\t");
    assembly.add("\tmov eax, 1");
    assembly.add("\tint 0x80");

    assembly.print();
}

main();