rel_ops = ['&&', '||', '~']
math_ops = ["+", "-", "/", "*", "=", "%", "^", "|", "&"]
math_ops_1 = ["+", "-", "^", "|", "&"]
keywords = ["if", "return", "function", "call", "block", "jump", "leq", "geq", "lt", "gt", "eq", "neq", "print"]

map_op = {
	"+": "add",
	"-": "sub",
	"/": "idiv",
	"*": "mul",
	"&": "and",
	"|": "or",
	"^": "xor"
}

module.exports = {
	rel_ops: rel_ops,
	math_ops: math_ops,
	keywords: keywords,
	math_ops_1: math_ops_1,
	map_op: map_op,
}