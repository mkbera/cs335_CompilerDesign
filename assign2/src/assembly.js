class Assembly {
	constructor() {
		this.assembly = "";
	}

	add(line) {
		this.assembly += line + "\n";
	}

	print() {
		console.log(this.assembly);
	}
}


module.exports = {
	Assembly: Assembly
}