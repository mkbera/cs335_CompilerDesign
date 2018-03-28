global.base_table = null


class Type {
    constructor(name, type, width, elem_type, length) {
        this.name = name

        if (typeof (type) === "string") {
            if (type == "basic") {
                this.isbasic = true
            }
            if (type == "array") {
                this.isarray = true
            }
            if (type == "pointer") {
                this.ispointer = true
            }
        }
        else {
            if (type.indexOf("basic") > -1) {
                this.isbasic = true
            }
            if (type.indexOf("array") > -1) {
                this.isarray = true
            }
            if (type.indexOf("pointer") > -1) {
                this.ispointer = true
            }
        }

        this.width = width
        this.length = length

        this.elem_type = elem_type
    }


    type_name() {
        if (this.isbasic) {
            return this.name
        }
        else if (this.isarray) {
            return "array of " + this.elem_type.type_name() + ", length " + this.length
        }
    }
}


class Table {
    constructor(prev = null) {
        this.hash = {}
        this.width = 0
        this.parent = prev
        this.children = []
    }

    insert_variable(var_type, identifier) {
        this.hash[identifier] = {}
        this.hash[identifier]["type"] = var_type
        this.hash[identifier]["category"] = "variable"
    }

    insert_temp(var_type, identifier) {
        if (identifier in this.hash) {
            this.hash[identifier] = {}
            this.hash[identifier]["type"] = var_type
            this.hash[identifier]["category"] = "temporary"
            return True
        }
        else {
            return False
        }
    }

    insert_array(var_type, identifier) {
        this.hash[identifier] = {}
        this.hash[identifier]["type"] = var_type
        this.hash[identifier]["category"] = "array"
    }

    insert_function(method_name, return_type, param_types, param_num) {
        if (!(method_name in this.hash)) {
            this.hash[method_name] = {}
            this.hash[method_name]["type"] = return_type
            this.hash[method_name]["category"] = "function"
            this.hash[method_name]["arg_num"] = param_num
            this.hash[method_name]["arg_types"] = param_types
        }
    }

    lookup_in_this(identifier) {
        if (identifier in this.hash) {
            return this.hash[identifier]
        }
        else {
            return None
        }
    }

    print_symbol_table() {
        var self = this;

        console.log("")
        console.log(Object.keys(this.hash))
        Object.keys(self.hash).forEach(function (key) {
            console.log("NAME: " + key)
            Object.keys(self.hash[key]).forEach(function (k) {
                if (k == "type" && typeof self.hash[key][k] !== "string") {
                    console.log(k + ": " + self.hash[key][k].type_name())
                }
                else if (k == "arg_types") {
                    var types = []
                    self.hash[key][k].forEach(function (t) {
                        if (typeof t !== "string") {
                            types.append(t.type_name())
                        }
                        else {
                            types.append(t)
                        }
                    });
                    console.log(k + ": " + types)
                }
                else {
                    console.log(k + ": " + self.hash[key][k])
                }
            });
            console.log("")
        });
    }
}


class SymbolTable {
    constructor() {
        this.curr_table = new Table(null)

        base_table = this.curr_table

        // this.label_count = 0
        this.temp_count = 0
    }

    maketemp(temp_type, table) {
        success = False
        while (success > 0) {
            name = "t" + str(this.temp_count)
            this.temp_count += 1
            success = table.insert_temp(temp_type, name)
        }
        return name
    }

    newlabel() {
        label = "L" + str(this.label_count)
        this.label_count += 1
        return label
    }

    begin_scope() {
        new_table = table(this.curr_table)
        this.curr_table.children.append(new_table)
        this.curr_table = new_table
        return this.curr_table
    }

    end_scope() {
        this.curr_table = this.curr_table.parent
    }

    insert_variable(var_type, identifier) {
        this.curr_table.insert_variable(var_type, identifier)
    }

    insert_temp(var_type, identifier) {
        this.curr_table.insert_temp(var_type, identifier)
    }

    insert_array(var_type, identifier) {
        this.curr_table.insert_array(var_type, identifier)
    }

    lookup(identifier, table) {
        if (table != None) {
            v = table.lookup_in_this(identifier)
            if (v == None) {
                return this.lookup(identifier, table.parent)
            }
            return v
        }
        else {
            return None
        }
    }

    insert_function(method_name, return_type, param_types, param_num) {
        console.log("####################################")
        this.curr_table.insert_function(method_name, return_type, param_types, param_num)
    }

    lookup_in_this(identifier) {
        this.curr_table.lookup_in_this(identifier)
    }

    print_symbol_table(t) {
        t.print_symbol_table()
        console.log("----------------")
        t.children.forEach(function (c) {
            this.print_symbol_table(c)
        });
    }

}

module.exports = {
    SymbolTable: SymbolTable,
    Table: Table,
    Type: Type
}