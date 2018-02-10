global.math_ops = ["+", "-", "^", "|", "&", "*", "/", "%", "=", "not", "inc", "dec", "=arr"]
global.math_ops_binary = ["+", "-", "^", "|", "&"]
global.math_ops_unary = ["not", "inc", "dec"]
global.math_ops_involved = ["*", "/", "%"]
global.array_ops = ["arr=", "=arr"]

global.keywords = ["if", "return", "function", "call", "block", "jump", "le", "ge", "lt", "gt", "eq", "ne", "print", "array"]

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