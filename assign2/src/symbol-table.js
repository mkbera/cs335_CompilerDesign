class SymbolTable {
	constructor(identifier, type = "int", return_type = null) {
		this.parameters = {
			"type": type,
			"return_type": return_type
		};
		this.identifier = identifier;
	}
}

variable_ops = ["+", "-", "/", "*", "=", "%", "^", "|"]
function_ops = ["function"]
keywords = ["if", "return", "function", "call", "block", "jump", "leq", "geq", "lt", "gt", "eq", "neq", "print"]


module.exports = {
	SymbolTable: SymbolTable,
	variable_ops: variable_ops,
	function_ops: function_ops,
	keywords: keywords
};