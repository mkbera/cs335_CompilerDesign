function codeGen(instr, next_use_table, line_nr) {
	if (assembly.labels.indexOf(line_nr + 1) > -1) {
		registers.unloadRegisters(line_nr);

		assembly.shiftLeft();
		assembly.add("");
		assembly.add("label_" + (line_nr + 1) + ":");
		assembly.shiftRight();
	}

	var op = instr[1];

	if (op == "=") {
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

		if (x == y) {
			return;
		}

		if (des_y == null) {
			throw Error("Using Uninitialised Values");
		}

		if (registers.address_descriptor[x]["type"] == "reg") {    // x is in a register
			if (variables.indexOf(y) == -1) {						// y is a constant
				des_y = y;
			}
			else {																						// y is a variable
				des_y = registers.loadVariable(y, line_nr, next_use_table, safe = [x], safe_regs = [], print = true);
			}
			assembly.add("mov dword " + des_x + ", " + des_y);
		}
		else {                             				// x is in memory
			if (variables.indexOf(y) == -1) {        // y is a constant
				des_y = y;

				des_x = registers.loadVariable(x, line_nr, next_use_table, safe = [], safe_regs = [], print = false);
				assembly.add("mov dword " + des_x + ", " + des_y);
			}
			else if (registers.address_descriptor[y]["type"] == "reg") {  // y is in a register
				if (next_use_table[line_nr][y][1] == Infinity) {	// y has no next use
					registers.spillVariable(y, line_nr, print = true);

					registers.register_descriptor[des_y] = x;
					registers.address_descriptor[x] = { "type": "reg", "name": des_y };
				}
				else if ((reg = registers.getEmptyReg(x, line_nr, next_use_table, safe = [y], safe_regs = [], print = true)) != null) {	// empty reg exists
					des_x = reg;

					assembly.add("mov dword " + des_x + ", " + des_y);
				}
				else if ((reg = registers.getNoUseReg(x, line_nr, next_use_table, safe = [y], safe_regs = [], print = true)) != null) {	// reg has var with no next use
					des_x = reg;

					assembly.add("mov dword " + des_x + ", " + des_y);
				}
				else if (next_use_table[line_nr][x][1] <= next_use_table[line_nr][y][1] && registers.checkFarthestNextUse(y, line_nr, next_use_table)) {
					registers.spillVariable(y, line_nr, print = true);

					registers.register_descriptor[des_y] = x;
					registers.address_descriptor[x] = { "type": "reg", "name": des_y };

				}
				else if (registers.checkFarthestNextUse(x, line_nr, next_use_table)) {
					assembly.add("mov dword [" + x + "], " + des_x);
				}
				else {
					des_x = registers.getReg(x, line_nr, next_use_table, safe = [y], safe_regs = []);

					assembly.add("mov dword " + des_x + ", " + des_y);
				}
			}
			else {								// y is in memory
				if (next_use_table[line_nr][x][1] > next_use_table[line_nr][y][1]) {// next use of x is after y
					des_y = registers.getReg(y, line_nr, next_use_table, safe = [], safe_regs = []);
					assembly.add("mov dword " + des_y + ", [" + y + "]");

					des_x = registers.loadVariable(x, line_nr, next_use_table, safe = [y], safe_regs = [], print = true);
				}
				else {																						// next use of x is before y
					des_x = registers.getReg(x, line_nr, next_use_table, safe = [], safe_regs = []);
					assembly.add("mov dword " + des_x + ", [" + x + "]");

					des_y = registers.loadVariable(y, line_nr, next_use_table, safe = [x], safe_regs = [], print = true);
				}

				assembly.add("mov dword " + des_x + ", " + des_y);
			}
		}
	}
	else if (math_ops_binary.indexOf(op) > -1) {
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

		var z = instr[4];
		var des_z;

		if (des_y == null) {
			throw Error("Assigning Uninitialised Value");
		}
		if (registers.address_descriptor[y]["type"] == "mem") {
			des_y = registers.getReg(y, line_nr, next_use_table, safe = [x, z], safe_regs = []);
			assembly.add("mov dword " + des_y + ", [" + y + "]");
		}

		if (variables.indexOf(z) == -1) {	//z is constant
			des_z = z;
		}
		else {	// z not constant
			des_z = registers.loadVariable(z, line_nr, next_use_table, safe = [x, y], safe_regs = [], print = true);
		}

		des_x = registers.address_descriptor[x]["name"];

		if (x == z) {
			assembly.add(map_op[op] + " dword " + des_x + ", " + des_y);
		}
		else if (registers.address_descriptor[x]["type"] == "reg") {	//x is in register
			if (x != y) {
				assembly.add("mov dword " + des_x + ", " + des_y);
			}
			assembly.add(map_op[op] + " dword " + des_x + ", " + des_z);
		}
		else if (next_use_table[line_nr][y][1] == Infinity) {	//No next use of y
			registers.spillVariable(y, line_nr, print = true);

			registers.register_descriptor[des_y] = x;
			registers.address_descriptor[x] = { "type": "reg", "name": des_y };

			assembly.add(map_op[op] + " dword " + des_y + ", " + des_z);
		}
		else if ((reg = registers.getEmptyReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true)) != null) {	//got empty reg for x
			assembly.add("mov dword " + reg + ", " + des_y);
			assembly.add(map_op[op] + " dword " + reg + ", " + des_z);
		}
		else if ((reg = registers.getNoUseReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true)) != null) {	//got empty reg for x
			assembly.add("mov dword " + reg + ", " + des_y);
			assembly.add(map_op[op] + " dword " + reg + ", " + des_z);
		}
		else if (registers.checkFarthestNextUse(y, line_nr, next_use_table)) {	//y has farthest next use
			registers.spillVariable(y, line_nr, print = true);

			registers.address_descriptor[x] = { "type": "reg", "name": des_y };
			registers.register_descriptor[des_y] = x;

			assembly.add(map_op[op] + " dword " + des_y + ", " + des_z);
		}
		else {	//some other reg has farthest next use
			var reg = registers.getReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = []);
			assembly.add("mov dword " + reg + ", " + des_y);
			assembly.add(map_op[op] + " dword " + reg + ", " + des_z);
		}
	}
	else if (math_ops_unary.indexOf(op) > -1) {
		var x = instr[2];

		var des_x = registers.address_descriptor[x]["name"];
		if (des_x == null) {
			throw Error("Line " + (line_nr + 1) + ": Operation on Unitialize Variable");
		}

		des_x = registers.loadVariable(x, line_nr, next_use_table, safe = [], safe_regs = [], print = true);

		assembly.add(map_op[op] + " dword " + des_x);
	}
	else if (op == "*") {
		var x = instr[2];
		var y = instr[3];

		var des_x = registers.address_descriptor[x]["name"];
		if (des_x == null) {
			registers.address_descriptor[x] = { "type": "mem", "name": x };
			des_x = registers.address_descriptor[x]["name"];
		}

		var des_y = "";
		if (variables.indexOf(y) != -1) {	// y is not constant
			des_y = registers.address_descriptor[y]["name"];
		}

		var z = instr[4];
		var des_z;

		if (registers.address_descriptor[y]["type"] == "mem") {
			des_y = registers.getReg(y, line_nr, next_use_table, safe = [x, z], safe_regs = [], print = true);
			assembly.add("mov dword " + des_y + ", [" + y + "]");
		}

		des_x = registers.address_descriptor[x]["name"];

		if (variables.indexOf(z) == -1) {	// z is constant
			des_z = z;
			if (registers.address_descriptor[x]["type"] == "reg") {	// x in reg
				assembly.add("imul dword " + des_x + ", " + des_y + ", " + des_z);
			}
			else if (next_use_table[line_nr][y][1] == Infinity) {	//no next use y
				registers.spillVariable(y, line_nr, print = true);

				registers.address_descriptor[x] = { "type": "reg", "name": des_y };
				registers.register_descriptor[des_y] = x;

				assembly.add("imul dword " + des_y + ", " + des_y + ", " + des_z);
			}
			else if ((reg = registers.getEmptyReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true)) != null) {		//empty for x
				assembly.add("imul dword " + reg + ", " + des_y + ", " + des_z);
			}
			else if ((reg = registers.getNoUseReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true)) != null) {
				assembly.add("imul dword " + reg + ", " + des_y + ", " + des_z);
			}
			else {	// get reg for spilling
				reg = registers.getReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true);
				assembly.add("imul dword " + reg + ", " + des_y + ", " + des_z);
			}
		}
		else {	// z in reg or mem
			des_z = registers.loadVariable(z, line_nr, next_use_table, safe = [x, y], safe_regs = [], print = true);
			des_x = registers.address_descriptor[x]["name"];
			if (registers.address_descriptor[x]["type"] == "reg") {	// x in reg
				if (x == z) { // x and z are same
					assembly.add("imul dword " + des_x + ", " + des_y);
				}
				else { // x and z are not same
					if (x != y) {
						assembly.add("mov dword " + des_x + ", " + des_y);
					}
					assembly.add("imul dword " + des_x + ", " + des_z);
				}
			}
			else if (next_use_table[line_nr][y][1] == Infinity) { 	// y has no next use
				registers.spillVariable(y, line_nr, print = true);

				registers.address_descriptor[x] = { "type": "reg", "name": des_y };
				registers.register_descriptor[des_y] = x;

				assembly.add("imul dword " + des_y + ", " + des_z);
			}
			else if ((reg = registers.getEmptyReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true)) != null) {		//empty for x
				if (x != z) {
					assembly.add("mov dword " + reg + ", " + des_y);
					assembly.add("imul dword " + reg + ", " + des_z);
				}
				else {
					assembly.add("imul dword " + reg + ", " + des_y);
				}
			}
			else if ((reg = registers.getNoUseReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true)) != null) {
				if (x != z) {
					assembly.add("mov dword " + reg + ", " + des_y);
					assembly.add("imul dword " + reg + ", " + des_z);
				}
				else {
					assembly.add("imul dword " + reg + ", " + des_y);
				}
			}
			else if (registers.checkFarthestNextUse(y, line_nr, next_use_table, safe = [x, z])) {	// y has farthest next use
				registers.spillVariable(y, line_nr, print = true);

				registers.address_descriptor[x] = { "type": "reg", "name": des_y };
				registers.register_descriptor[des_y] = x;

				assembly.add("imul dword " + des_y + ", " + des_z);
			}
			else {	// spill some register
				var reg = registers.getReg(x, line_nr, next_use_table, safe = [y, z], safe_regs = [], print = true);
				if (x != z) {
					assembly.add("mov dword " + reg + ", " + des_y);
					assembly.add("imul dword " + reg + ", " + des_z);
				}
				else {
					assembly.add("imul dword " + reg + ", " + des_y);
				}
			}
		}
	}
	else if ((op == "/" || op == "%") && (instr[3] == instr[4])) {
		var x = instr[2];
		des_x = registers.loadVariable(x, line_nr, next_use_table, safe = [], safe_regs = [], print = true);
		assembly.add("mov dword " + des_x + ", 1");
	}
	else if (op == "/" || op == "%") {
		var x = instr[2];
		var y = instr[3];
		var z = instr[4];

		var des_x = registers.address_descriptor[x]["name"];
		if (des_x == null) {
			registers.address_descriptor[x] = { "type": "mem", "name": x };
			des_x = registers.address_descriptor[x]["name"];
		}

		var des_y = "";
		if (variables.indexOf(y) != -1) { // y is not constant
			des_y = registers.address_descriptor[y]["name"];
		}

		var rep_var = registers.register_descriptor["eax"];
		if (registers.address_descriptor[y]["type"] == "reg" && registers.address_descriptor[y]["name"] == "eax") {	// y in eax
			if (x != y) {
				assembly.add("mov dword [" + y + "], " + "eax");
				registers.address_descriptor[y] = { "type": "mem", "name": y };
			}
		}
		else {
			if (rep_var != null) {	//something in eax
				assembly.add("mov dword [" + rep_var + "], eax");
				registers.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
			}
			if (registers.address_descriptor[y]["type"] == "mem") {
				des_y = "[" + y + "]";
			}
			assembly.add("mov dword eax, " + des_y);
			if (x == y && registers.address_descriptor[x]["type"] == "reg") {
				registers.register_descriptor[registers.address_descriptor[x]["name"]] = null;
				registers.address_descriptor[x]["name"] = "eax";
			}
		}
		rep_var = registers.register_descriptor["edx"];
		if (rep_var != null) {	// make edx empty
			assembly.add("mov dword [" + rep_var + "], edx");
			registers.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
			registers.register_descriptor["edx"] = null;
		}
		assembly.add("mov dword edx, 0");

		//-----------------------------------------------------------------------------------

		var des_z = "";
		var rep_reg;
		var flag = false;
		if (variables.indexOf(z) > -1 && registers.address_descriptor[z]["type"] == "reg") {	// z in reg
			des_z = registers.address_descriptor[z]["name"];
		}
		else if (variables.indexOf(z) == -1) {	// z is constant
			var safe_regs = ["eax", "edx"];
			var safe = [];
			var rep_var;
			var rep_reg;
			var rep_use = 0;
			registers_list.some(function (register) {
				if (safe_regs.indexOf(register) == -1 && registers.register_descriptor[register] == null) {
					registers.register_descriptor[register] = null;
					flag = true;
					rep_reg = register;
					return true;
				}
			});
			if (flag == true) {
				assembly.add("mov dword " + rep_reg + ", " + z);
				des_z = rep_reg;
			}
			else {
				registers_list.some(function (register) {
					if (safe_regs.indexOf(register) == -1) {
						rep_var = registers.register_descriptor[register];
						if (safe.indexOf(rep_var) == -1 && next_use_table[line_nr][rep_var][1] == Infinity) {	//no next use empty it
							assembly.add("mov dword [" + rep_var + "], " + register);
							registers.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
							registers.register_descriptor[register] = null;
							flag = true;
							rep_reg = register;
							return true;
						}
					}
				});
				if (flag == true) {
					assembly.add("mov dword " + rep_reg + ", " + z);
					des_z = rep_reg;
				}
				else {
					registers_list.forEach(function (register) {
						if (safe_regs.indexOf(register) == -1) {
							var curr_var = registers.register_descriptor[register];
							if (safe.indexOf(curr_var) == -1 && next_use_table[line_nr][curr_var][1] > rep_use) {
								rep_reg = register;
								rep_var = curr_var;
								rep_use = next_use_table[line_nr][curr_var][1];
							}
						}
					});
					registers.register_descriptor[rep_reg] = null;
					assembly.add("mov dword [" + rep_var + "], " + rep_reg);
					registers.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
					assembly.add("mov dword " + rep_reg + ", " + z);
					des_z = rep_reg;
				}
			}
		}
		else if (registers.address_descriptor[z]["type"] == "mem") {	// z in mem
			des_z = registers.loadVariable(z, line_nr, next_use_table, safe = [], safe_regs = ["eax", "edx"], print = true);
		}

		assembly.add("idiv dword " + des_z);
		if (x == z && registers.address_descriptor[z]["type"] == "reg" && registers.address_descriptor[z]["name"] != "eax") {
			reg = registers.address_descriptor[z]["name"];
			registers.register_descriptor[reg] = null;
		}
		if (op == "/") {
			registers.register_descriptor["eax"] = x;
			registers.register_descriptor["edx"] = null;
			registers.address_descriptor[x] = { "type": "reg", "name": "eax" };
		}
		else {	// op is %
			registers.register_descriptor["eax"] = null;
			registers.register_descriptor["edx"] = x;
			registers.address_descriptor[x] = { "type": "reg", "name": "edx" };
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

				des_x = registers.loadVariable(x, line_nr, next_use_table, safe = [], safe_regs = [], print = true);
			}
			else if (registers.address_descriptor[y]["type"] == "reg") {  								// y is in a register
				des_x = registers.loadVariable(x, line_nr, next_use_table, safe = [y], safe_regs = [], print = true);
			}
			else {																						// y is in memory
				des_x = registers.getReg(x, line_nr, next_use_table, safe = [], safe_regs = []);
				assembly.add("mov dword " + des_x + ", [" + x + "]");

				des_y = registers.loadVariable(y, line_nr, next_use_table, safe = [x], safe_regs = [], print = true);
			}
		}

		assembly.add("cmp dword " + des_x + ", " + des_y);
		registers.unloadRegisters(line_nr);
		assembly.add(map_op[cond] + " label_" + instr[5]);
	}
	else if (op == "jump") {
		registers.unloadRegisters(line_nr);
		assembly.add("jmp label_" + instr[2]);
	}
	else if (op == "function") {
		assembly.shiftLeft();
		assembly.add("func_" + instr[2] + ":");
		assembly.shiftRight();
	}
	else if (op == "call") {
		registers.unloadRegisters(line_nr);
		assembly.add("call func_" + instr[2]);
	}
	else if (op == "return") {
		assembly.add("ret");
	}
	else if (op == "print") {
		assembly.add("");
		var rep_variable = registers.register_descriptor["eax"];
		var variable = instr[2];

		if (rep_variable == variable) {
			registers.address_descriptor[variable] = { "type": "mem", "name": variable };

			var des_variable = "[" + variable + "]";
			if (next_use_table[line_nr][variable][1] != Infinity) {
				des_variable = registers.loadVariable(variable, line_nr, next_use_table, safe = [], safe_regs = ["eax"], print = false);
			}

			assembly.add("mov dword " + des_variable + ", eax");
			registers.register_descriptor["eax"] = null;
		}
		else {
			if (rep_variable != null) {																			// eax is not empty
				var des_rep_variable = registers.loadVariable(rep_variable, line_nr, next_use_table, safe = [], safe_regs = ["eax"]);
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
				des_variable = registers.loadVariable(variable, line_nr, next_use_table, safe = [], safe_regs = ["eax"]);
				if (des_variable != "[" + variable + "]") {
					assembly.add("mov dword " + des_variable + ", [" + variable + "]");
				}
			}
			assembly.add("mov dword eax, " + des_variable);
		}

		registers.register_descriptor["eax"] = null;

		assembly.add("call syscall_print_int");
		assembly.add("");
	}
	else if (op == "=arr") {	// z = a[10]
		var z = instr[2];
		var arr = instr[3];
		var y = instr[4];
		var des_z = "";
		var des_y = "";

		if (registers.address_descriptor[z]["type"] == null) {	// z = a[10]; z declared for first time
			registers.address_descriptor[z] = { "type": "mem", "name": "z" };
		}

		if (registers.address_descriptor[z]["type"] == "mem") {	// z in mem
			des_z = registers.getReg(z, line_nr, next_use_table, safe = [y], safe_regs = [], print = true);
		}
		else if (registers.address_descriptor[z]["type"] == "reg") {	// z in reg
			des_z = registers.address_descriptor[z]["name"];
		}
		if (variables.indexOf(y) == -1) {	// y is constant
			assembly.add("mov dword " + des_z + ", [" + arr + " + " + y + "]");
		}
		else {	//	y not constant
			des_y = registers.address_descriptor[y]["name"];
			if (registers.address_descriptor[y]["type"] == "mem") {
				des_y = registers.getReg(y, line_nr, next_use_table, safe = [z], safe_regs = [], print = true);
				assembly.add("mov dword " + des_y + ", [" + y + "]");
			}
			assembly.add("mov dword " + des_z + ", [" + arr + " + " + des_y + "]");
		}
	}
	else if (op == "arr=") {	// a[10] = z
		var arr = instr[2];
		var y = instr[3];
		var z = instr[4];
		var des_y = "";
		var des_z = "";
		if (variables.indexOf(y) == -1) { // y is constant
			des_y = y;
		}
		else if (registers.address_descriptor[y]["type"] == "mem") {
			des_y = registers.getReg(y, line_nr, next_use_table, safe = [z], safe_regs = [], print = true);
			assembly.add("mov dword " + des_y + ", [" + y + "]");
		}
		else {
			des_y = registers.address_descriptor[y]["name"];
		}

		if (variables.indexOf(z) == -1) { // y is constant
			des_z = z;
		}
		else if (registers.address_descriptor[z]["type"] == "mem") {
			des_z = registers.getReg(z, line_nr, next_use_table, safe = [y], safe_regs = [], print = true);
			assembly.add("mov dword " + des_z + ", [" + z + "]");
		}
		else {
			des_z = registers.address_descriptor[z]["name"];
		}
		assembly.add("mov dword [" + arr + " + " + des_y + "], " + des_z);
	}
	else if (op == "scan") {
		var x = instr[2];
		var des_x = "";
		assembly.add("");
		assembly.add("push eax");
		assembly.add("push ebx");
		assembly.add("push ecx");
		assembly.add("push edx");
		assembly.add("push esi")
		assembly.add("push edi")
		assembly.add("push ebp");
		assembly.add("mov ebp, esp");
		assembly.add("push " + x);
		assembly.add("push _int_scan");
		assembly.add("call scanf");
		assembly.add("mov esp, ebp");
		assembly.add("pop ebp");
		assembly.add("pop edi")
		assembly.add("pop esi")
		assembly.add("pop edx");
		assembly.add("pop ecx");
		assembly.add("pop ebx");
		assembly.add("pop eax");
		if (registers.address_descriptor[x]["type"] == "reg") {
			des_x = registers.address_descriptor[x]["name"];
			assembly.add("mov dword " + des_x + ", [" + x + "]");
		}
		assembly.add("");
	}
	else if (op == "exit") {
		registers.unloadRegisters(line_nr);

		assembly.add("");
		assembly.add("mov eax, 1");
		assembly.add("int 0x80");
	}
}


module.exports = {
	codeGen: codeGen
}