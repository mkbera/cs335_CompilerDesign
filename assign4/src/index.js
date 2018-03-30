var parser = require('parser').parser;

var fs = require("fs");

var symtab = require("./symbol-table")

global.SymbolTable = symtab.SymbolTable
global.ScopeTable = symtab.ScopeTable
global.Variable = symtab.Variable
global.Method = symtab.Method
global.Class = symtab.Class
global.Type = symtab.Type

global.ir_sep = "\t"

global.ST = new SymbolTable()

var input_file = "in.java";
if (process.argv.length >= 3) {
    input_file = process.argv[2];
}
input = fs.readFileSync(input_file).toString();
console.log("Reading Input from file: " + input_file);

output = parser.parse(input)

console.log("")
ST.print()

output.forEach(function (line) {
    console.log(line)
});