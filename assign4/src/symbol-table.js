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

        return variable;
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

    print(indent) {
        var spaces = " ".repeat(indent)

        for (var variable_name in this.variables) {
            if (!this.variables[variable_name].isparam) {
                console.log(spaces + this.variables[variable_name].name + ": " + this.variables[variable_name].type.get_type())
            }
        }

        console.log("")

        for (var child in this.children) {
            child.print();
        }
    }
}


class Variable {
    constructor(name, type, isparam = false) {
        this.category = "variable"

        this.name = name
        this.type = type

        this.isparam = isparam
    }
}


class Method {
    constructor(name, return_type, parameters, scope_table, main = false) {
        this.main = main
        this.type = "method"

        this.name = name
        this.parameters = parameters
        this.return_type = return_type
        this.table = scope_table

        this.parameters.forEach(function (parameter) {
            parameter.isparam = true
            scope_table.variables[parameter.name] = parameter;
        })
    }

    print(indent) {
        var spaces = " ".repeat(indent + 4)

        var parameters = ""
        for (var parameter in this.parameters) {
            parameters += this.parameters[parameter].name + " :: " + this.parameters[parameter].type.get_type() + ", "
        }
        console.log(" ".repeat(indent) + "Method: " + this.name + " ( " + parameters.substr(0, parameters.length - 2) + " )")
        this.table.print(indent + 4)
        console.log("")
    }
}


class Class {
    constructor(name, parent = null) {
        this.name = name

        this.methods = {}
        this.variables = {}

        this.parent = parent
    }

    add_method(name, return_type, parameters, scope_table, main = false) {
        if (name in this.variables) {
            throw Error("The method " + name + " has already been defined!")
        }

        var method = new Method(name, return_type, parameters, scope_table, main)
        this.methods[name] = method;

        return method
    }

    add_variable(name, type) {
        if (name in this.variables) {
            throw Error("The variable " + name + " has already been defined!")
        }

        var variable = new Variable(name, type)
        this.variables[name] = variable;

        return variable
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

    print(indent) {
        var spaces = " ".repeat(indent + 4)

        console.log(" ".repeat(indent) + "Class: " + this.name)
        for (var variable_name in this.variables) {
            console.log(spaces + variable_name + " :: " + this.variables[variable_name].type.get_type())
        }

        console.log("")
        for (var method_name in this.methods) {
            this.methods[method_name].print(indent = 4)
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

    get_class(name) {
        if (!(name in this.classes)) {
            throw Error("The class " + name + " has not been declared in the current scope!")
        }

        return this.classes[name]
    }

    add_class(name, parent_name = null) {
        if (name in this.classes) {
            throw Error("The class " + name + " has already been declared!")
        }

        var parent = null
        if (parent_name != "") {
            if (!(parent_name in this.classes)) {
                throw Error("The class " + parent_name + " has not been declared in the current scope!")
            }

            parent = this.classes[parent_name];
        }

        var class_instance = new Class(name, parent)
        this.classes[name] = class_instance

        this.current_class = class_instance
        this.current_scope = class_instance

        return class_instance
    }

    add_method(name, return_type, parameters, scope_table, main = false) {
        return this.current_class.add_method(name, return_type, parameters, scope_table, main = false)
    }

    add_variable(name, type) {
        return this.current_scope.add_variable(name, type)
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

    print() {
        for (var class_name in this.classes) {
            console.log("-".repeat(30))
            this.classes[class_name].print(0)
        }
    }

}

module.exports = {
    SymbolTable: SymbolTable,
    ScopeTable: ScopeTable,
    Variable: Variable,
    Method: Method,
    Class: Class,
    Type: Type
}