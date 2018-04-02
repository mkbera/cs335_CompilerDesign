function codegen_methods(instr, next_use_table, line_nr) {
	if (assembly.labels.indexOf(line_nr + 1) > -1) {
		if (line_nr > 0) {
			registers.unloadRegisters(line_nr - 1);
		}

		assembly.shiftLeft();
		assembly.add("");
		assembly.add("label_" + (line_nr + 1) + ":");
		assembly.shiftRight();
	}

	var op = instr[1];
	if (op == '='){
		
	}

}

module.exports = {
	codeGen_methods: codeGen_methods
}