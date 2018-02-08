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

//------------------------------ EASY PRINTING----------------
function print(p){
    console.log(p);
}

//------------------------------------------------- stripper -------------------------
function stripper(){
    var i = 0;
    tac.forEach(function (instr) {
        tac[i][instr.length-1] = tac[i][instr.length-1].substring(0,instr[instr.length-1].length-1)
        
        i++;
    })
}


// -------------------------------------------------- GENERATING INFO FROM TAC -----------------------------------------------------------------------
function get_variables() {
    var variables = [];

    tac.forEach(function (instr) {			//what about instructions like addition
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
function getReg(variable, inst_num, next_use_table){
    var rep_reg;
    var rep_var;
    var rep_use;
    var flag = 0;
    registers_list.some(function (reg){
        //--------There is an empty register----------
        if (registers.register_descriptor[reg] == null){
            registers.register_descriptor[reg] = variable;
            registers.address_descriptor[variable] = {"type" : "reg", "name" : reg};
            flag = 1;
            rep_reg = reg;
            return true;
        }else{
            rep_reg = reg;    //rep is var to be replaced
            rep_var = registers.register_descriptor[reg];
            rep_use = next_use_table[inst_num][rep_var][1];
    
        }
    })

    if (flag == 1){
        return rep_reg;
    }
    registers_list.forEach(function (reg){
        //---------Replace with farthest next use-------
        var curr_var = registers.register_descriptor[reg];
        if (next_use_table[inst_num][curr_var][1] > rep_use){
            rep_reg = reg;
            rep_var = curr_var;
            rep_use = next_use_table[inst_num][curr_var][1];
        }
    })
    registers.register_descriptor[rep_reg] = variable;
    registers.address_descriptor[variable] = {"type" : "reg", "name" : rep_reg};
    
    assembly = assembly + "mov [" + rep_var + "], " + rep_reg + "\n";
    registers.address_descriptor[rep_var] = {"type" : "mem", "name" : rep_var};
    assembly = assembly + "mov " + rep_reg + ", [" + variable + "]\n";
    return rep_reg;
}

function codeGen(inst, next_use_table, inst_num){
    if (math_ops.indexOf(inst[1]) != -1){
        var x = inst[2];
        var y = inst[3];
        var des_x = registers.address_descriptor[x]["name"];
        var des_y = undefined;
        if(registers.address_descriptor[y] != undefined){
            des_y = registers.address_descriptor[y]["name"];
        }
        if (inst[1] == "="){
            if (registers.address_descriptor[x]["type"] == "reg"){    //x is in reg   
                if (des_y == null){
                    throw Error("Assigning uninitialised value");
                }
                if(des_y == undefined){
                    des_y = y;
                }else if(registers.address_descriptor[y]["type"] == "mem"){  //the operand y is in memory
                    des_y = "[" + des_y + "]";
                }
                assembly = assembly + "mov " + des_x + ", " + des_y + "\n";

            }
            else{                               //x is in memory
                if(des_y == undefined){         // y is constant
                    des_y = y;
                    registers.address_descriptor[x] = {"type" : "mem", "name" : x};
                    assembly = assembly + "mov [" + des_x + "], " + des_y + "\n";
                }else if(registers.address_descriptor[y]["type"] == "reg"){  //the operand y is in register
                    registers.address_descriptor[x] = {"type" : "mem", "name" : x};
                    assembly = assembly + "mov [" + des_x + "], " + des_y + "\n";
                }else{
                    if(next_use_table[inst_num][inst[2]][1] > next_use_table[inst_num][inst[3]][1]){    //y next use earlier than x
                        registers.address_descriptor[x] = {"type" : "mem", "name" : x};
                        des_y = getReg(y, inst_num, next_use_table);
                        assembly = assembly + "mov [" + des_x + "], " + des_y + "\n";
                    }else{
                        registers.address_descriptor[y] = {"type" : "mem", "name" : y};
                        des_x = getReg(x, inst_num, next_use_table);
                        assembly = assembly + "mov " + des_x + ", [" + des_y + "]\n";
                    }
                }
			}
		}else{
            var op = inst[2]
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
        tac[index] = line.split("\t");
    });

    stripper();

    global.variables = get_variables();
    var basic_blocks = get_basic_blocks();

    var next_use_table = get_next_use_table(basic_blocks, variables);
    var inst_num = 0;
    assembly = assembly + "global _start\n.DATA\n"
	variables.forEach(function (sym){
		assembly = assembly + sym + "   DD	?\n"
        registers.address_descriptor[sym] = {"type":null, "name":sym};
	})

	assembly = assembly + ".TEXT\n_start:\n"
	basic_blocks.forEach(function (block){
        for (var i = 0; i < block.length; i++){
            codeGen(block[i], next_use_table, inst_num);
            inst_num++;
		}
    })
    print(assembly);
    print(registers.address_descriptor);
    print(registers.register_descriptor);
}

main();