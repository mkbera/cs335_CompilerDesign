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
		this.shiftLeft();
		this.add("");
		this.add("syscall_print_int:");
		this.shiftRight();
		this.add("push ebx");
		this.add("push ecx");
		this.add("push edx");
		this.add("push esi")
		this.add("push edi")
		this.add("push ebp");
		this.add("mov ebp, esp");
		this.add("push eax");
		this.add("push _int");
		this.add("call printf");
		this.add("mov eax, 0");
		this.add("mov esp, ebp");
		this.add("pop ebp");
		this.add("pop edi")
		this.add("pop esi")
		this.add("pop edx");
		this.add("pop ecx");
		this.add("pop ebx")
		this.add("ret");
	}


	print(file = "") {
		this.assembly = this.assembly.replace(/\:\s*\n\s*\n/g, ":\n");
		console.log(this.assembly);
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