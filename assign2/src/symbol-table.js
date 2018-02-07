var Variable = require("./components").Variable;
var Function = require("./components").Function;

// class LocalSymbolTable {} ## When scope is to be instroduced

class SymbolTable {
	constructor() {
		this.components = {}
	}


	insert_variable(identifier, data_type, env_scope) {
		if (identifier in this.components) {
			return false;
		}

		self.components[identifier] = Variable(identifier, data_type, env_scope);
		return true;
	}

	insert_function(identifier, data_type, env_scope, argument_types = []) {
		if (identifier in this.components) {
			return false;
		}

		self.components[identifier] = Function(identifier, data_type, env_scope, argument_types);
		return true;
	}

	print() {
		console.log(this);
	}
}


module.exports = {
	SymbolTable: SymbolTable
};