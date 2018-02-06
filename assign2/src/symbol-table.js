class SymbolTable {
	constructor(identifier, type = "int", return_type = null) {
		this.parameters = {
			"type": type,
			"return_type": return_type
		};
		this.identifier = identifier;
	}
}


module.exports = {
	SymbolTable: SymbolTable
};