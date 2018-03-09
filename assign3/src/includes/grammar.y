%moduleName MyParser
%mode LR1


program=
		import_decrs type_decrs 
		function() { this.push( this, "program", [{"nt":"import_decrs"},{"nt":"type_decrs"}] ) }
	|
		type_decrs 
		function() { this.push( this, "program", [{"nt":"type_decrs"}] ) }
	|
		import_decrs 
		function() { this.push( this, "program", [{"nt":"import_decrs"}] ) }
	|
		
		function() { this.push( this, "program", [] ) }
	;


import_decrs=
		import_decr 
		function() { this.push( this, "import_decrs", [{"nt":"import_decr"}] ) }
	|
		import_decrs import_decr 
		function() { this.push( this, "import_decrs", [{"nt":"import_decrs"},{"nt":"import_decr"}] ) }
	;


import_decr=
		'import' 'identifier' 'terminator' 
		function() { this.push( this, "import_decr", ["import","identifier","terminator"] ) }
	;


type_decrs=
		type_decrs type_decr 
		function() { this.push( this, "type_decrs", [{"nt":"type_decrs"},{"nt":"type_decr"}] ) }
	|
		type_decr 
		function() { this.push( this, "type_decrs", [{"nt":"type_decr"}] ) }
	;


type_decr=
		class_decr 
		function() { this.push( this, "type_decr", [{"nt":"class_decr"}] ) }
	|
		'terminator' 
		function() { this.push( this, "type_decr", ["terminator"] ) }
	;


class_decr=
		'public' 'class' 'identifier' super_nt class_body 
		function() { this.push( this, "class_decr", ["public","class","identifier",{"nt":"super_nt"},{"nt":"class_body"}] ) }
	|
		'class' 'identifier' super_nt class_body 
		function() { this.push( this, "class_decr", ["class","identifier",{"nt":"super_nt"},{"nt":"class_body"}] ) }
	|
		'public' 'class' 'identifier' class_body 
		function() { this.push( this, "class_decr", ["public","class","identifier",{"nt":"class_body"}] ) }
	|
		'class' 'identifier' class_body 
		function() { this.push( this, "class_decr", ["class","identifier",{"nt":"class_body"}] ) }
	;


super_nt=
		'extends' 'identifier' 
		function() { this.push( this, "super_nt", ["extends","identifier"] ) }
	;


class_body=
		'set_start' class_body_decrs 'set_end' 
		function() { this.push( this, "class_body", ["set_start",{"nt":"class_body_decrs"},"set_end"] ) }
	;


class_body_decrs=
		class_body_decrs class_body_decr 
		function() { this.push( this, "class_body_decrs", [{"nt":"class_body_decrs"},{"nt":"class_body_decr"}] ) }
	|
		class_body_decr 
		function() { this.push( this, "class_body_decrs", [{"nt":"class_body_decr"}] ) }
	;


class_body_decr=
		class_member_decr 
		function() { this.push( this, "class_body_decr", [{"nt":"class_member_decr"}] ) }
	|
		'public' consr_declarator consr_body 
		function() { this.push( this, "class_body_decr", ["public",{"nt":"consr_declarator"},{"nt":"consr_body"}] ) }
	|
		consr_declarator consr_body 
		function() { this.push( this, "class_body_decr", [{"nt":"consr_declarator"},{"nt":"consr_body"}] ) }
	;


class_member_decr=
		field_decr 
		function() { this.push( this, "class_member_decr", [{"nt":"field_decr"}] ) }
	|
		method_decr 
		function() { this.push( this, "class_member_decr", [{"nt":"method_decr"}] ) }
	;


consr_declarator=
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		function() { this.push( this, "consr_declarator", ["identifier","paranthesis_start",{"nt":"formal_parameter_list"},"paranthesis_end"] ) }
	;


formal_parameter_list=
		formal_parameter_list 'separator' formal_parameter 
		function() { this.push( this, "formal_parameter_list", [{"nt":"formal_parameter_list"},"separator",{"nt":"formal_parameter"}] ) }
	|
		formal_parameter 
		function() { this.push( this, "formal_parameter_list", [{"nt":"formal_parameter"}] ) }
	|
		
		function() { this.push( this, "formal_parameter_list", [] ) }
	;


formal_parameter=
		type var_declarator_id 
		function() { this.push( this, "formal_parameter", [{"nt":"type"},{"nt":"var_declarator_id"}] ) }
	;


consr_body=
		'set_start' explicit_consr_invocation block_stmts 'set_end' 
		function() { this.push( this, "consr_body", ["set_start",{"nt":"explicit_consr_invocation"},{"nt":"block_stmts"},"set_end"] ) }
	|
		'set_start' block_stmts 'set_end' 
		function() { this.push( this, "consr_body", ["set_start",{"nt":"block_stmts"},"set_end"] ) }
	|
		'set_start' explicit_consr_invocation 'set_end' 
		function() { this.push( this, "consr_body", ["set_start",{"nt":"explicit_consr_invocation"},"set_end"] ) }
	|
		'set_start' 'set_end' 
		function() { this.push( this, "consr_body", ["set_start","set_end"] ) }
	;


explicit_consr_invocation=
		'this' 'paranthesis_start' argument_list 'paranthesis_end' 
		function() { this.push( this, "explicit_consr_invocation", ["this","paranthesis_start",{"nt":"argument_list"},"paranthesis_end"] ) }
	|
		'super' 'paranthesis_start' argument_list 'paranthesis_end' 
		function() { this.push( this, "explicit_consr_invocation", ["super","paranthesis_start",{"nt":"argument_list"},"paranthesis_end"] ) }
	|
		'this' 'paranthesis_start' 'paranthesis_end' 
		function() { this.push( this, "explicit_consr_invocation", ["this","paranthesis_start","paranthesis_end"] ) }
	|
		'super' 'paranthesis_start' 'paranthesis_end' 
		function() { this.push( this, "explicit_consr_invocation", ["super","paranthesis_start","paranthesis_end"] ) }
	;


field_decr=
		'public' type var_declarators 'terminator' 
		function() { this.push( this, "field_decr", ["public",{"nt":"type"},{"nt":"var_declarators"},"terminator"] ) }
	|
		type var_declarators 'terminator' 
		function() { this.push( this, "field_decr", [{"nt":"type"},{"nt":"var_declarators"},"terminator"] ) }
	;


var_declarators=
		var_declarators 'separator' var_declarator 
		function() { this.push( this, "var_declarators", [{"nt":"var_declarators"},"separator",{"nt":"var_declarator"}] ) }
	|
		var_declarator 
		function() { this.push( this, "var_declarators", [{"nt":"var_declarator"}] ) }
	;


var_declarator=
		var_declarator_id 
		function() { this.push( this, "var_declarator", [{"nt":"var_declarator_id"}] ) }
	|
		var_declarator_id 'op_assign' var_init 
		function() { this.push( this, "var_declarator", [{"nt":"var_declarator_id"},"op_assign",{"nt":"var_init"}] ) }
	;


var_declarator_id=
		var_declarator_id 'brackets_start' 'brackets_end' 
		function() { this.push( this, "var_declarator_id", [{"nt":"var_declarator_id"},"brackets_start","brackets_end"] ) }
	|
		'identifier' 
		function() { this.push( this, "var_declarator_id", ["identifier"] ) }
	;


var_init=
		'identifier' 
		function() { this.push( this, "var_init", ["identifier"] ) }
	|
		array_init 
		function() { this.push( this, "var_init", [{"nt":"array_init"}] ) }
	;


method_decr=
		'public' method_declarator 'colon' result_type method_body 
		function() { this.push( this, "method_decr", ["public",{"nt":"method_declarator"},"colon",{"nt":"result_type"},{"nt":"method_body"}] ) }
	|
		method_declarator 'colon' result_type method_body 
		function() { this.push( this, "method_decr", [{"nt":"method_declarator"},"colon",{"nt":"result_type"},{"nt":"method_body"}] ) }
	;


result_type=
		type 
		function() { this.push( this, "result_type", [{"nt":"type"}] ) }
	|
		'void' 
		function() { this.push( this, "result_type", ["void"] ) }
	;


method_declarator=
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		function() { this.push( this, "method_declarator", ["identifier","paranthesis_start",{"nt":"formal_parameter_list"},"paranthesis_end"] ) }
	;


method_body=
		block 
		function() { this.push( this, "method_body", [{"nt":"block"}] ) }
	;


array_init=
		'set_start' var_inits 'separator' 'set_end' 
		function() { this.push( this, "array_init", ["set_start",{"nt":"var_inits"},"separator","set_end"] ) }
	|
		'set_start' var_inits 'set_end' 
		function() { this.push( this, "array_init", ["set_start",{"nt":"var_inits"},"set_end"] ) }
	|
		'set_start' 'separator' 'set_end' 
		function() { this.push( this, "array_init", ["set_start","separator","set_end"] ) }
	|
		'set_start' 'set_end' 
		function() { this.push( this, "array_init", ["set_start","set_end"] ) }
	;


var_inits=
		var_inits 'separator' var_init 
		function() { this.push( this, "var_inits", [{"nt":"var_inits"},"separator",{"nt":"var_init"}] ) }
	|
		var_init 
		function() { this.push( this, "var_inits", [{"nt":"var_init"}] ) }
	;


type=
		primitive_type 
		function() { this.push( this, "type", [{"nt":"primitive_type"}] ) }
	|
		reference_type 
		function() { this.push( this, "type", [{"nt":"reference_type"}] ) }
	;


primitive_type=
		integral_type 
		function() { this.push( this, "primitive_type", [{"nt":"integral_type"}] ) }
	|
		floating_type 
		function() { this.push( this, "primitive_type", [{"nt":"floating_type"}] ) }
	|
		'boolean' 
		function() { this.push( this, "primitive_type", ["boolean"] ) }
	;


integral_type=
		'byte' 
		function() { this.push( this, "integral_type", ["byte"] ) }
	|
		'short' 
		function() { this.push( this, "integral_type", ["short"] ) }
	|
		'int' 
		function() { this.push( this, "integral_type", ["int"] ) }
	|
		'long' 
		function() { this.push( this, "integral_type", ["long"] ) }
	|
		'char' 
		function() { this.push( this, "integral_type", ["char"] ) }
	;


floating_type=
		'float' 
		function() { this.push( this, "floating_type", ["float"] ) }
	|
		'double' 
		function() { this.push( this, "floating_type", ["double"] ) }
	;


reference_type=
		'identifier' 
		function() { this.push( this, "reference_type", ["identifier"] ) }
	|
		type 'brackets_start' 'brackets_end' 
		function() { this.push( this, "reference_type", [{"nt":"type"},"brackets_start","brackets_end"] ) }
	;


block=
		'set_start' block_stmts 'set_end' 
		function() { this.push( this, "block", ["set_start",{"nt":"block_stmts"},"set_end"] ) }
	|
		'set_start' 'set_end' 
		function() { this.push( this, "block", ["set_start","set_end"] ) }
	;


block_stmts=
		block_stmts block_stmt 
		function() { this.push( this, "block_stmts", [{"nt":"block_stmts"},{"nt":"block_stmt"}] ) }
	|
		block_stmt 
		function() { this.push( this, "block_stmts", [{"nt":"block_stmt"}] ) }
	;


block_stmt=
		type var_declarators 'terminator' 
		function() { this.push( this, "block_stmt", [{"nt":"type"},{"nt":"var_declarators"},"terminator"] ) }
	|
		stmt 
		function() { this.push( this, "block_stmt", [{"nt":"stmt"}] ) }
	;


stmt=
		stmt_wots 
		function() { this.push( this, "stmt", [{"nt":"stmt_wots"}] ) }
	;


stmt_nsi=
		stmt_wots 
		function() { this.push( this, "stmt_nsi", [{"nt":"stmt_wots"}] ) }
	;


stmt_wots=
		block 
		function() { this.push( this, "stmt_wots", [{"nt":"block"}] ) }
	|
		stmt_expr 'terminator' 
		function() { this.push( this, "stmt_wots", [{"nt":"stmt_expr"},"terminator"] ) }
	|
		'terminator' 
		function() { this.push( this, "stmt_wots", ["terminator"] ) }
	;


stmt_expr=
		assignment 
		function() { this.push( this, "stmt_expr", [{"nt":"assignment"}] ) }
	|
		preinc_expr 
		function() { this.push( this, "stmt_expr", [{"nt":"preinc_expr"}] ) }
	|
		'identifier' 
		function() { this.push( this, "stmt_expr", ["identifier"] ) }
	;


expr=
		'identifier' 
		function() { this.push( this, "expr", ["identifier"] ) }
	|
		assignment 
		function() { this.push( this, "expr", [{"nt":"assignment"}] ) }
	;


assignment=
		left_hand_side assignment_operator expr 
		function() { this.push( this, "assignment", [{"nt":"left_hand_side"},{"nt":"assignment_operator"},{"nt":"expr"}] ) }
	;


left_hand_side=
		expr_name 
		function() { this.push( this, "left_hand_side", [{"nt":"expr_name"}] ) }
	;


assignment_operator=
		'op_assign' 
		function() { this.push( this, "assignment_operator", ["op_assign"] ) }
	|
		'op_mulAssign' 
		function() { this.push( this, "assignment_operator", ["op_mulAssign"] ) }
	|
		'op_divAssign' 
		function() { this.push( this, "assignment_operator", ["op_divAssign"] ) }
	|
		'op_modAssign' 
		function() { this.push( this, "assignment_operator", ["op_modAssign"] ) }
	|
		'op_addAssign' 
		function() { this.push( this, "assignment_operator", ["op_addAssign"] ) }
	|
		'op_subAssign' 
		function() { this.push( this, "assignment_operator", ["op_subAssign"] ) }
	|
		'op_LshiftEqual' 
		function() { this.push( this, "assignment_operator", ["op_LshiftEqual"] ) }
	|
		'op_RshiftEqual' 
		function() { this.push( this, "assignment_operator", ["op_RshiftEqual"] ) }
	|
		'op_andAssign' 
		function() { this.push( this, "assignment_operator", ["op_andAssign"] ) }
	|
		'op_orAssign' 
		function() { this.push( this, "assignment_operator", ["op_orAssign"] ) }
	|
		'op_xorAssign' 
		function() { this.push( this, "assignment_operator", ["op_xorAssign"] ) }
	;


predec_expr=
		'op_decrement' unary_expr 
		function() { this.push( this, "predec_expr", ["op_decrement",{"nt":"unary_expr"}] ) }
	;


preinc_expr=
		'op_increment' unary_expr 
		function() { this.push( this, "preinc_expr", ["op_increment",{"nt":"unary_expr"}] ) }
	;


unary_expr=
		preinc_expr 
		function() { this.push( this, "unary_expr", [{"nt":"preinc_expr"}] ) }
	|
		predec_expr 
		function() { this.push( this, "unary_expr", [{"nt":"predec_expr"}] ) }
	|
		'op_add' unary_expr 
		function() { this.push( this, "unary_expr", ["op_add",{"nt":"unary_expr"}] ) }
	|
		'op_sub' unary_expr 
		function() { this.push( this, "unary_expr", ["op_sub",{"nt":"unary_expr"}] ) }
	|
		unary_expr_npm 
		function() { this.push( this, "unary_expr", [{"nt":"unary_expr_npm"}] ) }
	;


unary_expr_npm=
		'identifier' 
		function() { this.push( this, "unary_expr_npm", ["identifier"] ) }
	;


expr_name=
		'identifier' 
		function() { this.push( this, "expr_name", ["identifier"] ) }
	|
		expr_name 'field_invoker' 'identifier' 
		function() { this.push( this, "expr_name", [{"nt":"expr_name"},"field_invoker","identifier"] ) }
	;


literal=
		'integer_literal' 
		function() { this.push( this, "literal", ["integer_literal"] ) }
	|
		signed_integer_literal 
		function() { this.push( this, "literal", [{"nt":"signed_integer_literal"}] ) }
	|
		'float_literal' 
		function() { this.push( this, "literal", ["float_literal"] ) }
	|
		signed_float_literal 
		function() { this.push( this, "literal", [{"nt":"signed_float_literal"}] ) }
	|
		'boolean_literal' 
		function() { this.push( this, "literal", ["boolean_literal"] ) }
	|
		'character_literal' 
		function() { this.push( this, "literal", ["character_literal"] ) }
	|
		'string_literal' 
		function() { this.push( this, "literal", ["string_literal"] ) }
	|
		'null_literal' 
		function() { this.push( this, "literal", ["null_literal"] ) }
	;


sign=
		'op_add' 
		function() { this.push( this, "sign", ["op_add"] ) }
	|
		'op_sub' 
		function() { this.push( this, "sign", ["op_sub"] ) }
	;


signed_integer_literal=
		sign 'integer_literal' 
		function() { this.push( this, "signed_integer_literal", [{"nt":"sign"},"integer_literal"] ) }
	;


signed_float_literal=
		sign 'float_literal' 
		function() { this.push( this, "signed_float_literal", [{"nt":"sign"},"float_literal"] ) }
	;


