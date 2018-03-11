rules = {
	// PROGRAM
	program: [
		[{ nt: "import_decrs", optional: true }, { nt: "type_decrs", optional: true }, "EOF"]
	],


	// DECLARATIONS
	import_decrs: [
		[{ nt: "import_decr" }],
		[{ nt: "import_decrs" }, { nt: "import_decr" }],
	],
	import_decr: [
		["import", "identifier", "terminator"]
	],

	type_decrs: [
		[{ nt: "type_decrs" }, { nt: "type_decr" }],
		[{ nt: "type_decr" }]
	],
	type_decr: [
		[{ nt: "class_decr" }],
		["terminator"]
	],

	class_decr: [
		["public", "class", "identifier", { nt: "extend_decr", optional: true }, { nt: "class_body" }],
		["class", "identifier", { nt: "extend_decr", optional: true }, { nt: "class_body" }]
	],
	extend_decr: [
		["extends", "identifier"]
	],
	class_body: [
		["set_start", { nt: "class_body_decrs" }, "set_end"]
	],
	class_body_decrs: [
		[{ nt: "class_body_decrs" }, { nt: "class_body_decr" }],
		[{ nt: "class_body_decr" }]
	],
	class_body_decr: [
		[{ nt: "class_member_decr" }],
		// ["static", { nt: "block" }], // TO BE REMOVED (PROBABLY)
		["public", { nt: "consr_declarator" }, { nt: "consr_body" }],
		[{ nt: "consr_declarator" }, { nt: "consr_body" }]
	],
	class_member_decr: [
		[{ nt: "field_decr" }],
		[{ nt: "method_decr" }]
	],

	consr_declarator: [
		["identifier", "paranthesis_start", { nt: "formal_parameter_list" }, "paranthesis_end"]
	],
	formal_parameter_list: [
		[{ nt: "formal_parameter_list" }, "separator", { nt: "formal_parameter" }],
		[{ nt: "formal_parameter" }],
		[]
	],
	formal_parameter: [
		[{ nt: "type" }, { nt: "var_declarator_id" }]
	],
	consr_body: [
		["set_start", { nt: "explicit_consr_invocation", optional: true }, { nt: "block_stmts", optional: true }, "set_end"]
	],
	explicit_consr_invocation: [
		["this", "paranthesis_start", { nt: "argument_list", optional: true }, "paranthesis_end"],
		["super", "paranthesis_start", { nt: "argument_list", optional: true }, "paranthesis_end"]
	],

	field_decr: [
		["public", { nt: "type" }, { nt: "var_declarators" }, "terminator"],
		[{ nt: "type" }, { nt: "var_declarators" }, "terminator"]
	],
	var_declarators: [
		[{ nt: "var_declarators" }, "separator", { nt: "var_declarator" }],
		[{ nt: "var_declarator" }]
	],
	var_declarator: [
		[{ nt: "var_declarator_id" }],
		[{ nt: "var_declarator_id" }, "op_assign", { nt: "var_init" }]
	],
	var_declarator_id: [
		[{ nt: "var_declarator_id" }, "brackets_start", "brackets_end"],
		["identifier"]
	],
	var_init: [
		[{ nt: "expr" }],
		[{ nt: "array_init" }]
	],

	method_decr: [
		// ["public", { nt: "result_type" }, { nt: "method_declarator" }, { nt: "method_body" }], // TO BE REMOVED
		// [{ nt: "result_type" }, { nt: "method_declarator" }, { nt: "method_body" }] // TO BE REMOVED
		["public", { nt: "method_declarator" }, "colon", { nt: "result_type" }, { nt: "method_body" }], // NEW RULE
		[{ nt: "method_declarator" }, "colon", { nt: "result_type" }, { nt: "method_body" }] // NEW RULE
	],
	result_type: [
		[{ nt: "type" }],
		["void"]
	],
	method_declarator: [
		["identifier", "paranthesis_start", { nt: "formal_parameter_list" }, "paranthesis_end"]
	],
	method_body: [
		[{ nt: "block" }]
	],

	array_init: [
		["set_start", { nt: "var_inits", optional: true }, "separator", "set_end"],
		["set_start", { nt: "var_inits", optional: true }, "set_end"]
	],
	var_inits: [
		[{ nt: "var_inits" }, "separator", { nt: "var_init" }],
		[{ nt: "var_init" }]
	],


	// TYPES
	type: [
		[{ nt: "primitive_type" }],
		[{ nt: "reference_type" }]
	],
	primitive_type: [
		[{ nt: "integral_type" }],
		[{ nt: "floating_type" }],
		["boolean"]
	],
	integral_type: [
		["byte"],
		["short"],
		["int"],
		["long"],
		["char"]
	],
	floating_type: [
		["float"],
		["double"]
	],
	reference_type: [
		["identifier"],
		[{ nt: "type" }, "brackets_start", "brackets_end"]
	],
	// class_type: [ // TO BE REMOVED
	// 	["identifier"]
	// ],


	// BLOCKS AND COMMANDS
	block: [
		["set_start", { nt: "block_stmts", optional: true }, "set_end"]
	],
	block_stmts: [
		[{ nt: "block_stmts" }, { nt: "block_stmt" }],
		[{ nt: "block_stmt" }]
	],
	block_stmt: [
		[{ nt: "type" }, { nt: "var_declarators" }, "terminator"],
		[{ nt: "stmt" }]
	],

	stmt: [
		[{ nt: "stmt_wots" }],
		[{ nt: "if_then_stmt" }],
		[{ nt: "if_then_else_stmt" }],
		[{ nt: "while_stmt" }],
		[{ nt: "for_stmt" }]
	],
	stmt_nsi: [
		[{ nt: "stmt_wots" }],
		[{ nt: "if_then_else_stmt_nsi" }],
		[{ nt: "while_stmt_nsi" }],
		[{ nt: "for_stmt_nsi" }]
	],
	stmt_wots: [
		[{ nt: "block" }],
		[{ nt: "switch_stmt" }],
		[{ nt: "do_stmt" }],
		[{ nt: "break_stmt" }],
		[{ nt: "continue_stmt" }],
		[{ nt: "return_stmt" }],
		[{ nt: "stmt_expr" }, "terminator"],
		["terminator"]
	],

	if_then_stmt: [
		["if", "paranthesis_start", { nt: "expr" }, "paranthesis_end", { nt: "stmt" }]
	],
	if_then_else_stmt: [
		["if", "paranthesis_start", { nt: "expr" }, "paranthesis_end", { nt: "stmt_nsi" }, "else", { nt: "stmt" }]
	],
	if_then_else_stmt_nsi: [
		["if", "paranthesis_start", { nt: "expr" }, "paranthesis_end", { nt: "stmt_nsi" }, "else", { nt: "stmt_nsi" }]
	],

	switch_stmt: [
		["switch", "paranthesis_start", { nt: "expr" }, "paranthesis_end", { nt: "switch_block" }]
	],
	switch_block: [
		["set_start", { nt: "switch_block_stmt_groups", optional: true }, { nt: "switch_labels", optional: true }, "set_end"]
	],
	switch_block_stmt_groups: [
		[{ nt: "switch_block_stmt_groups" }, { nt: "switch_block_stmt_group" }],
		[{ nt: "switch_block_stmt_group" }]
	],
	switch_block_stmt_group: [
		[{ nt: "switch_labels" }, { nt: "block_stmts" }]
	],
	switch_labels: [
		[{ nt: "switch_labels" }, { nt: "switch_label" }],
		[{ nt: "switch_label" }]
	],
	switch_label: [
		// NOTE: WE ARE NOT EVALUATING CONSTANT EXPRESSION, BUT ONLY LITERALS
		["case", { nt: "literal" }, "colon"],
		["case", "paranthesis_start", { nt: "literal" }, "paranthesis_end", "colon"],
		["default", "colon"]
	],

	while_stmt: [
		["while", "paranthesis_start", { nt: "expr" }, "paranthesis_end", { nt: "stmt" }]
	],
	while_stmt_nsi: [
		["while", "paranthesis_start", { nt: "expr" }, "paranthesis_end", { nt: "stmt_nsi" }]
	],

	do_stmt: [
		["do", { nt: "stmt" }, "while", "paranthesis_start", { nt: "expr" }, "paranthesis_end", "terminator"]
	],

	for_stmt: [
		["for", "paranthesis_start", { nt: "for_init", optional: true }, "terminator", { nt: "expr", optional: true }, "terminator", { nt: "stmt_expr_list", optional: true }, "paranthesis_end", { nt: "stmt" }]
	],
	for_stmt_nsi: [
		["for", "paranthesis_start", { nt: "for_init", optional: true }, "terminator", { nt: "expr", optional: true }, "terminator", { nt: "stmt_expr_list", optional: true }, "paranthesis_end", { nt: "stmt_nsi" }]
	],
	for_init: [
		[{ nt: "stmt_expr_list" }],
		[{ nt: "type" }, { nt: "var_declarators" }]
	],
	stmt_expr_list: [
		[{ nt: "stmt_expr_list" }, "separator", { nt: "stmt_expr" }],
		[{ nt: "stmt_expr" }]
	],

	break_stmt: [
		["break", "terminator"]
	],
	continue_stmt: [
		["continue", "terminator"]
	],
	return_stmt: [
		["return", { nt: "expr", optional: true }, "terminator"]
	],


	expr: [
		[{ nt: "cond_expr" }],
		[{ nt: "assignment" }]
	],
	stmt_expr: [
		[{ nt: "assignment" }],
		[{ nt: "preinc_expr" }],
		[{ nt: "predec_expr" }],
		[{ nt: "postinc_expr" }],
		[{ nt: "postdec_expr" }],
		[{ nt: "method_invocation" }],
		[{ nt: "class_instance_creation_expr" }]
	],

	assignment: [
		[{ nt: "left_hand_side" }, { nt: "assignment_operator" }, { nt: "expr" }]
	],
	left_hand_side: [
		[{ nt: "expr_name" }],
		[{ nt: "field_access" }],
		[{ nt: "array_access" }]
	],
	assignment_operator: [
		["op_assign"],
		["op_mulAssign"],
		["op_divAssign"],
		["op_modAssign"],
		["op_addAssign"],
		["op_subAssign"],
		["op_LshiftEqual"],
		["op_RshiftEqual"],
		["op_andAssign"],
		["op_orAssign"],
		["op_xorAssign"]
	],

	cond_expr: [
		[{ nt: "cond_or_expr" }],
		// [{ nt: "cond_or_expr", optional: true }, { nt: "expr" }, "colon", { nt: "cond_expr" }] // TO BE REMOVED
	],
	cond_or_expr: [
		[{ nt: "cond_and_expr" }],
		[{ nt: "cond_or_expr" }, "op_oror", { nt: "cond_and_expr" }]
	],
	cond_and_expr: [
		[{ nt: "incl_or_expr" }],
		[{ nt: "cond_and_expr" }, "op_andand", { nt: "incl_or_expr" }]
	],

	incl_or_expr: [
		[{ nt: "excl_or_expr" }],
		[{ nt: "incl_or_expr" }, "op_or", { nt: "excl_or_expr" }]
	],
	excl_or_expr: [
		[{ nt: "and_expr" }],
		[{ nt: "excl_or_expr" }, "op_xor", { nt: "and_expr" }]
	],

	and_expr: [
		[{ nt: "equality_expr" }],
		[{ nt: "and_expr" }, "op_and", { nt: "equality_expr" }]
	],
	equality_expr: [
		[{ nt: "relational_expr" }],
		[{ nt: "equality_expr" }, "op_equalCompare", { nt: "relational_expr" }],
		[{ nt: "equality_expr" }, "op_notequalCompare", { nt: "relational_expr" }],
	],
	relational_expr: [
		[{ nt: "shift_expr" }],
		[{ nt: "relational_expr" }, "op_greater", { nt: "shift_expr" }],
		[{ nt: "relational_expr" }, "op_greaterEqual", { nt: "shift_expr" }],
		[{ nt: "relational_expr" }, "op_less", { nt: "shift_expr" }],
		[{ nt: "relational_expr" }, "op_lessEqual", { nt: "shift_expr" }],
		[{ nt: "relational_expr" }, "instanceof", { nt: "shift_expr" }]
	],
	shift_expr: [
		[{ nt: "additive_expr" }],
		[{ nt: "shift_expr" }, "op_Lshift", { nt: "additive_expr" }],
		[{ nt: "shift_expr" }, "op_Rshift", { nt: "additive_expr" }]
	],
	additive_expr: [
		[{ nt: "multiplicative_expr" }],
		[{ nt: "additive_expr" }, "op_add", { nt: "multiplicative_expr" }],
		[{ nt: "additive_expr" }, "op_sub", { nt: "multiplicative_expr" }]
	],
	multiplicative_expr: [
		[{ nt: "unary_expr" }],
		[{ nt: "multiplicative_expr" }, "op_mul", { nt: "unary_expr" }],
		[{ nt: "multiplicative_expr" }, "op_div", { nt: "unary_expr" }],
		[{ nt: "multiplicative_expr" }, "op_mod", { nt: "unary_expr" }]
	],

	predec_expr: [
		["op_decrement", { nt: "unary_expr" }]
	],
	preinc_expr: [
		["op_increment", { nt: "unary_expr" }]
	],

	unary_expr: [
		[{ nt: "preinc_expr" }],
		[{ nt: "predec_expr" }],
		["op_add", { nt: "unary_expr" }],
		["op_sub", { nt: "unary_expr" }],
		[{ nt: "unary_expr_npm" }]
	],
	unary_expr_npm: [
		[{ nt: "postfix_expr" }],
		[{ nt: "postinc_expr" }], // CUSTOM
		[{ nt: "postdec_expr" }], // CUSTOM
		["op_not", { nt: "unary_expr" }],
		[{ nt: "cast_expr" }],
	],

	cast_expr: [
		["paranthesis_start", { nt: "primitive_type" }, "paranthesis_end", { "nt": "unary_expr" }],
		// ["paranthesis_start", { nt: "primitive_type" }, "paranthesis_end", { "nt": "unary_expr_npm" }] // TO BE REMOVED
	],

	postdec_expr: [
		[{ nt: "postfix_expr" }, "op_decrement"]
	],
	postinc_expr: [
		[{ nt: "postfix_expr" }, "op_increment"]
	],

	postfix_expr: [
		[{ nt: "primary" }],
		[{ nt: "expr_name" }],
		// NOTE: DOES NOT ALLOW MULTIPLE POST-INCREMENTS
		// [{ nt: "postinc_expr" }],
		// [{ nt: "postdec_expr" }]
	],

	method_invocation: [
		[{ nt: "expr_name" }, "paranthesis_start", { nt: "argument_list", optional: true }, "paranthesis_end"],
		[{ nt: "primary" }, "field_invoker", "identifier", "paranthesis_start", { nt: "argument_list", optional: true }, "paranthesis_end"],
		["super", "field_invoker", "identifier", "paranthesis_start", { nt: "argument_list", optional: true }, "paranthesis_end"]
	],
	field_access: [
		[{ nt: "primary" }, "field_invoker", "identifier"],
		["super", "field_invoker", "identifier"]
	],
	array_access: [
		// [{ nt: "expr_name" }, "brackets_start", { nt: "expr" }, "brackets_end"], // TO BE REMOVED
		// [{ nt: "primary_no_new_array" }, "brackets_start", { nt: "expr" }, "brackets_end"] // TO BE REMOVED
		// NOTE: ARRAY ACCESS arr<...><...>
		[{ nt: "expr_name" }, "colon", { nt: "dim_exprs" }], // CUSTOM
		[{ nt: "primary_no_new_array" }, "colon", { nt: "dim_exprs" }] // CUSTOM
	],
	primary: [
		[{ nt: "primary_no_new_array" }],
		[{ nt: "array_creation_expr" }]
	],
	primary_no_new_array: [
		[{ nt: "literal" }],
		["this"],
		["paranthesis_start", { nt: "expr" }, "paranthesis_end"],
		[{ nt: "class_instance_creation_expr" }],
		[{ nt: "field_access" }],
		[{ nt: "array_access" }],
		[{ nt: "method_invocation" }]
	],
	class_instance_creation_expr: [
		["new", "identifier", "paranthesis_start", { nt: "argument_list", optional: true }, "paranthesis_end"]
	],
	argument_list: [
		[{ nt: "expr" }],
		[{ nt: "argument_list" }, "separator", { nt: "expr" }]
	],
	array_creation_expr: [
		// [{ nt: "expr" }], // TO BE REMOVED
		["new", { nt: "primitive_type" }, { nt: "dim_exprs" }, { nt: "dims", optional: true }],
		["new", "identifier", { nt: "dim_exprs" }, { nt: "dims", optional: true }]
	],
	dim_exprs: [
		[{ nt: "dim_exprs" }, { nt: "dim_expr" }],
		[{ nt: "dim_expr" }]
	],
	dim_expr: [
		["brackets_start", { nt: "expr" }, "brackets_end"]
	],
	dims: [
		["brackets_start", "brackets_end"],
		[{ nt: "dims" }, "brackets_start", "brackets_end"]
	],


	// // TOKENS
	expr_name: [
		["identifier"],
		[{ nt: "expr_name" }, "field_invoker", "identifier"]
	],
	literal: [
		["integer_literal"],
		// [{ nt: "signed_integer_literal" }], // TO BE REMOVED
		["float_literal"],
		// [{ nt: "signed_float_literal" }], // TO BE REMOVED
		["boolean_literal"],
		["character_literal"],
		["string_literal"],
		["null_literal"]
	],
	sign: [
		["op_add"],
		["op_sub"]
	],
	// signed_integer_literal: [ // TO BE REMOVED
	// 	[{ nt: "sign" }, "integer_literal"]
	// ],
	// signed_float_literal: [ // TO BE REMOVED
	// 	[{ nt: "sign" }, "float_literal"]
	// ]
}

module.exports = {
	rules: rules
}