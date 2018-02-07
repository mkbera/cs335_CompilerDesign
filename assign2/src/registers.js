class Registers {
	constructor() {
		this.register_descriptor = {
			"eax": null,
			"ebx": null,
			"ecx": null,
			"edx": null
		};
		this.address_descriptor = {
				// value is a hashmap of two elements: name(iden) and type("mem"/"reg")
		};
	}
	//Method
	getReg(inst, next_use_table, assembly) {
		
	}
}

var registers_list = ["eax", "ebx", "ecx", "edx"]

module.exports = {
	Registers: Registers,
	registers_list: registers_list
};