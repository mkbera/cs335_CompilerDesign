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

    get_serial_type() {
        var serial_type = ""
        var type = this

        while (type.category == "array") {
            serial_type += "array."

            type = type.type
        }

        serial_type += type.type

        return serial_type
    }

    numeric() {
        return ["int", "short", "long", "char", "float"].indexOf(this.type) > -1
    }

    get_basic_type() {
        var type = this

        while (type.category == "array") {
            type = type.type
        }

        return type.type
    }

    get_size() {
        if (this.category != "array") {
            return 1
        }

        var type = this
        var size = 1

        while (type.category == "array") {
            size = size * type.length

            type = type.type
        }

        return size
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

        this.parameters = {}

        this.return_types = []
    }

    add_variable(name, type) {
        if (name in this.variables) {
            throw Error("The variable '" + name + "' has already been defined!")
        }
        if (name in this.parameters) {
            throw Error("The variable '" + name + "' has already been defined as the function parameter!")
        }

        var variable = new Variable(name, type)
        this.variables[name] = variable;

        return variable;
    }

    lookup_variable(name, error) {
        if (name in this.variables) {
            return this.variables[name]
        }
        else if (this.parent != null) {
            return this.parent.lookup_variable(name, error)
        }
        else {
            if (error) {
                throw Error("The variable '" + name + "' was not declared in the current scope!")
            }
        }
    }

    lookup_method(name, error) {
        return this.class.lookup_method(name, error)
    }

    print(indent) {
        var spaces = " ".repeat(indent)

        for (var name in this.variables) {
            if (!this.variables[name].isparam) {
                console.log(spaces + this.variables[name].name + " :: " + this.variables[name].type.get_type())
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

        if (this.main) {
            if (this.num_parameters != 0) {
                throw Error("The main function can not have any arguments")
            }
            if (this.return_type.type != "null") {
                throw Error("The return type of the main function must be void")
            }
        }
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

    add_method(name, return_type, parameters, scope_table, main) {
        if (name in this.methods) {
            throw Error("The method '" + name + "' has already been defined!")
        }

        var method = new Method(name, return_type, parameters, scope_table, main)
        this.methods[name] = method;

        return method
    }

    add_variable(name, type) {
        if (name in this.variables) {
            throw Error("The variable '" + name + "' has already been defined!")
        }

        var variable = new Variable(name, type)
        this.variables[name] = variable;

        return variable
    }

    lookup_variable(name, error) {
        if (name in this.variables) {
            return this.variables[name]
        }
        else if (this.parent instanceof Class) {
            return this.parent.lookup_variable(name, error)
        }
        else {
            if (error) {
                throw Error("The variable '" + name + "' was not declared in the current scope!")
            }
        }
    }

    lookup_method(name, error) {
        if (name in this.methods) {
            return this.methods[name]
        }
        else if (this.parent instanceof Class) {
            return this.parent.lookup_method(name, error)
        }
        else {
            if (error) {
                throw Error("The method '" + name + "' was not declared in the current scope!")
            }
        }
    }

    create_label() {
        return this.parent.create_label()
    }

    print(indent) {
        var spaces = " ".repeat(indent + 4)

        console.log(" ".repeat(indent) + "Class: " + this.name + " {")
        for (var name in this.variables) {
            console.log(spaces + name + " :: " + this.variables[name].type.get_type())
        }

        console.log("")
        for (var name in this.methods) {
            this.methods[name].print(indent = 4)
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

        this.import_methods = {}

        this.main_function = null
    }

    get_class(name) {
        if (!(name in this.classes)) {
            throw Error("The class '" + name + "' has not been declared in the current scope!")
        }

        return this.classes[name]
    }

    add_class(name, parent_name = "") {
        if (name in this.classes) {
            throw Error("The class '" + name + "' has already been declared!")
        }

        var parent = this
        if (parent_name != "") {
            if (!(parent_name in this.classes)) {
                throw Error("The class '" + parent_name + "' has not been declared in the current scope!")
            }

            parent = this.classes[parent_name];
        }

        var class_instance = new Class(name, parent)
        this.classes[name] = class_instance

        this.current_class = class_instance
        this.current_scope = class_instance

        return class_instance
    }

    add_method(name, return_type, parameters, scope_table) {
        if (name == "main") {
            if (this.main_function != null) {
                throw Error("The method '" + name + "' can be defined only once")
            }

            this.main_function = this.current_class.add_method(name, return_type, parameters, scope_table, true)

            return this.main_function
        }

        if (name in this.import_methods) {
            throw Error("The method '" + name + "' has already been declared as part of the " + this.import_methods[name] + " library")
        }

        return this.current_class.add_method(name, return_type, parameters, scope_table, false)
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

            table.parameters = this.current_scope.parameters
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

    lookup_variable(name, error = true) {
        return this.current_scope.lookup_variable(name, error)
    }

    lookup_method(name, error = true) {
        if (name in this.import_methods) {
            return this.import_methods[name]
        }

        return this.current_scope.lookup_method(name, error)
    }

    import(library) {
        console.log("Importing " + library)
        switch (library) {
            case "IO": {
                ST.import_methods = {}
                ST.import_methods["print_string"] = new Method(
                    "print_string",
                    new Type("null", "basic", null, null, 0),
                    [new Variable("print_string_param", new Type("string", "basic", null, null, 0), true)],
                    null,
                    false
                )
                ST.import_methods["print_float"] = new Method(
                    "print_float",
                    new Type("null", "basic", null, null, 0),
                    [new Variable("print_float_param", new Type("float", "basic", 4, null, 0), true)],
                    null,
                    false
                )
                ST.import_methods["print_char"] = new Method(
                    "print_char",
                    new Type("null", "basic", null, null, 0),
                    [new Variable("print_char_param", new Type("char", "basic", 1, null, 0), true)],
                    null,
                    false
                )
                ST.import_methods["print_int"] = new Method(
                    "print_int",
                    new Type("null", "basic", null, null, 0),
                    [new Variable("print_int_param", new Type("int", "basic", 4, null, 0), true)],
                    null,
                    false
                )

                ST.import_methods["scan_string"] = new Method(
                    "scan_string",
                    new Type("string", "basic", null, null, 0),
                    [],
                    null,
                    false
                )
                ST.import_methods["scan_float"] = new Method(
                    "scan_float",
                    new Type("float", "basic", 4, null, 0),
                    [],
                    null,
                    false
                )
                ST.import_methods["scan_char"] = new Method(
                    "scan_char",
                    new Type("char", "basic", 1, null, 0),
                    [],
                    null,
                    false
                )
                ST.import_methods["scan_int"] = new Method(
                    "scan_int",
                    new Type("int", "basic", 4, null, 0),
                    [],
                    null,
                    false
                )

                break
            }
            default: {
                throw Error("Library " + library + " not found")
            }
        }
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