rules = {
	// PROGRAM
	program: [
		[{
			nt: "compilation_unit"
		}]
	],


	// LEXICAL STRUCTURE
	literal: [
		["integer_literal"],
		["float_literal"],
		["boolean_literal"],
		["character_literal"],
		["string_literal"],
		["null_literal"]
	],

	// TYPES
	type: [
		[{
			nt: "primitive_type"
		}],
		[{
			nt: "reference_type"
		}]
	],
	primitive_type: [
		[{
			nt: "numeric_type"
		}],
		["boolean"]
	],
	numeric_type: [
		[{
			nt: "integral_type"
		}],
		[{
			nt: "floating_point_type"
		}]
	],
	integral_type: [
		["byte"],
		["short"],
		["int"],
		["long"],
		["char"]
	],
	floating_point_type: [
		["float"],
		["double"]
	],
	reference_type: [
		[{
			nt: "class_type"
		}],
		[{
			nt: "array_type"
		}]
	],
	class_type: [
		[{
			nt: "name"
		}]
	],
	array_type: [
		[{
			nt: "primitive_type"
		}, "brackets_start", "brackets_end"],
		[{
			nt: "name"
		}, "brackets_start", "brackets_end"],
		[{
			nt: "array_type"
		}, "brackets_start", "brackets_end"]
	],

	// NAMES
	name: [
		[{
			nt: "simple_name"
		}],
		[{
			nt: "qualified_name"
		}]
	],
	simple_name: [
		["identifier", ]
	],
	qualified_name: [
		[{
			nt: "name"
		}, "field_invoker", "identifier", ]
	],
	"class_body_declarations": [
		[{
			"nt": "class_body_declaration"
		}],
		[{
				"nt": "class_body_declarations"
			},
			{
				"nt": "class_body_declaration"
			}
		]
	],
	"class_member_declaration": [
		[{
			"nt": "field_declaration"
		}],
		[{
			"nt": "method_declaration"
		}]
	],
	"class_body": [
		[
			"set_start",
			{
				"optional": true,
				"nt": "class_body_declarations"
			},
			"set_start"
		]
	],
	"class_declaration": [
		[{
				"optional": true,
				"nt": "modifiers"
			},
			"class",
			{
				"nt": "identifier"
			},
			{
				"optional": true,
				"nt": "super"
			},
			{
				"nt": "class_body"
			}
		]
	],
	"class_body_declaration": [
		[{
			"nt": "class_member_declaration"
		}],
		[{
			"nt": "constructor_declaration"
		}]
	],
	"super": [
		[
			"extends",
			{
				"nt": "class_type"
			}
		]
	],

	"variable_declarators": [
		[{
			"nt": "variable_declarator"
		}],
		[{
				"nt": "variable_declarators"
			},
			"separator",
			{
				"nt": "variable_declarator"
			}
		]
	],
	"field_declaration": [
		[{
				"optional": true,
				"nt": "modifiers"
			},
			{
				"nt": "type"
			},
			{
				"nt": "variable_declarators"
			},
			"terminator"
		]
	],
	"variable_initializer": [
		[{
			"nt": "expression"
		}],
		[{
			"nt": "array_initializer"
		}]
	],
	"variable_declarator_id": [
		[
			"identifier"
		],
		[{
				"nt": "variable_declarator_id"
			},
			"brackets_start",
			"brackets_end"
		]
	],
	"variable_declarator": [
		[{
			"nt": "variable_declarator_id"
		}],
		[{
				"nt": "variable_declarator_id"
			},
			"op_assign",
			{
				"nt": "variable_initializer"
			}
		]
	],
	"formal_parameter": [
		[{
				"nt": "type"
			},
			{
				"nt": "variable_declarator_id"
			}
		]
	],
	"formal_parameter_list": [
		[{
			"nt": "formal_parameter"
		}],
		[{
				"nt": "formal_parameter_list"
			},
			"separator",
			{
				"nt": "formal_parameter"
			}
		]
	],
	"method_declaration": [
		[{
				"nt": "method_header"
			},
			{
				"nt": "method_body"
			}
		]
	],
	"class_type_list": [
		[{
			"nt": "class_type"
		}],
		[{
				"nt": "class_type_list"
			},
			"separator",
			{
				"nt": "class_type"
			}
		]
	],
	"method_header": [
		[{
				"optional": true,
				"nt": "modifiers"
			},
			{
				"nt": "type"
			},
			{
				"nt": "method_declarator"
			}
		],
		[{
				"optional": true,
				"nt": "modifiers"
			},
			{
				"nt": "oid"
			},
			{
				"nt": "method_declarator"
			}
		]
	],
	"method_body": [
		[{
			"nt": "block"
		}],
		[
			"terminator"
		]
	],
	"method_declarator": [
		[
			"identifier",
			"paranthesis_start",
			{
				"optional": true,
				"nt": "formal_parameter_list"
			},
			"paranthesis_end"
		],
		[{
				"nt": "method_declarator"
			},
			"brackets_start",
			"brackets_end"
		]
	],
	"constructor_declarator": [
		[{
				"nt": "simple_name"
			},
			"paranthesis_start",
			{
				"optional": true,
				"nt": "formal_parameter_list"
			},
			"paranthesis_end"
		]
	],
	"explicit_constructor_invocation": [
		[
			"this",
			"paranthesis_start",
			{
				"optional": true,
				"nt": "argument_list"
			},
			"paranthesis_end",
			{
				"nt": ""
			}
		],
		[
			"super",
			"paranthesis_start",
			{
				"optional": true,
				"nt": "argument_list"
			},
			"paranthesis_end",
			{
				"nt": ""
			}
		]
	],
	"constructor_declaration": [
		[{
				"optional": true,
				"nt": "modifiers"
			},
			{
				"nt": "constructor_declarator"
			},
			{
				"optional": true,
				"nt": "throws"
			},
			{
				"nt": "constructor_body"
			}
		]
	],
	"constructor_body": [
		[
			"set_start",
			{
				"optional": true,
				"nt": "explicit_constructor_invocation"
			},
			{
				"optional": true,
				"nt": "block_statements"
			},
			"set_end"
		]
	],
	"variable_initializers": [
		[{
			"nt": "variable_initializer"
		}],
		[{
				"nt": "variable_initializers"
			},
			"separator",
			{
				"nt": "variable_initializer"
			}
		]
	],
	"array_initializer": [
		[{
				"nt": ""
			},
			{
				"optional": true,
				"nt": "variable_initializers"
			},
			"separator",
			{
				"nt": ""
			}
		],
		[{
				"nt": ""
			},
			{
				"optional": true,
				"nt": "variable_initializers"
			},
			{
				"nt": ""
			}
		]
	],
	"expression_statement": [
		[{
				"nt": "statement_expression"
			},
			"terminator"
		]
	],
	"statement_no_short_if": [
		[{
			"nt": "statement_without_trailing_substatement"
		}],
		[{
			"nt": "if_then_else_statement_no_short_if"
		}],
		[{
			"nt": "while_statement_no_short_if"
		}],
		[{
			"nt": "for_statement_no_short_if"
		}]
	],
	"for_init": [
		[{
			"nt": "statement_expression_list"
		}],
		[{
			"nt": "local_variable_declaration"
		}]
	],
	"break_statement": [
		[
			"break",
			"terminator"
		]
	],
	"if_then_statement": [
		[
			"if",
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end",
			{
				"nt": "statement"
			}
		]
	],
	"switch_statement": [
		[
			"switch",
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end",
			{
				"nt": "switch_block"
			}
		]
	],
	"switch_block_statement_groups": [
		[{
			"nt": "switch_block_statement_group"
		}],
		[{
				"nt": "switch_block_statement_groups"
			},
			{
				"nt": "switch_block_statement_group"
			}
		]
	],
	"block_statement": [
		[{
			"nt": "local_variable_declaration_statement"
		}],
		[{
			"nt": "statement"
		}]
	],
	"switch_labels": [
		[{
			"nt": "switch_label"
		}],
		[{
				"nt": "switch_labels"
			},
			{
				"nt": "switch_label"
			}
		]
	],
	"return_statement": [
		[
			"return",
			{
				"optional": true,
				"nt": "expression"
			},
			"terminator"
		]
	],
	"while_statement": [
		["while",
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end",
			{
				"nt": "statement"
			}
		]
	],
	"continue_statement": [
		[
			"continue",
			"terminator"
		]
	],
	"do_statement": [
		["do", {
				"nt": "statement"
			}, "while",
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end",
			"terminator"
		]
	],
	"statement": [
		[{
			"nt": "statement_without_trailing_substatement"
		}],
		[{
			"nt": "labeled_statement"
		}],
		[{
			"nt": "if_then_statement"
		}],
		[{
			"nt": "if_then_else_statement"
		}],
		[{
			"nt": "while_statement"
		}],
		[{
			"nt": "for_statement"
		}]
	],
	"post_expression": [
		[{
			"nt": "post_increment_expression"
		}],
		[{
			"nt": "post_decrement_expression"
		}],
	],
	"statement_expression": [
		[{
			"nt": "assignment"
		}],
		[{
			"nt": "pre_increment_expression"
		}],
		[{
			"nt": "pre_decrement_expression"
		}],
		[{
			"nt": "post_expression"
		}],
		[{
			"nt": "method_invocation"
		}],
		[{
			"nt": "class_instance_creation_expression"
		}]
	],
	"while_statement_no_short_if": [
		[{
				"nt": "hile"
			},
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end",
			{
				"nt": "statement_no_short_if"
			}
		]
	],
	"block_statements": [
		[{
			"nt": "block_statement"
		}],
		[{
				"nt": "block_statements"
			},
			{
				"nt": "block_statement"
			}
		]
	],
	"for_statement": [
		["for",
			"paranthesis_start",
			{
				"optional": true,
				"nt": "for_init"
			},
			"terminator",
			{
				"optional": true,
				"nt": "expression"
			},
			"terminator",
			{
				"optional": true,
				"nt": "for_update"
			},
			"paranthesis_end",
			{
				"nt": "statement"
			}
		]
	],
	"local_variable_declaration_statement": [
		[{
				"nt": "local_variable_declaration"
			},
			"terminator"
		]
	],
	"for_statement_no_short_if": [
		["for",
			"paranthesis_start",
			{
				"optional": true,
				"nt": "for_init"
			},
			"terminator",
			{
				"optional": true,
				"nt": "expression"
			},
			"terminator",
			{
				"optional": true,
				"nt": "for_update"
			},
			"paranthesis_end", {
				"nt": "statement_no_short_if"
			}
		]
	],
	"statement_without_trailing_substatement": [
		[{
			"nt": "block"
		}],
		[{
			"nt": "empty_statement"
		}],
		[{
			"nt": "expression_statement"
		}],
		[{
			"nt": "switch_statement"
		}],
		[{
			"nt": "do_statement"
		}],
		[{
			"nt": "break_statement"
		}],
		[{
			"nt": "continue_statement"
		}],
		[{
			"nt": "return_statement"
		}]
	],
	"for_update": [
		[{
			"nt": "statement_expression_list"
		}]
	],
	"statement_expression_list": [
		[{
			"nt": "statement_expression"
		}],
		[{
				"nt": "statement_expression_list"
			},
			"separator",
			{
				"nt": "statement_expression"
			}
		]
	],
	"switch_label": [
		[
			"case",
			{
				"nt": "constant_expression"
			},
			"colon"
		],
		[
			"default",
			"colon"
		]
	],
	"switch_block_statement_group": [
		[{
				"nt": "switch_labels"
			},
			{
				"nt": "block_statements"
			}
		]
	],
	"empty_statement": [
		[
			"terminator"
		]
	],
	"if_then_else_statement_no_short_if": [
		[
			"if",
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end",
			{
				"nt": "statement_no_short_if"
			},
			{
				"nt": "lse"
			},
			{
				"nt": "statement_no_short_if"
			}
		]
	],
	"switch_block": [
		[
			"set_start",
			{
				"optional": true,
				"nt": "switch_block_statement_groups"
			},
			{
				"optional": true,
				"nt": "switch_labels"
			},
			"set_end"
		]
	],
	"local_variable_declaration": [
		[{
				"nt": "type"
			},
			{
				"nt": "variable_declarators"
			}
		]
	],
	"block": [
		[
			"set_start",
			{
				"optional": true,
				"nt": "block_statements"
			},
			"set_end"
		]
	],
	"if_then_else_statement": [
		[
			"if",
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end",
			{
				"nt": "statement_no_short_if"
			},
			{
				"nt": "lse"
			},
			{
				"nt": "statement"
			}
		]
	],
	"sign": [
		["op_add"],
		["op_sub"]
	],
	"unary_expression": [
		[{
			"nt": "pre_increment_expression"
		}],
		[{
			"nt": "pre_decrement_expression"
		}],
		[{
				"nt": "sign"
			},
			{
				"nt": "unary_expression"
			}
		],
		[{
			"nt": "unary_expression_not_plus_minus"
		}]
	],
	"exclusive_or_expression": [
		[{
			"nt": "and_expression"
		}],
		[{
				"nt": "exclusive_or_expression"
			},
			"op_xor",
			{
				"nt": "and_expression"
			}
		]
	],
	"left_hand_side": [
		[{
			"nt": "name"
		}],
		[{
			"nt": "field_access"
		}],
		[{
			"nt": "array_access"
		}]
	],
	"primary": [
		[{
			"nt": "primary_no_new_array"
		}],
		[{
			"nt": "array_creation_expression"
		}]
	],
	"unary_expression_not_plus_minus": [
		[{
			"nt": "postfix_expression"
		}],
		[{
			"nt": "post_expression"
		}],
		[
			"op_not",
			{
				"nt": "unary_expression"
			}
		],
		[{
			"nt": "cast_expression"
		}]
	],
	"array_creation_expression": [
		[
			"new",
			{
				"nt": "primitive_type"
			},
			{
				"nt": "dim_exprs"
			},
			{
				"optional": true,
				"nt": "dims"
			}
		],
		[
			"new",
			{
				"nt": "class_type"
			},
			{
				"nt": "dim_exprs"
			},
			{
				"optional": true,
				"nt": "dims"
			}
		]
	],
	"dim_exprs": [
		[{
			"nt": "dim_expr"
		}],
		[{
				"nt": "dim_exprs"
			},
			{
				"nt": "dim_expr"
			}
		]
	],
	"post_decrement_expression": [
		[{
				"nt": "postfix_expression"
			},
			"op_decrement"
		],
		[{
				"nt": "post_expression"
			},
			"op_decrement"
		]
	],
	"additive_expression": [
		[{
			"nt": "multiplicative_expression"
		}],
		[{
				"nt": "additive_expression"
			},
			"op_add",
			{
				"nt": "multiplicative_expression"
			}
		],
		[{
				"nt": "additive_expression"
			},
			"op_sub",
			{
				"nt": "multiplicative_expression"
			}
		]
	],
	"dim_expr": [
		[
			"brackets_start",
			{
				"nt": "expression"
			},
			"brackets_end"
		]
	],
	"array_access": [
		[{
				"nt": "name"
			},
			"brackets_start",
			{
				"nt": "expression"
			},
			"brackets_end"
		],
		[{
				"nt": "primary_no_new_array"
			},
			"brackets_start",
			{
				"nt": "expression"
			},
			"brackets_end"
		]
	],
	"postfix_expression": [
		[{
			"nt": "primary"
		}],
		[{
			"nt": "name"
		}]
	],
	"primary_no_new_array": [
		[{
			"nt": "literal"
		}],
		[
			"this"
		],
		[
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end"
		],
		[{
			"nt": "class_instance_creation_expression"
		}],
		[{
			"nt": "field_access"
		}],
		[{
			"nt": "method_invocation"
		}],
		[{
			"nt": "array_access"
		}]
	],
	"and_expression": [
		[{
			"nt": "equality_expression"
		}],
		[{
				"nt": "and_expression"
			},
			"op_and",
			{
				"nt": "equality_expression"
			}
		]
	],
	"argument_list": [
		[{
			"nt": "expression"
		}],
		[{
				"nt": "argument_list"
			},
			"separator",
			{
				"nt": "expression"
			}
		]
	],
	"cast_expression": [
		[
			"paranthesis_start",
			{
				"nt": "primitive_type"
			},
			{
				"optional": true,
				"nt": "dims"
			},
			"paranthesis_end",
			{
				"nt": "unary_expression"
			}
		],
		[
			"paranthesis_start",
			{
				"nt": "expression"
			},
			"paranthesis_end",
			{
				"nt": "unary_expression_not_plus_minus"
			}
		],
		[
			"paranthesis_start",
			{
				"nt": "name"
			},
			{
				"nt": "dims"
			},
			"paranthesis_end",
			{
				"nt": "unary_expression_not_plus_minus"
			}
		]
	],
	"conditional_or_expression": [
		[{
			"nt": "conditional_and_expression"
		}],
		[{
				"nt": "conditional_or_expression"
			},
			"op_oror",
			{
				"nt": "conditional_and_expression"
			}
		]
	],
	"constant_expression": [
		[{
			"nt": "expression"
		}]
	],
	"relational_expression": [
		[{
			"nt": "shift_expression"
		}],
		[{
				"nt": "relational_expression"
			},
			"op_less",
			{
				"nt": "shift_expression"
			}
		],
		[{
				"nt": "relational_expression"
			},
			"op_greater",
			{
				"nt": "shift_expression"
			}
		],
		[{
				"nt": "relational_expression"
			},
			"op_lessEqual",
			{
				"nt": "shift_expression"
			}
		],
		[{
				"nt": "relational_expression"
			},
			"op_greaterEqual",
			{
				"nt": "shift_expression"
			}
		],
		[{
				"nt": "relational_expression"
			},
			"instanceof",
			{
				"nt": "reference_type"
			}
		]
	],
	"field_access": [
		[{
				"nt": "primary"
			},
			"field-invoker",
			{
				"nt": "identifier"
			}
		],
		[
			"super",
			"field-invoker",
			{
				"nt": "identifier"
			}
		]
	],
	"assignment_expression": [
		[{
			"nt": "conditional_or_expression"
		}],
		[{
			"nt": "assignment"
		}]
	],
	"assignment": [
		[{
				"nt": "left_hand_side"
			},
			{
				"nt": "assignment_operator"
			},
			{
				"nt": "assignment_expression"
			}
		]
	],
	"multiplicative_expression": [
		[{
			"nt": "unary_expression"
		}],
		[{
				"nt": "multiplicative_expression"
			},
			"op_mul",
			{
				"nt": "unary_expression"
			}
		],
		[{
				"nt": "multiplicative_expression"
			},
			"op_div",
			{
				"nt": "unary_expression"
			}
		],
		[{
				"nt": "multiplicative_expression"
			},
			"op_mod",
			{
				"nt": "unary_expression"
			}
		]
	],
	"dims": [
		[
			"brackets_start",
			"brackets_end"
		],
		[{
				"nt": "dims"
			},
			"brackets_start",
			"brackets_end"
		]
	],
	"equality_expression": [
		[{
			"nt": "relational_expression"
		}],
		[{
				"nt": "equality_expression"
			},
			"op_equalCompare",
			{
				"nt": "relational_expression"
			}
		],
		[{
				"nt": "equality_expression"
			},
			"op_notequalCompare",
			{
				"nt": "relational_expression"
			}
		]
	],
	"method_invocation": [
		[{
				"nt": "name"
			},
			"paranthesis_start",
			{
				"optional": true,
				"nt": "argument_list"
			},
			"paranthesis_end"
		],
		[{
				"nt": "primary"
			},
			"field-invoker",
			{
				"nt": "identifier"
			},
			"paranthesis_start",
			{
				"optional": true,
				"nt": "argument_list"
			},
			"paranthesis_end"
		],
		["super",
			"field-invoker",
			{
				"nt": "identifier"
			},
			"paranthesis_start",
			{
				"optional": true,
				"nt": "argument_list"
			},
			"paranthesis_end"
		]
	],
	"shift_expression": [
		[{
			"nt": "additive_expression"
		}],
		[{
				"nt": "shift_expression"
			},
			"op_Lshift",
			{
				"nt": "additive_expression"
			}
		],
		[{
				"nt": "shift_expression"
			},
			"op_Rshift",
			{
				"nt": "additive_expression"
			}
		]
	],
	"class_instance_creation_expression": [
		[
			"new",
			{
				"nt": "class_type"
			},
			"paranthesis_start",
			{
				"optional": true,
				"nt": "argument_list"
			},
			"paranthesis_end"
		]
	],
	"inclusive_or_expression": [
		[{
			"nt": "exclusive_or_expression"
		}],
		[{
				"nt": "inclusive_or_expression"
			},
			"op_or",
			{
				"nt": "exclusive_or_expression"
			}
		]
	],
	"pre_increment_expression": [
		[
			"op_increment",
			{
				"nt": "unary_expression"
			}
		]
	],
	"post_increment_expression": [
		[{
				"nt": "postfix_expression"
			},
			"op_increment"
		],
		[{
				"nt": "post_expression"
			},
			"op_increment"
		]
	],
	"assignment_operator": [
		[
			"op_assign"
		],
		[
			"op_mulAssign"
		],
		[
			"op_divAssign"
		],
		[
			"op_modAssign"
		],
		[
			"op_addAssign"
		],
		[
			"op_subAssign"
		],
		[
			"op_LshiftEqual"
		],
		[
			"op_RshiftEqual"
		],
		[
			"op_andAssign"
		],
		[
			"op_orAssign"
		],
		[
			"op_xorAssig"
		]
	],
	"pre_decrement_expression": [
		[
			"op_decrement",
			{
				"nt": "unary_expression"
			}
		]
	],
	"expression": [
		[{
			"nt": "assignment_expression"
		}]
	],
	"conditional_and_expression": [
		[{
			"nt": "inclusive_or_expression"
		}],
		[{
				"nt": "conditional_and_expression"
			},
			"op_andand",
			{
				"nt": "inclusive_or_expression"
			}
		]
	],
	"import_declaration": [
		[
			"import",
			{
				"nt": "name"
			},
			"terminator"
		]
	],
	"type_declarations": [
		[{
			"nt": "type_declaration"
		}],
		[{
				"nt": "type_declarations"
			},
			{
				"nt": "type_declaration"
			}
		]
	],
	"import_declarations": [
		[{
			"nt": "import_declaration"
		}],
		[{
				"nt": "import_declarations"
			},
			{
				"nt": "import_declaration"
			}
		]
	],
	"compilation_unit": [
		[{
				"optional": true,
				"nt": "import_declarations"
			},
			{
				"optional": true,
				"nt": "type_declarations"
			}
		]
	],
	"type_declaration": [
		[{
			"nt": "class_declaration"
		}],
		[
			"terminator"
		]
	],
}

module.exports = {
	rules: rules
}