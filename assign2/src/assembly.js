class Assembly {
	constructor() {
		this.assembly = "";
		this.indent = 0;
	}


	add(line) {
		for (var i = 0; i < this.indent; i++) {
			this.assembly += "\t";
		}
		this.assembly += line + "\n";
	}


	shiftRight() {
		this.indent += 1;
	}

	shiftLeft() {
		this.indent -= 1;
		if (this.indent < 0) {
			this.indent = 0;
		}
	}


	setLabels(labels) {
		this.labels = labels;
	}


	addModules() {
		// PRINT INT
		assembly.shiftLeft();
		assembly.add("");
		assembly.add("syscall_print_int:");
		assembly.shiftRight();

		assembly.add("push ebx");
		assembly.add("push ecx");
		assembly.add("push edx");
		assembly.add("push esi")
		assembly.add("push edi")
		assembly.add("push ebp");
		assembly.add("mov ebp, esp");
		assembly.add("push eax");
		assembly.add("push _int");
		assembly.add("call printf");
		assembly.add("mov eax, 0");
		assembly.add("mov esp, ebp");
		assembly.add("pop ebp");
		assembly.add("pop edi")
		assembly.add("pop esi")
		assembly.add("pop edx");
		assembly.add("pop ecx");
		assembly.add("pop ebx")		
		assembly.add("ret");
	}


	print(file = "") {
		this.assembly = this.assembly.replace(/\:\s*\n\s*\n/g, ":\n");
		// console.log(this.assembly);
		if (file != "") {
			var fs = require("fs");
			fs.writeFile(file, assembly.assembly, (err) => {
				if (err) throw err;

				console.log("Saved to " + file);
			});
		}
	}
}


module.exports = {
	Assembly: Assembly
}