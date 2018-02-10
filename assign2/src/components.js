class Variable {
	constructor(identifier, data_type, env_scope) {
		this.identifier = identifier;
		this.data_type = data_type;
		this.env_scope = env_scope;
		this.category = "variable";
	}
}


class Function {
	constructor(identifier, data_type, env_scope, argument_types) {
		this.identifier = identifier;
		this.data_type = data_type;
		this.env_scope = env_scope;
		this.argument_types = argument_types;
		this.category = "function";
	}
}

class Array {
	
}


module.exports = {
	Variable: Variable,
	Function: Function
};