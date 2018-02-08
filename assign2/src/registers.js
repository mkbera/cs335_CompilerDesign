var registers_list = ["eax", "ebx", "ecx", "edx", "esi", "edi"]


function getRegEmpty(variable, inst_num, next_use_table, safe = []) {	//returns a register only if empty
	var flag = false;
	var rep_var;
	registers_list.some(function (reg) {
		//--------There is an empty register----------
		if (registers.register_descriptor[reg] == null) {
			registers.register_descriptor[reg] = variable;
			registers.address_descriptor[variable] = { "type": "reg", "name": reg };
			flag = true;
			rep_reg = reg;
			return true;
		}
	});
	if (!flag) {
		registers_list.some(function (reg) {
			rep_var = registers.register_descriptor[reg];
			if (safe.indexOf(rep_var) == -1 && next_use_table[inst_num][rep_var][1] == Infinity) {	//no next use empty it
				assembly.add("\tmov dword [" + rep_var + "], " + reg);
				registers.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
				registers.address_descriptor[variable] = { "type": "reg", "name": reg };
				registers.register_descriptor[reg] = variable;
				flag = true;
				rep_reg = reg;
				return true;
			}
		});
	}
	if (flag) {
		return rep_reg;
	} else {
		return null;
	}
}


function getReg(variable, inst_num, next_use_table, safe = []) {
	var rep_reg;
	var rep_var;
	var rep_use;
	var flag = 0;
	rep_reg = getRegEmpty(variable, inst_num, next_use_table, safe);
	if (rep_reg != null) {
		return rep_reg;
	}
	registers_list.forEach(function (reg) {
		//---------Replace with farthest next use-------
		var curr_var = registers.register_descriptor[reg];
		if (safe.indexOf(curr_var) == -1 && next_use_table[inst_num][curr_var][1] > rep_use) {
			rep_reg = reg;
			rep_var = curr_var;
			rep_use = next_use_table[inst_num][curr_var][1];
		}
	})
	registers.register_descriptor[rep_reg] = variable;
	registers.address_descriptor[variable] = { "type": "reg", "name": rep_reg };

	assembly.add("\tmov dword [" + rep_var + "], " + rep_reg);
	registers.address_descriptor[rep_var] = { "type": "mem", "name": rep_var };
	return rep_reg;
}


function farthest_nextuse(variable, inst_num, next_use_table) {
	var flag = 1
	variables.some(function (new_var) {
		if (next_use_table[inst_num][variable][2] < next_use_table[inst_num][new_var][2]) {
			flag = 0;
			return true;
		}
	})
	if (flag == 1) {
		return true;
	} else {
		return false;
	}
}


function unloadRegisters() {
	registers_list.forEach(function (register) {
		var variable = registers.register_descriptor[register];
		if (variable != null) {
			assembly.add("\tmov dword [" + variable + "], " + register);
			registers.register_descriptor[register] = null;
			registers.address_descriptor[variable] = { "type": "mem", "name": variable };
		}
	});
}


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
	//Method
	getReg(inst, next_use_table, assembly) {

	}
}


module.exports = {
	Registers: Registers,
	registers_list: registers_list,
	getReg: getReg,
	getRegEmpty: getRegEmpty,
	farthest_nextuse: farthest_nextuse,
	unloadRegisters: unloadRegisters
};