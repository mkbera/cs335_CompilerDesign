global.rel_ops = ['&&', '||', '~']
global.math_ops = ["+", "-", "/", "*", "=", "%", "^", "|", "&"]
global.math_ops_simple = ["+", "-", "^", "|", "&"]
global.math_ops_involved = ["*", "/"]
global.keywords = ["if", "return", "function", "call", "block", "jump", "le", "ge", "lt", "gt", "eq", "ne", "print"]

global.map_op = {
	"+": "add",
	"-": "sub",
	"/": "idiv",
	"*": "imul",
	"&": "and",
	"|": "or",
	"^": "xor",
	"eq": "je",
	"ne": "jne",
	"lt": "jl",
	"le": "jle",
	"gt": "jg",
	"ge": "jge"
}

module.exports = {
	rel_ops: rel_ops,
	math_ops: math_ops,
	math_ops_simple: math_ops_simple,
	math_ops_involved: math_ops_involved,
	keywords: keywords,
	map_op: map_op
}