global.registers_list = ["eax", "ebx", "edx", "ecx"];


class Registers {
	constructor() {
		this.register_descriptor = {};
		for (var i = 0; i < registers_list.length; i++) {
			this.register_descriptor[registers_list[i]] = null;
		}

		this.address_descriptor = {
			// value is a hashmap of two elements: name(iden) and type("mem"/"reg")
		};
	}


	getEmptyReg(variable, line_nr, next_use_table, safe = [], safe_regs = []) {
		var self = this;
		
		var flag = false;
		var rep_var;
		var rep_reg;

		registers_list.some(function (register) {
			if (safe_regs.indexOf(register) == -1 && self.register_descriptor[register] == null) {
				self.register_descriptor[register] = variable;
				self.address_descriptor[variable] = { "type": "reg", "name": register };
				flag = true;
				rep_reg = register;
				return true;
			}
		});

		return (flag) ? rep_reg : null;
	}


	getNoUseReg(variable, line_nr, next_use_table, safe = [], safe_regs = []) {
		var self = this;

		var flag = false;
		var rep_var;
		var rep_reg;

		registers_list.some(function (register) {
			if (safe_regs.indexOf(register) == -1) {
				rep_var = self.register_descriptor[register];
				if (safe.indexOf(rep_var) == -1 && next_use_table[line_nr][rep_var][1] == Infinity) {	//no next use empty it
					assembly.add("mov dword [" + rep_var + "], " + register);
					self.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
					self.address_descriptor[variable] = { "type": "reg", "name": register };
					self.register_descriptor[register] = variable;
					flag = true;
					rep_reg = register;
					return true;
				}
			}
		});

		return (flag) ? rep_reg : null;
	}


	getReg(variable, line_nr, next_use_table, safe = [], safe_regs = []) {
		var self = this;
		//TODO : imul x y z, y not in reg, y 2nd last next use after x.
		var rep_reg;
		var rep_var;
		var rep_use = 0;

		var flag = false;

		rep_reg = self.getEmptyReg(variable, line_nr, next_use_table, safe);
		if (rep_reg != null) {
			return rep_reg;
		}
		rep_reg = self.getNoUseReg(variable, line_nr, next_use_table, safe);
		if (rep_reg != null) {
			return rep_reg;
		}

		registers_list.forEach(function (register) {
			if (safe_regs.indexOf(register) == -1) {
				var curr_var = self.register_descriptor[register];
				if (safe.indexOf(curr_var) == -1 && next_use_table[line_nr][curr_var][1] > rep_use) {
					rep_reg = register;
					rep_var = curr_var;
					rep_use = next_use_table[line_nr][curr_var][1];
				}
			}
		});

		console.log("pppppppppppppppppppppppppp");
		// If()
		self.register_descriptor[rep_reg] = variable;
		self.address_descriptor[variable] = { "type": "reg", "name": rep_reg };

		assembly.add("mov dword [" + rep_var + "], " + rep_reg);
		self.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
		return rep_reg;
	}


	checkFarthestNextUse(variable, line_nr, next_use_table, safe = []) {
		var flag = true
		variables.some(function (check_var) {
			if (safe.indexOf(check_var) == -1 && next_use_table[line_nr][variable][2] < next_use_table[line_nr][check_var][2]) {
				flag = false;
				return true;
			}
		})

		return flag;
	}


	unloadRegisters() {
		var self = this;
		registers_list.forEach(function (register) {
			var variable = self.register_descriptor[register];
			if (variable != null) {
				assembly.add("mov dword [" + variable + "], " + register);
				self.register_descriptor[register] = null;
				self.address_descriptor[variable] = { "type": "mem", "name": variable };
			}
		});
	}

	loadVariable(variable, line_nr, next_use_table, safe = [], safe_regs = [], print = true) {
		var self = this;

		var des_variable = self.address_descriptor[variable]["name"];
		if (des_variable == null) {
			self.address_descriptor[variable] = { "type": "mem", "name": variable };
			des_variable = variable;
		}

		if (self.address_descriptor[variable]["type"] == "reg" && safe_regs.indexOf(self.address_descriptor[variable]["name"]) == -1) {
			return des_variable;
		}
		else {
			des_variable = variable;
		}

		var reg;
		if (next_use_table[line_nr][variable][1] == Infinity) {			// variable has no next use
			des_variable = "[" + des_variable + "]";
		}
		else if (self.checkFarthestNextUse(variable, line_nr, next_use_table)) {	// variable has farthest use
			if ((reg = self.getEmptyReg(variable, line_nr, next_use_table, safe, safe_regs)) != null) {	// there is an empy register
				des_variable = reg;
				if (print) assembly.add("mov dword " + des_variable + ", [" + variable + "]");
			}
			else if ((reg = self.getNoUseReg(variable, line_nr, next_use_table, safe, safe_regs)) != null) {				// there is a no use register
				des_variable = reg;
				if (print) assembly.add("mov dword " + des_variable + ", [" + variable + "]");
			}
			else {
				des_variable = "[" + des_variable + "]";
			}
		}
		else {																						// variable has some use
			des_variable = self.getReg(variable, line_nr, next_use_table, safe, safe_regs);
			if (print) assembly.add("mov dword " + des_variable + ", [" + variable + "]");
		}

		return des_variable;
	}
}


module.exports = {
	Registers: Registers,
	registers_list: registers_list
};