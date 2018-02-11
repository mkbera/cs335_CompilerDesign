var Variable = require("./components").Variable;
var Function = require("./components").Function;
var Array = require("./components").Array;

// class LocalSymbolTable {} ## When scope is to be introduced

class SymbolTable {
	constructor() {
		this.components = {}
	}


	insert_variable(identifier, data_type, env_scope) {
		if (identifier in this.components) {
			return false;
		}

		this.components[identifier] = new Variable(identifier, data_type, env_scope);
		return true;
	}

	insert_function(identifier, data_type, env_scope, argument_types = []) {
		if (identifier in this.components) {
			return false;
		}

		this.components[identifier] = new Function(identifier, data_type, env_scope, argument_types);
		return true;
	}

	insert_array(identifier, data_type, env_scope, size) {
		if (identifier in this.components) {
			return false;
		}

		this.components[identifier] = new Array(identifier, data_type, env_scope, size);
		return true;
	}

	print() {
		console.log(this);
	}
}


module.exports = {
	SymbolTable: SymbolTable
};