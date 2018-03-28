global.base_table = null


class Type {
    constructor(type, category, width, length) {
        this.type = type
        this.category = category

        this.width = width
        this.length = length
    }

    get_type() {
        switch (this.category) {
            case "basic": {
                return this.type
            }
            case "array": {
                return "Array :: { " + this.type.get_type() + ", length: " + this.length + " }"
            }
            case "object": {
                return "Object :: { " + this.type.name + " }"
            }
        }
    }
}


class ScopeTable {
    constructor(class_instance, parent) {
        this.class = class_instance
        this.variables = {}

        this.parent = parent
        this.children = []
    }

    add_variable(name, type) {
        if (name in this.variables) {
            throw Error("The variable " + name + " has already been defined!")
        }

        var variable = new Variable(name, type)
        this.variables[name] = variable;
    }

    add_temporary(var_type, identifier) {
        // TODO
    }

    lookup_variable(variable_name) {
        if (variable_name in this.variables) {
            return this.variables[identifier]
        }
        else if (this.parent != null) {
            return this.parent.lookup_variable()
        }
        else {
            throw Error("The variable " + variable_name + " was not declared in the current scope!")
        }
    }

    lookup_method(method_name) {
        this.class.lookup_method(method_name)
    }
}


class Variable {
    constructor(name, type) {
        this.category = "variable"

        this.name = name
        this.type = type
    }
}


class Method {
    constructor(name, return_type, argument, scope_table, main = false) {
        this.main = main
        this.type = "method"

        this.name = name
        this.arguments = arguments
        this.return_type = return_type
        this.scope_table = scope_table

        this.arguments.forEach(function (argument) {
            this.scope_table.add_variable(argument);
        })
    }
}


class Class {
    constructor(name, parent = null) {
        this.name = name

        this.methods = {}
        this.variables = {}

        this.parent = parent
    }

    add_method(name, return_type, argument, scope_table, main = false) {
        if (name in this.variables) {
            throw Error("The method " + name + " has already been defined!")
        }

        var method = new Method(name, return_type, argument, scope_table, main)
        this.methods[name] = method;
    }

    add_variable(name, type) {
        if (name in this.variables) {
            throw Error("The variable " + name + " has already been defined!")
        }

        var variable = new Variable(name, type)
        this.variables[name] = variable;
    }

    lookup_variable(variable_name) {
        if (variable_name in this.variables) {
            return this.variables[identifier]
        }
        else if (this.parent != null) {
            return this.parent.lookup_variable()
        }
        else {
            throw Error("The variable " + variable_name + " was not declared in the current scope!")
        }
    }

    lookup_method(method_name) {
        if (method_name in this.methods) {
            return this.methods[method_name]
        }
        else if (this.parent != null) {
            return this.parent.lookup_method(method_name)
        }
        else {
            throw Error("The method " + method_name + " was not declared in the current scope!")
        }
    }
}


class SymbolTable {
    constructor() {
        this.temp_count = 0

        this.classes = {}

        this.current_class = null
        this.current_scope = null
    }

    add_class(name, parent = null) {
        if (name in this.classes) {
            throw Error("The class " + name + " has already been declared!")
        }

        var class_instance = new Class(name, parent)
        this.classes[name] = class_instance

        this.current_class = class_instance
        this.current_scope = class_instance
    }

    add_method(name, return_type, argument, scope_table, main = false) {
        this.current_class.add_method(name, return_type, argument, scope_table, main = false)
    }

    add_variable(variable) {
        this.current_scope.add_variable(name, type)
    }

    add_temporary(temp_type, table) {
        // TODO
        success = False
        while (success > 0) {
            name = "t" + str(this.temp_count)
            this.temp_count += 1
            success = table.insert_temp(temp_type, name)
        }
        return name
    }

    scope_start() {
        var table = new ScopeTable(this.current_class, this.current_class)

        this.current_scope.children.push(table)
        this.current_class = table

        return table
    }

    scope_end() {
        this.current_scope = this.current_scope.parent
    }

}

module.exports = {
    SymbolTable: SymbolTable,
    Table: Table,
    Type: Type
}