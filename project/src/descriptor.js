global.math_ops = ["+", "-", "^", "|", "&", "*", "/", "%", "=", "=arr"]
global.math_ops_binary = ["+", "-", "^", "|", "&"]
global.math_ops_unary = ["not", "inc", "dec"]
global.math_ops_involved = ["*", "/", "%"]
global.array_ops = ["arrset", "arrget"]

global.keywords = ["if", "return", "function", "call", "block", "jump", "le", "ge", "lt", "gt", "eq", "ne", "print", "scan", "array", "param", "int", "float", "char", "byte", "bool", "short"]

global.map_op = {
	"+": "add",
	"-": "sub",
	"&": "and",
	"|": "or",
	"^": "xor",
	"/": "idiv",
	"*": "imul",
	"not": "not",
	"inc": "inc",
	"dec": "dec",
	"eq": "je",
	"ne": "jne",
	"lt": "jl",
	"le": "jle",
	"gt": "jg",
	"ge": "jge"
}

module.exports = {
	math_ops: math_ops,
	math_ops_binary: math_ops_binary,
	math_ops_unary: math_ops_unary,
	math_ops_involved: math_ops_involved,
	keywords: keywords,
	map_op: map_op
}