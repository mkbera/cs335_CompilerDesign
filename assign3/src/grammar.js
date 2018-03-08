rules = {
	code: [
		[{ nt: "stmt" }]
	],
	stmt: [
		[{ nt: "id" }, { nt: "op" }, { nt: "stmt" }],
		[{ nt: "id" }]
	],
	id: [
		["identifier"],
		["integer_literal"]
	],
	op: [
		["op_add"],
		["op_sub"]
	]
}

module.exports = {
	rules: rules
}