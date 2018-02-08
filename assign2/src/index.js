require("./prototype");
require("./descriptor");

var Registers = require("./registers").Registers;
var registers_list = require("./registers").registers_list;

var Variable = require("./components").Variable;
var Function = require("./components").Function;

var SymbolTable = require("./symbol-table").SymbolTable;

var registers = new Registers();

var tac;

var assembly = "";

// -------------------------------------------------- EASY PRINTING ----------------------------------------------------------------------------------
function print(p) {
    console.log(p);
}


// -------------------------------------------------- GENERATING INFO FROM TAC -----------------------------------------------------------------------
function getVariables() {
    var variables = [];

    tac.forEach(function (instr) {			//what about instructions like addition
        if (instr[1] == "=" && keywords.indexOf(instr[2]) == -1) {
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

//------------------------------------------------- REGISTER ALLOCATION ------------------------------------------------------------------------------
function getRegEmpty (variable, inst_num, next_use_table) {	//returns a register only if empty
	var flag = 0;
	var rep_var;
    registers_list.some(function (reg) {
        //--------There is an empty register----------
        if (registers.register_descriptor[reg] == null) {
            registers.register_descriptor[reg] = variable;
            registers.address_descriptor[variable] = { "type": "reg", "name": reg };
            flag = 1;
            rep_reg = reg;
            return true;
		}
		rep_var = registers.register_descriptor[reg];
		if (next_use_table[inst_num][rep_var][1] == Infinity) {	//no next use empty it
			assembly = assembly + "mov [" + rep_var + "], " + reg + "\n";
			registers.address_descriptor[rep_var] = {"type" : "mem", "name" : rep_var};
			registers.address_descriptor[variable] = {"type" : "reg", "name" : reg};
			registers.register_descriptor[reg] = variable;
			flag = 1;
			rep_reg = reg;
			return true;
		}
    })
    if (flag == 1) {
        return rep_reg;
    }else{
		return null;
	}
}

function getReg(variable, inst_num, next_use_table) {
    var rep_reg;
    var rep_var;
    var rep_use;
	var flag = 0;
	rep_reg = getRegEmpty(variable, inst_num, next_use_table);
	if (rep_reg != null){
		return rep_reg;
	}
    // registers_list.some(function (reg) {
    //     //--------There is an empty register----------
    //     if (registers.register_descriptor[reg] == null) {
    //         registers.register_descriptor[reg] = variable;
    //         registers.address_descriptor[variable] = { "type": "reg", "name": reg };
    //         flag = 1;
    //         rep_reg = reg;
    //         return true;
    //     } else {
    //         rep_reg = reg;    //rep is var to be replaced
    //         rep_var = registers.register_descriptor[reg];
    //         rep_use = next_use_table[inst_num][rep_var][1];
    //     }
    // })
    // if (flag == 1) {
    //     return rep_reg;
    // }
    registers_list.forEach(function (reg) {
        //---------Replace with farthest next use-------
        var curr_var = registers.register_descriptor[reg];
        if (next_use_table[inst_num][curr_var][1] > rep_use) {
            rep_reg = reg;
            rep_var = curr_var;
            rep_use = next_use_table[inst_num][curr_var][1];
        }
    })
    registers.register_descriptor[rep_reg] = variable;
    registers.address_descriptor[variable] = { "type": "reg", "name": rep_reg };

    assembly = assembly + "mov [" + rep_var + "], " + rep_reg + "\n";
    registers.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
    assembly = assembly + "mov " + rep_reg + ", [" + variable + "]\n";
    return rep_reg;
}

function farthest_nextuse (variable, inst_num, next_use_table) {
	var flag = 1
	variables.some(function (new_var) {
		if (next_use_table[inst_num][variable][2] < next_use_table[inst_num][new_var][2]) {
			flag = 0;
			return true;
		}
	})
	if (flag == 1){
		return true;
	}else {
		return false;
	}
}

function codeGen(inst, next_use_table, inst_num) {
    if (math_ops.indexOf(inst[1]) != -1) {
        var x = inst[2];
        var y = inst[3];
        var des_x = registers.address_descriptor[x]["name"];
        var des_y = undefined;
        if (registers.address_descriptor[y] != undefined) {
            des_y = registers.address_descriptor[y]["name"];
        }
        if (inst[1] == "=") {
            if (registers.address_descriptor[x]["type"] == "reg") {    //x is in reg   
                if (des_y == null) {
                    throw Error("Assigning uninitialised value");
                }
                if (des_y == undefined) {
                    des_y = y;
                } else if (registers.address_descriptor[y]["type"] == "mem") {  //the operand y is in memory
                    des_y = "[" + des_y + "]";
                }
                assembly = assembly + "mov " + des_x + ", " + des_y + "\n";
            }
            else {                               //x is in memory
                if (des_y == undefined) {         // y is constant
                    des_y = y;
                    registers.address_descriptor[x] = { "type": "mem", "name": x };
                    assembly = assembly + "mov [" + des_x + "], " + des_y + "\n";
                } else if (registers.address_descriptor[y]["type"] == "reg") {  //the operand y is in register
                    registers.address_descriptor[x] = { "type": "mem", "name": x };
                    assembly = assembly + "mov [" + des_x + "], " + des_y + "\n";
                } else {
                    if (next_use_table[inst_num][inst[2]][1] > next_use_table[inst_num][inst[3]][1]) {    //y next use earlier than x
                        registers.address_descriptor[x] = { "type": "mem", "name": x };
                        des_y = getReg(y, inst_num, next_use_table);
                        assembly = assembly + "mov [" + des_x + "], " + des_y + "\n";
                    } else {
                        registers.address_descriptor[y] = { "type": "mem", "name": y };
                        des_x = getReg(x, inst_num, next_use_table);
                        assembly = assembly + "mov " + des_x + ", [" + des_y + "]\n";
                    }
                }
            }
        } else if (math_ops_1.indexOf(inst[1]) > -1) {
			var op = inst[1];
			var z = inst[4];
			var des_z;
			if(variables.indexOf(z) == -1) {		//z is constant
				des_z = z;
				if(registers.address_descriptor[y]["type"] == "reg"){		//y is in register
					if (registers.address_descriptor[x]["type"] == "reg"){	//x is in register
						assembly = assembly + "mov " + des_x + ", " + des_y + "\n";
						assembly = assembly + map_op[op] + " " + des_x + ", " + des_z + "\n";
					}
					else if (next_use_table[inst_num][y][1] == Infinity) {	//No next use of y
						assembly = assembly + "mov [" + y + "], " + des_y + "\n";
						assembly = assembly + map_op[op] + " " + des_y + ", " + des_z + "\n";
						registers.address_descriptor[y] = {"type" : "mem", "name" : y};
						registers.address_descriptor[x] = {"type" : "reg", "name" : des_y};
						registers.register_descriptor[des_y] = x;
					}
					else if ((reg = getRegEmpty(variable, inst_num, next_use_table)) != null) {	//got empty reg for x
						assembly = assembly + "mov " + reg + ", " + des_y + "\n";
						assembly = assembly + map_op[op] + " " + reg + ", " + des_z + "\n";
					}
					else if (farthest_nextuse(x, inst_num, next_use_table)){	//x has no or farthest next use
						assembly = assembly + "mov [" + x + "] " + des_y + "\n";
						assembly = assembly + map_op + " [" + x + "], " + des_z + "\n";
					}
					else if (farthest_nextuse(y, inst_num, next_use_table)) {	//y has farthest next use
						assembly = assembly + "mov [" + y + "], " + des_y + "\n";
						assembly = assembly + map_op[op] + " " + des_y + ", " + des_z + "\n";
						registers.address_descriptor[y] = {"type" : "mem", "name" : y};
						registers.address_descriptor[x] = {"type" : "reg", "name" : des_y};
						registers.register_descriptor[des_y] = x;
					}
					else {	//some other reg has farthest next use
						var reg = getReg(x, inst_num, next_use_table);
						assembly = assembly + "mov " + reg + ", " + des_y + "\n";
						assembly = assembly + map_op[op] + " " + reg + ", " + des_z + "\n";
					}
				}
				else {	//y not in reg
					if (registers.address_descriptor[x]["type"] == "reg") {	// x in register
						assembly = assembly + "mov " + des_x + ", [" + y + "]\n";
						assembly = assembly + map_op[op] + " " + des_x + ", " + des_z + "\n";
					}
					else {
						if (next_use_table[inst_num][inst[2]][1] > next_use_table[inst_num][inst[3]][1]) {    //y next use earlier than x
							registers.address_descriptor[x] = { "type": "mem", "name": x };
							des_y = getReg(y, inst_num, next_use_table);
							if ((reg = getRegEmpty(variable, inst_num, next_use_table)) != null) {	//got empty reg for x
								assembly = assembly + "mov " + reg + ", " + des_y + "\n";
								assembly = assembly + map_op[op] + " " + reg + ", " + des_z + "\n";
							}
							else if (farthest_nextuse(x, inst_num, next_use_table)){	//x has no or farthest next use
								assembly = assembly + "mov [" + x + "] " + des_y + "\n";
								assembly = assembly + map_op + " [" + x + "], " + des_z + "\n";
							}
							else {	//some other reg has farthest next use
								var reg = getReg(x, inst_num, next_use_table);
								assembly = assembly + "mov " + reg + ", " + des_y + "\n";
								assembly = assembly + map_op[op] + " " + reg + ", " + des_z + "\n";
							}
						}
						else {
							registers.address_descriptor[y] = { "type": "mem", "name": y };
							des_x = getReg(x, inst_num, next_use_table);
							assembly = assembly + "mov " + des_x + ", [" + y + "]\n";
							assembly = assembly + map_op[op] + " " + des_x + ", " + des_z + "\n";
						}
					}
				}
			}
        }
    }
}


// -------------------------------------------------- MAIN ENTRY CODE --------------------------------------------------------------------------------
function main() {
    if (process.argv.length < 3) {
        print("Filename not specified. Terminating lexer");
        return;
    }

    var fs = require("fs");

    filename = process.argv[2];
    print("Reading from file:  " + filename + "\n");

    tac = fs.readFileSync(filename, "utf8").split("\n");
    tac.forEach(function (line, index) {
        tac[index] = line.trim().split("\t");
    });

    global.variables = getVariables();
    var basic_blocks = getBasicBlocks();

    var next_use_table = getNextUseTable(basic_blocks, variables);

    assembly = assembly + "global _start\nsection .data\n";

    variables.forEach(function (sym) {
        assembly = assembly + sym + "\tDD\t?\n"
        registers.address_descriptor[sym] = { "type": null, "name": sym };
    });

    assembly = assembly + "section .text\n_start:\n"

    var inst_num = 0;
    basic_blocks.forEach(function (block) {
        for (var i = 0; i < block.length; i++) {
            codeGen(block[i], next_use_table, inst_num);
            inst_num++;
        }
    });

    print(registers.address_descriptor);
    print(registers.register_descriptor);
    print(assembly);
}

main();