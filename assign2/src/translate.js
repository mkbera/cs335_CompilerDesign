function codeGen(instr, next_use_table, inst_num) {
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
			if (next_use_table[inst_num][x][1] != Infinity) {
				des_x = getReg(x, inst_num, next_use_table, safe = [y]);
			}

			if (registers.address_descriptor[x]["type"] == "reg") {    //x is in reg   
				if (des_y == null) {
					throw Error("Assigning Uninitialised Value");
				}
				if (variables.indexOf(y) == -1) {
					des_y = y;
				} else if (registers.address_descriptor[y]["type"] == "mem") {  //the operand y is in memory
					// Decide whether to load y or not
					des_y = "[" + des_y + "]";
				}
				assembly.add("\tmov dword " + des_x + ", " + des_y);
			}
			else {                               //x is in memory
				if (variables.indexOf(y) == -1) {         // y is constant
					des_y = y;
					assembly.add("TEST");
					assembly.add("\tmov dword [" + des_x + "], " + des_y);
				} else if (registers.address_descriptor[y]["type"] == "reg") {  //the operand y is in register
					assembly.add("\tmov dword [" + des_x + "], " + des_y);
				} else {
					if (next_use_table[inst_num][instr[2]][1] > next_use_table[inst_num][instr[3]][1]) {    //y next use earlier than x
						des_y = getReg(y, inst_num, next_use_table);
						assembly.add("\tmov dword " + des_y + ", [" + y + "]");
						assembly.add("\tmov dword [" + des_x + "], " + des_y);
					} else {
						// registers.address_descriptor[y] = { "type": "mem", "name": y };
						des_x = getReg(x, inst_num, next_use_table);
						assembly.add("\tmov dword " + des_x + ", [" + des_y + "]");
					}
				}
			}
		} else if (math_ops_1.indexOf(op) > -1) {
			var z = instr[4];
			var des_z;

			if (des_y == null) {
				throw Error("Assigning Uninitialised Value");
			}
			if (registers.address_descriptor[y]["type"] == "mem") {
				des_y = getReg(y, inst_num, next_use_table, [x, z]);
				assembly.add("\tmov dword " + des_y + ", [" + y + "]");
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

			// if (variables.indexOf(z) == -1) {		//z is constant
			// des_z = z;

			des_x = registers.address_descriptor[x]["name"];

			if (registers.address_descriptor[x]["type"] == "reg") {	//x is in register
				if (des_x != des_y) {
					assembly.add("\tmov dword " + des_x + ", " + des_y);
				}
				assembly.add("\t" + map_op[op] + " dword " + des_x + ", " + des_z);
			}
			else if (next_use_table[inst_num][y][1] == Infinity) {	//No next use of y
				assembly.add("\tmov dword [" + y + "], " + des_y);
				assembly.add("\t" + map_op[op] + " dword " + des_y + ", " + des_z);
				registers.address_descriptor[y] = { "type": "mem", "name": y };
				registers.address_descriptor[x] = { "type": "reg", "name": des_y };
				registers.register_descriptor[des_y] = x;
			}
			else if ((reg = getRegEmpty(variable, inst_num, next_use_table, [y, z])) != null) {	//got empty reg for x
				assembly.add("\tmov dword " + reg + ", " + des_y);
				assembly.add("\t" + map_op[op] + " dword " + reg + ", " + des_z);
			}
			// else if (farthest_nextuse(x, inst_num, next_use_table)) {	//x has no or farthest next use
			// 	assembly.add("\tmov dword [" + x + "] " + des_y);
			// 	assembly.add(map_op[op] + " [" + x + "], " + des_z);
			// }
			else if (farthest_nextuse(y, inst_num, next_use_table)) {	//y has farthest next use
				assembly.add("\tmov dword [" + y + "], " + des_y);
				assembly.add("\t" + map_op[op] + " dword " + des_y + ", " + des_z);
				registers.address_descriptor[y] = { "type": "mem", "name": y };
				registers.address_descriptor[x] = { "type": "reg", "name": des_y };
				registers.register_descriptor[des_y] = x;
			}
			else {	//some other reg has farthest next use
				var reg = getReg(x, inst_num, next_use_table, [y, z]);
				assembly.add("\tmov dword " + reg + ", " + des_y);
				assembly.add("\t" + map_op[op] + " dword " + reg + ", " + des_z);
			}
			// }
		}
	}
}


module.exports = {
	codeGen: codeGen
}