require("./prototype");
require("./descriptor");

global.Registers = require("./registers").Registers;

global.Variable = require("./components").Variable;
global.Function = require("./components").Function;

global.SymbolTable = require("./symbol-table").SymbolTable;

global.Assembly = require("./assembly").Assembly;

global.codeGen = require("./translate").codeGen;

global.registers = new Registers();

global.tac;

global.variables;
global.basic_blocks;
global.arrays;
global.array_list;

global.next_use_table;

global.assembly = new Assembly();

// -------------------------------------------------- EASY PRINTING ----------------------------------------------------------------------------------
function print(p) {
    console.log(p);
}


// -------------------------------------------------- GENERATING INFO FROM TAC -----------------------------------------------------------------------
function getLabels() {
    var labels = [];

    tac.forEach(function (instr) {
        if (instr[1] == "if" || instr[1] == "jump") {
            labels.push(parseInt(instr[instr.length - 1]));
        }
    });

    labels = labels.unique();
    labels.sort(function (a, b) { return a - b });

    return labels;
}

function getVariables() {
    var variables = [];

    tac.forEach(function (instr) {			//what about instructions like addition
        if (math_ops.indexOf(instr[1]) > -1 && keywords.indexOf(instr[2]) == -1) {
            variables.push(instr[2]);
        }
    });

    return variables.unique();
}

function getArrayList() {
	var array_list = [];

	tac.forEach(function (instr) {
        if (instr[1] == "array") {
            array_list.push(instr[2]);
        }
	});

	return array_list;
}

function getArrays() {
	var arrays = {};

	tac.forEach(function (instr) {
        if (instr[1] == "array") {
            arrays[instr[2]] = instr[3];
        }
	});
	
	return arrays;
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

    basic_blocks.forEach(function (block) {
        variables.forEach(function (variable) { variable_status[variable] = ["dead", Infinity]; });
        for (var i = block.length - 1; i >= 0; i--) {
            var curr_variable_status = {};
            variables.forEach(function (variable) { curr_variable_status[variable] = variable_status[variable]; });

            var instr = block[i];

            next_use_table[parseInt(instr[0]) - 1] = curr_variable_status;

            if (math_ops_binary.indexOf(instr[1]) > -1 || math_ops_involved.indexOf(instr[1]) > -1) {
                var dt = instr[2];
                var s1 = instr[3];
                var s2 = instr[4];

                variable_status[dt] = ["dead", Infinity];

                variable_status[s1] = ["live", parseInt(instr[0])];
                if (variables.indexOf(s2) > -1) {
                    variable_status[s2] = ["live", parseInt(instr[0])];
                }
            }
            else if (math_ops_unary.indexOf(instr[1]) > -1) {
                var v1 = instr[2];

                if (variables.indexOf(v1) > -1) {
                    variable_status[v1] = ["live", parseInt(instr[0])];
                }
                break;
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
    print("Reading from file:  " + filename);

    tac = fs.readFileSync(filename, "utf8").split("\n");
    tac.forEach(function (line, index) {
        tac[index] = line.trim().split("\t");
    });

    variables = getVariables();
    basic_blocks = getBasicBlocks();
	arrays = getArrays();
	array_list = getArrayList();

    next_use_table = getNextUseTable(basic_blocks, variables);

    assembly.setLabels(getLabels());

    assembly.add("global main");
    assembly.add("");
    assembly.add("extern printf");
    assembly.add("");
    assembly.add("section .data");

    assembly.shiftRight();
    assembly.add("_int db \"%i\", 0x0a, 0x00");

    variables.forEach(function (variable) {
        assembly.add(variable + "\tDD\t0");
        registers.address_descriptor[variable] = { "type": null, "name": null };
	});
	
	array_list.forEach(function (array) {
		assembly.add(array + "\tTIMES\t" + arrays[array] + "\tDD\t0")
	})

    assembly.shiftLeft();
    assembly.add("section .text")
    assembly.add("main:");
    assembly.shiftRight();
	print(variables + "ppppppppppppp");
    var inst_num = 0;
    basic_blocks.forEach(function (block) {
        block.forEach(function (line) {
			codeGen(line, next_use_table, inst_num);
			if (inst_num == 5) {
				print(registers.address_descriptor);
				print(next_use_table[6]);
				print(registers.register_descriptor);
			}
				inst_num++;
        });
        // assembly.add("");
        // registers.unloadRegisters();
        // assembly.add("");
    });

    assembly.addModules();

    if (process.argv.length == 4) {
        assembly.print(process.argv[3]);
    }
    else {
		assembly.print();
		// console.log(registers.address_descriptor);
		// console.log(next_use_table);
		// if
    }
}

main();