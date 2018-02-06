class Registers {
	constructor() {
		this.register_descriptor = {
			"eax": null,
			"ebx": null,
			"ecx": null,
			"edx": null
		};
		this.address_descriptor = {

		};
	}
	//Method
	getReg(variable, inst) {

	}
}

var registers_list = ["eax", "ebx", "ecx", "edx"]

module.exports = {
	Registers: Registers,
	registers_list: registers_list
};