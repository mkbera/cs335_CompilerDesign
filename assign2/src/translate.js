function codeGen(instr, next_use_table, line_nr) {
	if (assembly.labels.indexOf(line_nr + 1) > -1) {
		registers.unloadRegisters();

		assembly.shiftLeft();
		assembly.add("label_" + (line_nr + 1) + ":");
		assembly.shiftRight();
	}

	var op = instr[1];

	if (math_ops.indexOf(op) > -1) {
		var x = instr[2];
		var y = instr[3];

		var des_x = registers.address_descriptor[x]["name"];
		if (des_x == null) {
			registers.address_descriptor[x] = { "type": "mem", "name": x };
			des_x = registers.address_descriptor[x]["name"];
		}

		var des_y = "";
		if (variables.indexOf(y) != -1) {
			des_y = registers.address_descriptor[y]["name"];
		}

		if (op == "=") {
			if (x == y) {
				return;
			}

			if (registers.address_descriptor[x]["type"] == "mem") {
				if (next_use_table[line_nr][x][1] != Infinity) {
					des_x = registers.getReg(x, line_nr, next_use_table, safe = [y], safe_regs = [], print = true);
				}
			}

			if (registers.address_descriptor[x]["type"] == "reg") {    //x is in reg   
				if (des_y == null) {
					throw Error("Assigning Uninitialised Value");
				}
				if (variables.indexOf(y) == -1) {
					des_y = y;
				}
				else if (registers.address_descriptor[y]["type"] == "mem") {  //the operand y is in memory
					des_y = "[" + des_y + "]";
				}
				assembly.add("mov dword " + des_x + ", " + des_y);
			}
			else {                               //x is in memory
				des_x = "[" + des_x + "]";
				if (variables.indexOf(y) == -1) {         // y is constant
					des_y = y;
					assembly.add("mov dword " + des_x + ", " + des_y);
				}
				else if (registers.address_descriptor[y]["type"] == "reg") {  //the operand y is in register
					if (next_use_table[line_nr][x][1] < next_use_table[line_nr][y][1]) {
						assembly.add("mov dword [" + y + "], " + des_y);
						registers.address_descriptor[x] = { "type": "reg", "name": des_y };
					}
					else {
						assembly.add("mov dword " + des_x + ", " + des_y);
					}
				}
				else {
					des_y = registers.getReg(y, line_nr, next_use_table);
					assembly.add("mov dword " + des_y + ", [" + y + "]");
					assembly.add("mov dword " + des_x + ", " + des_y);
				}
			}
		}
		else if (math_ops_simple.indexOf(op) > -1) {
			var z = instr[4];
			var des_z;

			if (des_y == null) {
				throw Error("Assigning Uninitialised Value");
			}
			if (registers.address_descriptor[y]["type"] == "mem") {
				des_y = registers.getReg(y, line_nr, next_use_table, safe = [x, z], safe_regs = [], print = true);
				assembly.add("mov dword " + des_y + ", [" + y + "]");
			}

			if (variables.indexOf(z) == -1) {
				des_z = z;
			}
			else {
				if (registers.address_descriptor[z]["type"] == "reg") {
					des_z = registers.address_descriptor[z]["name"];
				}
				else {
					des_z = "[" + registers.address_descriptor[z]["name"] + "]";
				}
			}

			des_x = registers.address_descriptor[x]["name"];

			if (registers.address_descriptor[x]["type"] == "reg") {	//x is in register
				if (des_x != des_y) {
					assembly.add("mov dword " + des_x + ", " + des_y);
				}
				assembly.add(map_op[op] + " dword " + des_x + ", " + des_z);
			}
			else if (next_use_table[line_nr][y][1] == Infinity) {	//No next use of y
				assembly.add("mov dword [" + y + "], " + des_y);
				assembly.add(map_op[op] + " dword " + des_y + ", " + des_z);
				registers.address_descriptor[y] = { "type": "mem", "name": y };
				registers.address_descriptor[x] = { "type": "reg", "name": des_y };
				registers.register_descriptor[des_y] = x;
			}
			else if ((reg = registers.getEmptyReg(variable, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true)) != null) {	//got empty reg for x
				assembly.add("mov dword " + reg + ", " + des_y);
				assembly.add(map_op[op] + " dword " + reg + ", " + des_z);
			}
			else if ((reg = registers.getNoUseReg(variable, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true)) != null) {	//got empty reg for x
				assembly.add("mov dword " + reg + ", " + des_y);
				assembly.add(map_op[op] + " dword " + reg + ", " + des_z);
			}
			else if (registers.checkFarthestNextUse(y, line_nr, next_use_table)) {	//y has farthest next use
				assembly.add("mov dword [" + y + "], " + des_y);
				assembly.add(map_op[op] + " dword " + des_y + ", " + des_z);
				registers.address_descriptor[y] = { "type": "mem", "name": y };
				registers.address_descriptor[x] = { "type": "reg", "name": des_y };
				registers.register_descriptor[des_y] = x;
			}
			else {	//some other reg has farthest next use
				var reg = registers.getReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true);
				assembly.add("mov dword " + reg + ", " + des_y);
				assembly.add(map_op[op] + " dword " + reg + ", " + des_z);
			}
		}
		else if (math_ops_involved.indexOf(op) > -1) {
			// TODO
		}
	}
	else if (op == "if") {
		var cond = instr[2]

		var x = instr[3];
		var y = instr[4];

		var des_x = registers.address_descriptor[x]["name"];
		if (des_x == null) {
			registers.address_descriptor[x] = { "type": "mem", "name": x };
			des_x = registers.address_descriptor[x]["name"];
		}

		var des_y = "";
		if (variables.indexOf(y) != -1) {
			des_y = registers.address_descriptor[y]["name"];
		}

		if (des_y == null || des_x == null) {
			throw Error("Comparing Uninitialised Values");
		}

		if (registers.address_descriptor[x]["type"] == "reg") {    									// x is in a register
			if (variables.indexOf(y) == -1) {															// y is a constant
				des_y = y;
			}
			else {																						// y is a variable
				des_y = registers.loadVariable(y, line_nr, next_use_table, safe = [x], safe_regs = [], print = true);
			}
		}
		else {                             															// x is in memory
			if (variables.indexOf(y) == -1) {         													// y is a constant
				des_y = y;
			}
			else if (registers.address_descriptor[y]["type"] == "reg") {  								// y is in a register
				des_x = registers.loadVariable(x, line_nr, next_use_table, safe = [y], safe_regs = [], print = true);
			}
			else {																						// y is in memory
				if (next_use_table[line_nr][x][1] > next_use_table[line_nr][y][1]) {						// next use of x is after y
					des_y = registers.getReg(y, line_nr, next_use_table);
					assembly.add("mov dword " + des_y + ", [" + y + "]");

					des_x = registers.loadVariable(x, line_nr, next_use_table, safe = [y], safe_regs = [], print = true);
				}
				else {																						// next use of x is before y
					des_x = registers.getReg(x, line_nr, next_use_table);
					assembly.add("mov dword " + des_x + ", [" + x + "]");

					des_y = registers.loadVariable(y, line_nr, next_use_table, safe = [x], safe_regs = [], print = true);
				}
			}
		}

		assembly.add("cmp dword " + des_x + ", " + des_y);
		registers.unloadRegisters();
		assembly.add(map_op[cond] + " label_" + instr[5]);
	}
	else if (op == "jump") {
		registers.unloadRegisters();
		assembly.add("jmp label_" + instr[2]);
	}
	else if (op == "function") {
		assembly.shiftLeft();
		assembly.add("func_" + instr[2] + ":");
		assembly.shiftRight();
	}
	else if (op == "call") {
		registers.unloadRegisters();
		assembly.add("call func_" + instr[2]);
	}
	else if (op == "return") {
		assembly.add("ret");
	}
	else if (op == "print") {
		var rep_variable = registers.register_descriptor["eax"];
		// assembly.add(rep_variable);
		var variable = instr[2];

		if (rep_variable == variable) {
			registers.address_descriptor[variable] = { "type": "mem", "name": variable };
			var des_variable = registers.loadVariable(variable, line_nr, next_use_table, safe = [], safe_regs = ['eax'], print = false);
			assembly.add("mov dword " + des_variable + ", eax");
		}
		else {
			if (rep_variable != null) {																			// eax is not empty
				var des_rep_variable = registers.loadVariable(rep_variable, line_nr, next_use_table, safe = [], safe_regs = ['eax']);
				if (des_rep_variable == "[" + rep_variable + "]") {
					registers.address_descriptor[rep_variable] = { "type": "mem", "name": rep_variable };
				}
				assembly.add("mov dword " + des_rep_variable + ", eax");
			}

			var des_variable;
			if (registers.address_descriptor[variable]["type"] == "reg") {
				des_variable = registers.address_descriptor[variable]["name"];
			}
			else {
				des_variable = registers.loadVariable(variable, line_nr, next_use_table, safe = [], safe_regs = ['eax']);
				if (des_variable != "[" + variable + "]") {
					assembly.add("mov dword " + des_variable + ", [" + variable + "]");
				}
			}
			assembly.add("mov dword eax, " + des_variable);
		}

		registers.register_descriptor["eax"] = null;

		assembly.add("call syscall_print_int");
	}
	else if (op == "exit") {
		assembly.add("");
		assembly.add("mov eax, 1");
		assembly.add("int 0x80");
	}


	if (line_nr == 10) {
		console.log(registers.register_descriptor);
		console.log(registers.address_descriptor);
	}
}


module.exports = {
	codeGen: codeGen
}