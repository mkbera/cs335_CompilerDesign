class SymbolTable {
    constructor(identifier, type = "int", return_type = null) {
        this.parameters = {
            "type": type,
            "return_type": return_type
        };
        this.identifier = identifier;
    }
}

class Registers {
    constructor() {
        this.register_descriptor = {
            "eax": null,
            "ebx": null,
            "ecx": null,
            "edx": null
        };
        this.address_descriptor = {

        };
    }
    //Method
    getReg(variable, inst) {
        
    }
}


var identifier_to_class = {}

variable_ops = ["+", "-", "/", "*", "=", "%", "^", "|"]
function_ops = ["function"]
reg_list = ["eax", "ebx", "ecx", "edx"]
keywords_3AC = ["if", "return", "function", "call", "block", "jmp", "leq", "geq", "lt", "gt", "eq", "neq", "print"]

function main() {
    if (process.argv.length < 3) {
        console.log("Filename not specified. Terminating lexer");
        return;
    }

    var fs = require("fs");

    filename = process.argv[2];

    console.log("Reading from file:  " + filename + "\n");

    fs.readFile(filename, "utf8", function (err, data) {
        if (err) throw err;
        // console.log(data[1]);
        var inst = data.split("\n");
        var num_inst = inst.length;

        for (i=0; i<num_inst; i++){
            var fields = inst[i].split("\t");
            if(variable_ops.indexOf(fields[0]) > -1){
                identifier_to_class[fields[1]] = new SymbolTable(fields[1], "int", null);
            }
            else if(function_ops.indexOf(fields[0]) > -1){
                identifier_to_class[fields[1]] = new SymbolTable(fields[1], "function", "int");
            }
        }
        
        console.log(identifier_to_class);
    });
}

main();