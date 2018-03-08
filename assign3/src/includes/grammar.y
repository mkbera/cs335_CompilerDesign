%moduleName MyParser
%mode LR1


program=
		[import_decrs] [type_decrs] 
		function() { this.push( this, "program", [{"nt":"import_decrs","optional":true},{"nt":"type_decrs","optional":true}] ) }
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
		type_decr 
		function() { this.push( this, "type_decrs", [{"nt":"type_decr"}] ) }
	|
		type_decrs type_decr 
		function() { this.push( this, "type_decrs", [{"nt":"type_decrs"},{"nt":"type_decr"}] ) }
	;


type_decr=
		class_decr 
		function() { this.push( this, "type_decr", [{"nt":"class_decr"}] ) }
	|
		'terminator' 
		function() { this.push( this, "type_decr", ["terminator"] ) }
	;


class_decr=
		[class_modifier] 'class' 'identifier' [super_nt] class_body 
		function() { this.push( this, "class_decr", [{"nt":"class_modifier","optional":true},"class","identifier",{"nt":"super_nt","optional":true},{"nt":"class_body"}] ) }
	;


class_modifier=
		'public' 
		function() { this.push( this, "class_modifier", ["public"] ) }
	;


super_nt=
		'extends' class_type 
		function() { this.push( this, "super_nt", ["extends",{"nt":"class_type"}] ) }
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
		[consr_modifier] consr_declarator consr_body 
		function() { this.push( this, "class_body_decr", [{"nt":"consr_modifier","optional":true},{"nt":"consr_declarator"},{"nt":"consr_body"}] ) }
	;


class_member_decr=
		field_decr 
		function() { this.push( this, "class_member_decr", [{"nt":"field_decr"}] ) }
	|
		method_decr 
		function() { this.push( this, "class_member_decr", [{"nt":"method_decr"}] ) }
	;


consr_modifier=
		'public' 
		function() { this.push( this, "consr_modifier", ["public"] ) }
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
	;


formal_parameter=
		type var_declarator_id 
		function() { this.push( this, "formal_parameter", [{"nt":"type"},{"nt":"var_declarator_id"}] ) }
	;


consr_body=
		'set_start' [explicit_consr_invocation] [block_stmts] 'set_end' 
		function() { this.push( this, "consr_body", ["set_start",{"nt":"explicit_consr_invocation","optional":true},{"nt":"block_stmts","optional":true},"set_end"] ) }
	;


explicit_consr_invocation=
		'this' 'paranthesis_start' [argument_list] 'paranthesis_end' 
		function() { this.push( this, "explicit_consr_invocation", ["this","paranthesis_start",{"nt":"argument_list","optional":true},"paranthesis_end"] ) }
	|
		'super' 'paranthesis_start' [argument_list] 'paranthesis_end' 
		function() { this.push( this, "explicit_consr_invocation", ["super","paranthesis_start",{"nt":"argument_list","optional":true},"paranthesis_end"] ) }
	;


field_decr=
		[field_modifier] type var_declarators 'terminator' 
		function() { this.push( this, "field_decr", [{"nt":"field_modifier","optional":true},{"nt":"type"},{"nt":"var_declarators"},"terminator"] ) }
	;


field_modifier=
		'public' 
		function() { this.push( this, "field_modifier", ["public"] ) }
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
		'identifier' 
		function() { this.push( this, "var_declarator_id", ["identifier"] ) }
	|
		var_declarator_id 'brackets_start' 'brackets_end' 
		function() { this.push( this, "var_declarator_id", [{"nt":"var_declarator_id"},"brackets_start","brackets_end"] ) }
	;


var_init=
		expr 
		function() { this.push( this, "var_init", [{"nt":"expr"}] ) }
	|
		array_init 
		function() { this.push( this, "var_init", [{"nt":"array_init"}] ) }
	;


method_decr=
		[method_modifier] result_type method_declarator method_body 
		function() { this.push( this, "method_decr", [{"nt":"method_modifier","optional":true},{"nt":"result_type"},{"nt":"method_declarator"},{"nt":"method_body"}] ) }
	;


method_modifier=
		'public' 
		function() { this.push( this, "method_modifier", ["public"] ) }
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
	|
		'terminator' 
		function() { this.push( this, "method_body", ["terminator"] ) }
	;


constant_decr=
		'public' type var_declarator 
		function() { this.push( this, "constant_decr", ["public",{"nt":"type"},{"nt":"var_declarator"}] ) }
	;


array_init=
		'set_start' [var_inits] [comma_nt] 'set_end' 
		function() { this.push( this, "array_init", ["set_start",{"nt":"var_inits","optional":true},{"nt":"comma_nt","optional":true},"set_end"] ) }
	;


comma_nt=
		'seperator' 
		function() { this.push( this, "comma_nt", ["seperator"] ) }
	;


var_inits=
		var_inits 'seperator' var_init 
		function() { this.push( this, "var_inits", [{"nt":"var_inits"},"seperator",{"nt":"var_init"}] ) }
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
		class_type 
		function() { this.push( this, "reference_type", [{"nt":"class_type"}] ) }
	|
		type 'brackets_start' 'brackets_end' 
		function() { this.push( this, "reference_type", [{"nt":"type"},"brackets_start","brackets_end"] ) }
	;


class_type=
		'identifier' 
		function() { this.push( this, "class_type", ["identifier"] ) }
	;


block=
		'set_start' [block_stmts] 'set_end' 
		function() { this.push( this, "block", ["set_start",{"nt":"block_stmts","optional":true},"set_end"] ) }
	;


block_stmts=
		block_stmts block_stmt 
		function() { this.push( this, "block_stmts", [{"nt":"block_stmts"},{"nt":"block_stmt"}] ) }
	|
		block_stmt 
		function() { this.push( this, "block_stmts", [{"nt":"block_stmt"}] ) }
	;


block_stmt=
		type var_declarators 
		function() { this.push( this, "block_stmt", [{"nt":"type"},{"nt":"var_declarators"}] ) }
	|
		stmt 
		function() { this.push( this, "block_stmt", [{"nt":"stmt"}] ) }
	;


stmt=
		stmt_wots 
		function() { this.push( this, "stmt", [{"nt":"stmt_wots"}] ) }
	|
		if_then_stmt 
		function() { this.push( this, "stmt", [{"nt":"if_then_stmt"}] ) }
	|
		if_then_else_stmt 
		function() { this.push( this, "stmt", [{"nt":"if_then_else_stmt"}] ) }
	|
		while_stmt 
		function() { this.push( this, "stmt", [{"nt":"while_stmt"}] ) }
	|
		for_stmt 
		function() { this.push( this, "stmt", [{"nt":"for_stmt"}] ) }
	;


stmt_no_short_if=
		stmt_wots 
		function() { this.push( this, "stmt_no_short_if", [{"nt":"stmt_wots"}] ) }
	|
		if_then_stmt_nsi 
		function() { this.push( this, "stmt_no_short_if", [{"nt":"if_then_stmt_nsi"}] ) }
	|
		if_then_else_stmt_nsi 
		function() { this.push( this, "stmt_no_short_if", [{"nt":"if_then_else_stmt_nsi"}] ) }
	|
		while_stmt_nsi 
		function() { this.push( this, "stmt_no_short_if", [{"nt":"while_stmt_nsi"}] ) }
	|
		for_stmt_nsi 
		function() { this.push( this, "stmt_no_short_if", [{"nt":"for_stmt_nsi"}] ) }
	;


stmt_wots=
		block 
		function() { this.push( this, "stmt_wots", [{"nt":"block"}] ) }
	|
		switch_stmt 
		function() { this.push( this, "stmt_wots", [{"nt":"switch_stmt"}] ) }
	|
		do_stmt 
		function() { this.push( this, "stmt_wots", [{"nt":"do_stmt"}] ) }
	|
		break_stmt 
		function() { this.push( this, "stmt_wots", [{"nt":"break_stmt"}] ) }
	|
		continue_stmt 
		function() { this.push( this, "stmt_wots", [{"nt":"continue_stmt"}] ) }
	|
		return_stmt 
		function() { this.push( this, "stmt_wots", [{"nt":"return_stmt"}] ) }
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
		postinc_expr 
		function() { this.push( this, "stmt_expr", [{"nt":"postinc_expr"}] ) }
	|
		predec_expr 
		function() { this.push( this, "stmt_expr", [{"nt":"predec_expr"}] ) }
	|
		postdec_expr 
		function() { this.push( this, "stmt_expr", [{"nt":"postdec_expr"}] ) }
	|
		method_invocation 
		function() { this.push( this, "stmt_expr", [{"nt":"method_invocation"}] ) }
	|
		class_instance_creation_expr 
		function() { this.push( this, "stmt_expr", [{"nt":"class_instance_creation_expr"}] ) }
	;


if_then_stmt=
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt 
		function() { this.push( this, "if_then_stmt", ["if","paranthesis_start",{"nt":"expr"},"paranthesis_end",{"nt":"stmt"}] ) }
	;


if_then_else_stmt=
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 'else' stmt 
		function() { this.push( this, "if_then_else_stmt", ["if","paranthesis_start",{"nt":"expr"},"paranthesis_end",{"nt":"stmt_nsi"},"else",{"nt":"stmt"}] ) }
	;


if_then_else_stmt_nsi=
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 'else' stmt_nsi 
		function() { this.push( this, "if_then_else_stmt_nsi", ["if","paranthesis_start",{"nt":"expr"},"paranthesis_end",{"nt":"stmt_nsi"},"else",{"nt":"stmt_nsi"}] ) }
	;


switch_stmt=
		'switch' 'paranthesis_start' expr 'paranthesis_end' switch_block 
		function() { this.push( this, "switch_stmt", ["switch","paranthesis_start",{"nt":"expr"},"paranthesis_end",{"nt":"switch_block"}] ) }
	;


switch_block=
		'set_start' [switch_block_stmt_groups] [switch_labels] 'set_end' 
		function() { this.push( this, "switch_block", ["set_start",{"nt":"switch_block_stmt_groups","optional":true},{"nt":"switch_labels","optional":true},"set_end"] ) }
	;


switch_block_stmt_groups=
		switch_block_stmt_groups switch_block_stmt_group 
		function() { this.push( this, "switch_block_stmt_groups", [{"nt":"switch_block_stmt_groups"},{"nt":"switch_block_stmt_group"}] ) }
	|
		switch_block_stmt_group 
		function() { this.push( this, "switch_block_stmt_groups", [{"nt":"switch_block_stmt_group"}] ) }
	;


switch_block_stmt_group=
		switch_labels block_stmts 
		function() { this.push( this, "switch_block_stmt_group", [{"nt":"switch_labels"},{"nt":"block_stmts"}] ) }
	;


switch_labels=
		switch_labels switch_label 
		function() { this.push( this, "switch_labels", [{"nt":"switch_labels"},{"nt":"switch_label"}] ) }
	|
		switch_label 
		function() { this.push( this, "switch_labels", [{"nt":"switch_label"}] ) }
	;


switch_label=
		'case' constant_expr 'colon' 
		function() { this.push( this, "switch_label", ["case",{"nt":"constant_expr"},"colon"] ) }
	|
		'default' 'colon' 
		function() { this.push( this, "switch_label", ["default","colon"] ) }
	;


while_stmt=
		'while' 'paranthesis_start' expr 'paranthesis_end' stmt 
		function() { this.push( this, "while_stmt", ["while","paranthesis_start",{"nt":"expr"},"paranthesis_end",{"nt":"stmt"}] ) }
	;


while_stmt_nsi=
		'while' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 
		function() { this.push( this, "while_stmt_nsi", ["while","paranthesis_start",{"nt":"expr"},"paranthesis_end",{"nt":"stmt_nsi"}] ) }
	;


do_stmt=
		'do' stmt 'while' 'paranthesis_start' expr 'paranthesis_end' 'terminator' 
		function() { this.push( this, "do_stmt", ["do",{"nt":"stmt"},"while","paranthesis_start",{"nt":"expr"},"paranthesis_end","terminator"] ) }
	;


for_stmt=
		'for' 'paranthesis_start' [for_init] 'terminator' [expr] 'terminator' [stmt_expr_list] 'paranthesis_end' stmt 
		function() { this.push( this, "for_stmt", ["for","paranthesis_start",{"nt":"for_init","optional":true},"terminator",{"nt":"expr","optional":true},"terminator",{"nt":"stmt_expr_list","optional":true},"paranthesis_end",{"nt":"stmt"}] ) }
	;


for_stmt_nsi=
		'for' 'paranthesis_start' [for_init] 'terminator' [expr] 'terminator' [stmt_expr_list] 'paranthesis_end' stmt_nsi 
		function() { this.push( this, "for_stmt_nsi", ["for","paranthesis_start",{"nt":"for_init","optional":true},"terminator",{"nt":"expr","optional":true},"terminator",{"nt":"stmt_expr_list","optional":true},"paranthesis_end",{"nt":"stmt_nsi"}] ) }
	;


for_init=
		stmt_expr_list 
		function() { this.push( this, "for_init", [{"nt":"stmt_expr_list"}] ) }
	|
		type var_declarators 
		function() { this.push( this, "for_init", [{"nt":"type"},{"nt":"var_declarators"}] ) }
	;


stmt_expr_list=
		stmt_expr_list 'separator' stmt_expr 
		function() { this.push( this, "stmt_expr_list", [{"nt":"stmt_expr_list"},"separator",{"nt":"stmt_expr"}] ) }
	|
		stmt_expr 
		function() { this.push( this, "stmt_expr_list", [{"nt":"stmt_expr"}] ) }
	;


break_stmt=
		'break' 'terminator' 
		function() { this.push( this, "break_stmt", ["break","terminator"] ) }
	;


continue_stmt=
		'continue' 'terminator' 
		function() { this.push( this, "continue_stmt", ["continue","terminator"] ) }
	;


return_stmt=
		'return' [expr] 'terminator' 
		function() { this.push( this, "return_stmt", ["return",{"nt":"expr","optional":true},"terminator"] ) }
	;


expr=
		cond_expr 
		function() { this.push( this, "expr", [{"nt":"cond_expr"}] ) }
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
	|
		field_access 
		function() { this.push( this, "left_hand_side", [{"nt":"field_access"}] ) }
	|
		array_access 
		function() { this.push( this, "left_hand_side", [{"nt":"array_access"}] ) }
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


cond_expr=
		cond_or_expr 
		function() { this.push( this, "cond_expr", [{"nt":"cond_or_expr"}] ) }
	|
		[cond_or_expr] expr 'colon' cond_expr 
		function() { this.push( this, "cond_expr", [{"nt":"cond_or_expr","optional":true},{"nt":"expr"},"colon",{"nt":"cond_expr"}] ) }
	;


cond_or_expr=
		cond_and_expr 
		function() { this.push( this, "cond_or_expr", [{"nt":"cond_and_expr"}] ) }
	|
		cond_or_expr 'op_oror' cond_and_expr 
		function() { this.push( this, "cond_or_expr", [{"nt":"cond_or_expr"},"op_oror",{"nt":"cond_and_expr"}] ) }
	;


cond_and_expr=
		incl_or_expr 
		function() { this.push( this, "cond_and_expr", [{"nt":"incl_or_expr"}] ) }
	|
		cond_and_expr 'op_andand' incl_or_expr 
		function() { this.push( this, "cond_and_expr", [{"nt":"cond_and_expr"},"op_andand",{"nt":"incl_or_expr"}] ) }
	;


incl_or_expr=
		excl_or_expr 
		function() { this.push( this, "incl_or_expr", [{"nt":"excl_or_expr"}] ) }
	|
		incl_or_expr 'op_or' excl_or_expr 
		function() { this.push( this, "incl_or_expr", [{"nt":"incl_or_expr"},"op_or",{"nt":"excl_or_expr"}] ) }
	;


excl_or_expr=
		and_expr 
		function() { this.push( this, "excl_or_expr", [{"nt":"and_expr"}] ) }
	|
		excl_or_expr 'op_xor' and_expr 
		function() { this.push( this, "excl_or_expr", [{"nt":"excl_or_expr"},"op_xor",{"nt":"and_expr"}] ) }
	;


and_expr=
		equality_expr 
		function() { this.push( this, "and_expr", [{"nt":"equality_expr"}] ) }
	|
		and_expr 'op_and' equality_expr 
		function() { this.push( this, "and_expr", [{"nt":"and_expr"},"op_and",{"nt":"equality_expr"}] ) }
	;


equality_expr=
		relational_expr 
		function() { this.push( this, "equality_expr", [{"nt":"relational_expr"}] ) }
	|
		equality_expr 'op_equalCompare' relational_expr 
		function() { this.push( this, "equality_expr", [{"nt":"equality_expr"},"op_equalCompare",{"nt":"relational_expr"}] ) }
	|
		equality_expr 'op_notequalCompare' relational_expr 
		function() { this.push( this, "equality_expr", [{"nt":"equality_expr"},"op_notequalCompare",{"nt":"relational_expr"}] ) }
	;


relational_expr=
		shit_expr 
		function() { this.push( this, "relational_expr", [{"nt":"shit_expr"}] ) }
	|
		relational_expr 'op_greater' shift_expr 
		function() { this.push( this, "relational_expr", [{"nt":"relational_expr"},"op_greater",{"nt":"shift_expr"}] ) }
	|
		relational_expr 'op_greaterEqual' shift_expr 
		function() { this.push( this, "relational_expr", [{"nt":"relational_expr"},"op_greaterEqual",{"nt":"shift_expr"}] ) }
	|
		relational_expr 'op_less' shift_expr 
		function() { this.push( this, "relational_expr", [{"nt":"relational_expr"},"op_less",{"nt":"shift_expr"}] ) }
	|
		relational_expr 'op_lessEqual' shift_expr 
		function() { this.push( this, "relational_expr", [{"nt":"relational_expr"},"op_lessEqual",{"nt":"shift_expr"}] ) }
	|
		relational_expr 'instanceof' shift_expr 
		function() { this.push( this, "relational_expr", [{"nt":"relational_expr"},"instanceof",{"nt":"shift_expr"}] ) }
	;


shift_expr=
		additive_expr 
		function() { this.push( this, "shift_expr", [{"nt":"additive_expr"}] ) }
	|
		shift_expr 'op_Lshift' additive_expr 
		function() { this.push( this, "shift_expr", [{"nt":"shift_expr"},"op_Lshift",{"nt":"additive_expr"}] ) }
	|
		shift_expr 'op_Rshift' additive_expr 
		function() { this.push( this, "shift_expr", [{"nt":"shift_expr"},"op_Rshift",{"nt":"additive_expr"}] ) }
	;


additive_expr=
		multiplicative_expr 
		function() { this.push( this, "additive_expr", [{"nt":"multiplicative_expr"}] ) }
	|
		additive_expr 'op_add' multiplicative_expr 
		function() { this.push( this, "additive_expr", [{"nt":"additive_expr"},"op_add",{"nt":"multiplicative_expr"}] ) }
	|
		additive_expr 'op_sub' multiplicative_expr 
		function() { this.push( this, "additive_expr", [{"nt":"additive_expr"},"op_sub",{"nt":"multiplicative_expr"}] ) }
	;


multiplicative_expr=
		unary_expr 
		function() { this.push( this, "multiplicative_expr", [{"nt":"unary_expr"}] ) }
	|
		multiplicative_expr 'op_mul' unary_expr 
		function() { this.push( this, "multiplicative_expr", [{"nt":"multiplicative_expr"},"op_mul",{"nt":"unary_expr"}] ) }
	|
		multiplicative_expr 'op_div' unary_expr 
		function() { this.push( this, "multiplicative_expr", [{"nt":"multiplicative_expr"},"op_div",{"nt":"unary_expr"}] ) }
	|
		multiplicative_expr 'op_mod' unary_expr 
		function() { this.push( this, "multiplicative_expr", [{"nt":"multiplicative_expr"},"op_mod",{"nt":"unary_expr"}] ) }
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


predec_expr=
		'op_decrement' unary_expr 
		function() { this.push( this, "predec_expr", ["op_decrement",{"nt":"unary_expr"}] ) }
	;


preinc_expr=
		'op_increment' unary_expr 
		function() { this.push( this, "preinc_expr", ["op_increment",{"nt":"unary_expr"}] ) }
	;


unary_expr_npm=
		postif_expr 
		function() { this.push( this, "unary_expr_npm", [{"nt":"postif_expr"}] ) }
	|
		'op_not' unary_expr 
		function() { this.push( this, "unary_expr_npm", ["op_not",{"nt":"unary_expr"}] ) }
	|
		cast_expr 
		function() { this.push( this, "unary_expr_npm", [{"nt":"cast_expr"}] ) }
	;


cast_expr=
		'paranthesis_start' primitive_type 'paranthesis_end' unary_expr 
		function() { this.push( this, "cast_expr", ["paranthesis_start",{"nt":"primitive_type"},"paranthesis_end",{"nt":"unary_expr"}] ) }
	|
		'paranthesis_start' primitive_type 'paranthesis_end' unary_expr_npm 
		function() { this.push( this, "cast_expr", ["paranthesis_start",{"nt":"primitive_type"},"paranthesis_end",{"nt":"unary_expr_npm"}] ) }
	;


postdec_expr=
		postfix_expr 'op_decrement' 
		function() { this.push( this, "postdec_expr", [{"nt":"postfix_expr"},"op_decrement"] ) }
	;


postinc_expr=
		postfix_expr 'op_increment' 
		function() { this.push( this, "postinc_expr", [{"nt":"postfix_expr"},"op_increment"] ) }
	;


postfix_expr=
		primary 
		function() { this.push( this, "postfix_expr", [{"nt":"primary"}] ) }
	|
		expr_name 
		function() { this.push( this, "postfix_expr", [{"nt":"expr_name"}] ) }
	|
		postinc_expr 
		function() { this.push( this, "postfix_expr", [{"nt":"postinc_expr"}] ) }
	|
		postdec_expr 
		function() { this.push( this, "postfix_expr", [{"nt":"postdec_expr"}] ) }
	;


method_invocation=
		expr_name 'paranthesis_start' [argument_list] 'paranthesis_end' 
		function() { this.push( this, "method_invocation", [{"nt":"expr_name"},"paranthesis_start",{"nt":"argument_list","optional":true},"paranthesis_end"] ) }
	|
		primary 'field_invoker' 'identifier' 'paranthesis_start' [argument_list] 'paranthesis_end' 
		function() { this.push( this, "method_invocation", [{"nt":"primary"},"field_invoker","identifier","paranthesis_start",{"nt":"argument_list","optional":true},"paranthesis_end"] ) }
	|
		'super' 'field_invoker' 'identifier' 'paranthesis_start' [argument_list] 'paranthesis_end' 
		function() { this.push( this, "method_invocation", ["super","field_invoker","identifier","paranthesis_start",{"nt":"argument_list","optional":true},"paranthesis_end"] ) }
	;


field_access=
		primary 'field_invoker' 'identifier' 
		function() { this.push( this, "field_access", [{"nt":"primary"},"field_invoker","identifier"] ) }
	|
		'super' 'field_invoker' 'identifier' 
		function() { this.push( this, "field_access", ["super","field_invoker","identifier"] ) }
	;


primary=
		primary_no_new_array 
		function() { this.push( this, "primary", [{"nt":"primary_no_new_array"}] ) }
	|
		array_creation_expr 
		function() { this.push( this, "primary", [{"nt":"array_creation_expr"}] ) }
	;


primary_no_new_array=
		literal 
		function() { this.push( this, "primary_no_new_array", [{"nt":"literal"}] ) }
	|
		'this' 
		function() { this.push( this, "primary_no_new_array", ["this"] ) }
	|
		'paranthesis_start' expr 'paranthesis_end' 
		function() { this.push( this, "primary_no_new_array", ["paranthesis_start",{"nt":"expr"},"paranthesis_end"] ) }
	|
		class_instance_creation_expr 
		function() { this.push( this, "primary_no_new_array", [{"nt":"class_instance_creation_expr"}] ) }
	|
		field_access 
		function() { this.push( this, "primary_no_new_array", [{"nt":"field_access"}] ) }
	|
		array_access 
		function() { this.push( this, "primary_no_new_array", [{"nt":"array_access"}] ) }
	|
		method_invocation 
		function() { this.push( this, "primary_no_new_array", [{"nt":"method_invocation"}] ) }
	;


class_instance_creation_expr=
		'new' class_type 'paranthesis_start' [argument_list] 'paranthesis_end' 
		function() { this.push( this, "class_instance_creation_expr", ["new",{"nt":"class_type"},"paranthesis_start",{"nt":"argument_list","optional":true},"paranthesis_end"] ) }
	;


argument_list=
		expr 
		function() { this.push( this, "argument_list", [{"nt":"expr"}] ) }
	|
		argument_list 'separator' expr 
		function() { this.push( this, "argument_list", [{"nt":"argument_list"},"separator",{"nt":"expr"}] ) }
	;


array_creation_expr=
		expr 
		function() { this.push( this, "array_creation_expr", [{"nt":"expr"}] ) }
	|
		'new' primitive_type dim_exprs [dims] 
		function() { this.push( this, "array_creation_expr", ["new",{"nt":"primitive_type"},{"nt":"dim_exprs"},{"nt":"dims","optional":true}] ) }
	|
		'new' class_type dim_exprs [dims] 
		function() { this.push( this, "array_creation_expr", ["new",{"nt":"class_type"},{"nt":"dim_exprs"},{"nt":"dims","optional":true}] ) }
	;


dim_exprs=
		dim_exprs dim_expr 
		function() { this.push( this, "dim_exprs", [{"nt":"dim_exprs"},{"nt":"dim_expr"}] ) }
	|
		dim_expr 
		function() { this.push( this, "dim_exprs", [{"nt":"dim_expr"}] ) }
	;


dim_expr=
		'brackets_start' expr 'brackets_end' 
		function() { this.push( this, "dim_expr", ["brackets_start",{"nt":"expr"},"brackets_end"] ) }
	;


dims=
		'brackets_start' 'brackets_end' 
		function() { this.push( this, "dims", ["brackets_start","brackets_end"] ) }
	|
		dims 'brackets_start' 'brackets_end' 
		function() { this.push( this, "dims", [{"nt":"dims"},"brackets_start","brackets_end"] ) }
	;


array_access=
		expr_name 'brackets_start' expr 'brackets_end' 
		function() { this.push( this, "array_access", [{"nt":"expr_name"},"brackets_start",{"nt":"expr"},"brackets_end"] ) }
	|
		primary_no_new_array 'brackets_start' expr 'brackets_end' 
		function() { this.push( this, "array_access", [{"nt":"primary_no_new_array"},"brackets_start",{"nt":"expr"},"brackets_end"] ) }
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
