global.base_table = null


class Type {
    constructor(type, category, width, length, dimension = 0) {
        this.type = type
        this.category = category

        this.width = width
        this.length = length
        this.dimension = dimension
    }

    get_type() {
        switch (this.category) {
            case "basic": {
                return this.type
            }
            case "array": {
                return "Array :: { " + this.type.get_type() + ", length: " + this.length + ", width: " + this.width + ", dimension: " + this.dimension + " }"
            }
            case "object": {
                return "Object :: { " + this.type.name + " }"
            }
        }
    }
}


class ScopeTable {
    constructor(class_instance, parent, category) {
        this.class = class_instance
        this.variables = {}

        this.parent = parent
        this.children = []

        this.category = category
        this.label_start = this.class.create_label()
        this.label_end = this.class.create_label()

        this.return_type = null
    }

    add_variable(name, type) {
        if (name in this.variables) {
            throw Error("The variable " + name + " has already been defined!")
        }

        var variable = new Variable(name, type)
        this.variables[name] = variable;

        return variable;
    }

    lookup_variable(variable_name, error) {
        if (variable_name in this.variables) {
            return this.variables[variable_name]
        }
        else if (this.parent != null) {
            return this.parent.lookup_variable(variable_name, error)
        }
        else {
            if (error) {
                throw Error("The variable " + variable_name + " was not declared in the current scope!")
            }
        }
    }

    lookup_method(method_name, error) {
        return this.class.lookup_method(method_name, error)
    }

    print(indent) {
        var spaces = " ".repeat(indent)

        for (var variable_name in this.variables) {
            if (!this.variables[variable_name].isparam) {
                console.log(spaces + this.variables[variable_name].name + " :: " + this.variables[variable_name].type.get_type())
            }
        }

        for (var child in this.children) {
            console.log("\n" + spaces + "{")
            this.children[child].print(indent + 4);
            console.log(spaces + "}")
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
        this.num_parameters = parameters.length
        this.return_type = return_type
        this.table = scope_table

        this.parameters.forEach(function (parameter) {
            parameter.isparam = true
            scope_table.variables[parameter.name] = parameter;
        })
    }

    print(indent) {
        var spaces = " ".repeat(indent)

        var parameters = ""
        for (var parameter in this.parameters) {
            parameters += this.parameters[parameter].name + " :: " + this.parameters[parameter].type.get_type() + ", "
        }
        console.log(spaces + "Method: " + this.name + " ( " + parameters.substr(0, parameters.length - 2) + " ) {")
        this.table.print(indent + 4)
        console.log(spaces + "}")
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

    lookup_variable(variable_name, error) {
        if (variable_name in this.variables) {
            return this.variables[variable_name]
        }
        else if (this.parent instanceof Class) {
            return this.parent.lookup_variable(variable_name, error)
        }
        else {
            if (error) {
                throw Error("The variable " + variable_name + " was not declared in the current scope!")
            }
        }
    }

    lookup_method(method_name, error) {
        if (method_name in this.methods) {
            return this.methods[method_name]
        }
        else if (this.parent instanceof Class) {
            return this.parent.lookup_method(method_name, error)
        }
        else {
            if (error) {
                throw Error("The method " + method_name + " was not declared in the current scope!")
            }
        }
    }

    create_label() {
        return this.parent.create_label()
    }

    print(indent) {
        var spaces = " ".repeat(indent + 4)

        console.log(" ".repeat(indent) + "Class: " + this.name + " {")
        for (var variable_name in this.variables) {
            console.log(spaces + variable_name + " :: " + this.variables[variable_name].type.get_type())
        }

        console.log("")
        for (var method_name in this.methods) {
            this.methods[method_name].print(indent = 4)
            console.log("")
        }
        console.log("}\n")
    }
}


class SymbolTable {
    constructor() {
        this.classes = {}

        this.current_class = null
        this.current_scope = null

        this.temporaries_count = 0

        this.labels_count = 0
    }

    get_class(name) {
        if (!(name in this.classes)) {
            throw Error("The class " + name + " has not been declared in the current scope!")
        }

        return this.classes[name]
    }

    add_class(name, parent_name = "") {
        if (name in this.classes) {
            throw Error("The class " + name + " has already been declared!")
        }

        var parent = this
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
        return this.current_class.add_method(name, return_type, parameters, scope_table, main = main)
    }

    add_variable(name, type) {
        return this.current_scope.add_variable(name, type)
    }

    create_temporary() {
        this.temporaries_count += 1

        var name = "t_" + this.temporaries_count

        while (this.lookup_variable(name, false)) {
            this.temporaries_count += 1
            name = "t_" + this.temporaries_count
        }

        return name
    }

    scope_start(category = null) {
        var table = new ScopeTable(this.current_class, this.current_scope, category = category)

        if (this.current_scope != this.current_class) {
            this.current_scope.children.push(table)
            table.parent = this.current_scope
        }

        this.current_scope = table

        return table
    }

    scope_end() {
        var table = this.current_scope

        this.current_scope = this.current_scope.parent

        return table
    }

    create_label() {
        this.labels_count += 1

        return "l_" + this.labels_count
    }

    lookup_variable(variable_name, error = true) {
        return this.current_scope.lookup_variable(variable_name, error)
    }

    lookup_method(method_name, error = true) {
        return this.current_scope.lookup_method(method_name, error)
    }

    print() {
        console.log("-".repeat(30) + "\n")

        for (var class_name in this.classes) {
            this.classes[class_name].print(0)
        }

        console.log("-".repeat(30) + "\n")
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