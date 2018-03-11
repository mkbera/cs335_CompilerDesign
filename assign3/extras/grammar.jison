/* lexical grammar */
%lex

%%
\s+

/* ----------------------------------- KEYWORDS ----------------------------------- */

"boolean"		return 'boolean';
		
"break"		    return 'break';
		
"byte"		    return 'byte';
		
"case"  		return 'case';
		
"char"	    	return 'char';
    
"class" 		return 'class';

"const"	    	return 'const';

"continue"	   	return 'continue';

"default"		return 'default';

"do"		    return 'do';

"double"		return 'double';

"else"		    return 'else';

"extends"		return 'extends';

"float"		    return 'float';

"for"   		return 'for';

"if"    		return 'if';

"import"    	return 'import';

"instanceof"	return 'instanceof';

"int"   		return 'int';

"long"  		return 'long';

"new"   		return 'new';

"public"		return 'public';

"return"   		return 'return';

"short" 		return 'short';

"static"		return 'static';

"super" 		return 'super';

"switch"		return 'switch';

"this"  		return 'this';

"void"  		return 'void';

"while" 		return 'while';
		




/* ------------------------------------ TOKENS ------------------------------------ */

[+][+]			return 'op_increment';

[-][-]			return 'op_decrement';
		
[+]				return 'op_add';

[-]				return 'op_sub';

[*]				return 'op_mul';

[/]				return 'op_div';

[%]				return 'op_mod';
		
[+][=]			return 'op_addAssign';

[-][=]			return 'op_subAssign';

[*][=]			return 'op_mulAssign';

[/][=]			return 'op_divAssign';

[%][=]			return 'op_modAssign';
		
[&][=]			return 'op_andAssign';
		
[|][=]			return 'op_orAssign';
		
[\^][=]			return 'op_xorAssign';
		
[!][=]			return 'op_notequalCompare';
		
[=][=]			return 'op_equalCompare';
		
[<][<][=]		return 'op_LshiftEqual';
		
[>][>][=]		return 'op_RshiftEqual';
		
[>][=]			return 'op_greaterEqual';

[<][=]			return 'op_lessEqual';

[<][<]			return 'op_Lshift';

[>][>]			return 'op_Rshift';
		
[>]				return 'op_greater';
				
[<]				return 'op_less';
				
[=]				return 'op_assign';
		
[&][&]			return 'op_andand';

[|][|]			return 'op_oror';
		
[&]				return 'op_and';

[|]				return 'op_or';

[!]				return 'op_not';
		
[\^]			return 'op_xor';
		
[:] 			return 'colon';
		




/* ------------------------------------ TOKENS ------------------------------------ */

[0-9]+\.[0-9]*				return 'float_literal';
	
[0-9]+						return 'integer_literal';
		
"true"						return 'boolean_literal';
		
"false"						return 'boolean_literal';

"null"						return 'null_literal';
		
\'(\\.|[^\\\'])*\'			return 'string_literal';
		
\'(\\.|[^\\\'])\'			return 'character_literal';
		
([a-z]|[A-Z]|[$]|[_])(\w)*	return 'identifier';
		
[;]							return 'terminator';
		
\[.]						return 'field_invoker';
		
[,]							return 'separator';

[(]           				return 'paranthesis_start';
		
[)]           				return 'paranthesis_end';
		
[\[]          				return 'brackets_start';
		
[\]]          				return 'brackets_end';
		
[{}]          				return 'set_start';
		
[}]		    				return 'set_end';
		
			/* Comments */

\/\/.*						return 'comment';
		
\/\*						return 'blockcomment_start';
		
\*\/    					return 'blockcomment_end';
		
(\n|\r|.)					return '';		


        /* OTHERS */

[$]                         return 'EOF';



/lex


%start program

%% /* language grammar */

%moduleName MyParser
%mode LR1


program:
		import_decrs type_decrs 
		
	|
		type_decrs 
		
	|
		import_decrs 
		
	|
		
		
	;


import_decrs:
		import_decr 
		
	|
		import_decrs import_decr 
		
	;


import_decr:
		'import' 'identifier' 'terminator' 
		
	;


type_decrs:
		type_decrs type_decr 
		
	|
		type_decr 
		
	;


type_decr:
		class_decr 
		
	|
		'terminator' 
		
	;


class_decr:
		'public' 'class' 'identifier' super_nt class_body 
		
	|
		'class' 'identifier' super_nt class_body 
		
	|
		'public' 'class' 'identifier' class_body 
		
	|
		'class' 'identifier' class_body 
		
	;


super_nt:
		'extends' 'identifier' 
		
	;


class_body:
		'set_start' class_body_decrs 'set_end' 
		
	;


class_body_decrs:
		class_body_decrs class_body_decr 
		
	|
		class_body_decr 
		
	;


class_body_decr:
		class_member_decr 
		
	|
		'public' consr_declarator consr_body 
		
	|
		consr_declarator consr_body 
		
	;


class_member_decr:
		field_decr 
		
	|
		method_decr 
		
	;


consr_declarator:
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		
	;


formal_parameter_list:
		formal_parameter_list 'separator' formal_parameter 
		
	|
		formal_parameter 
		
	|
		
		
	;


formal_parameter:
		type var_declarator_id 
		
	;


consr_body:
		'set_start' explicit_consr_invocation block_stmts 'set_end' 
		
	|
		'set_start' block_stmts 'set_end' 
		
	|
		'set_start' explicit_consr_invocation 'set_end' 
		
	|
		'set_start' 'set_end' 
		
	;


explicit_consr_invocation:
		'this' 'paranthesis_start' argument_list 'paranthesis_end' 
		
	|
		'super' 'paranthesis_start' argument_list 'paranthesis_end' 
		
	|
		'this' 'paranthesis_start' 'paranthesis_end' 
		
	|
		'super' 'paranthesis_start' 'paranthesis_end' 
		
	;


field_decr:
		'public' type var_declarators 'terminator' 
		
	|
		type var_declarators 'terminator' 
		
	;


var_declarators:
		var_declarators 'separator' var_declarator 
		
	|
		var_declarator 
		
	;


var_declarator:
		var_declarator_id 
		
	|
		var_declarator_id 'op_assign' var_init 
		
	;


var_declarator_id:
		var_declarator_id 'brackets_start' 'brackets_end' 
		
	|
		'identifier' 
		
	;


var_init:
		expr 
		
	|
		array_init 
		
	;


method_decr:
		'public' method_declarator 'colon' result_type method_body 
		
	|
		method_declarator 'colon' result_type method_body 
		
	;


result_type:
		type 
		
	|
		'void' 
		
	;


method_declarator:
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		
	;


method_body:
		block 
		
	;


array_init:
		'set_start' var_inits 'separator' 'set_end' 
		
	|
		'set_start' var_inits 'set_end' 
		
	|
		'set_start' 'separator' 'set_end' 
		
	|
		'set_start' 'set_end' 
		
	;


var_inits:
		var_inits 'separator' var_init 
		
	|
		var_init 
		
	;


type:
		primitive_type 
		
	|
		reference_type 
		
	;


primitive_type:
		integral_type 
		
	|
		floating_type 
		
	|
		'boolean' 
		
	;


integral_type:
		'byte' 
		
	|
		'short' 
		
	|
		'int' 
		
	|
		'long' 
		
	|
		'char' 
		
	;


floating_type:
		'float' 
		
	|
		'double' 
		
	;


reference_type:
		'identifier' 
		
	|
		type 'brackets_start' 'brackets_end' 
		
	;


block:
		'set_start' block_stmts 'set_end' 
		
	|
		'set_start' 'set_end' 
		
	;


block_stmts:
		block_stmts block_stmt 
		
	|
		block_stmt 
		
	;


block_stmt:
		type var_declarators 'terminator' 
		
	|
		stmt 
		
	;


stmt:
		stmt_wots 
		
	|
		if_then_stmt 
		
	|
		if_then_else_stmt 
		
	|
		while_stmt 
		
	|
		for_stmt 
		
	;


stmt_nsi:
		stmt_wots 
		
	|
		if_then_else_stmt_nsi 
		
	|
		while_stmt_nsi 
		
	|
		for_stmt_nsi 
		
	;


stmt_wots:
		block 
		
	|
		switch_stmt 
		
	|
		do_stmt 
		
	|
		break_stmt 
		
	|
		continue_stmt 
		
	|
		return_stmt 
		
	|
		stmt_expr 'terminator' 
		
	|
		'terminator' 
		
	;


if_then_stmt:
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt 
		
	;


if_then_else_stmt:
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 'else' stmt 
		
	;


if_then_else_stmt_nsi:
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 'else' stmt_nsi 
		
	;


switch_stmt:
		'switch' 'paranthesis_start' expr 'paranthesis_end' switch_block 
		
	;


switch_block:
		'set_start' switch_block_stmt_groups switch_labels 'set_end' 
		
	|
		'set_start' switch_labels 'set_end' 
		
	|
		'set_start' switch_block_stmt_groups 'set_end' 
		
	|
		'set_start' 'set_end' 
		
	;


switch_block_stmt_groups:
		switch_block_stmt_groups switch_block_stmt_group 
		
	|
		switch_block_stmt_group 
		
	;


switch_block_stmt_group:
		switch_labels block_stmts 
		
	;


switch_labels:
		switch_labels switch_label 
		
	|
		switch_label 
		
	;


switch_label:
		'case' literal 'colon' 
		
	|
		'case' 'paranthesis_start' literal 'paranthesis_end' 'colon' 
		
	|
		'default' 'colon' 
		
	;


while_stmt:
		'while' 'paranthesis_start' expr 'paranthesis_end' stmt 
		
	;


while_stmt_nsi:
		'while' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 
		
	;


do_stmt:
		'do' stmt 'while' 'paranthesis_start' expr 'paranthesis_end' 'terminator' 
		
	;


for_stmt:
		'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' stmt 
		
	|
		'for' 'paranthesis_start' 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' stmt 
		
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' stmt 
		
	|
		'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' 'paranthesis_end' stmt 
		
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' stmt 
		
	|
		'for' 'paranthesis_start' 'terminator' expr 'terminator' 'paranthesis_end' stmt 
		
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' 'paranthesis_end' stmt 
		
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' 'paranthesis_end' stmt 
		
	;


for_stmt_nsi:
		'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' stmt_nsi 
		
	|
		'for' 'paranthesis_start' 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' stmt_nsi 
		
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' stmt_nsi 
		
	|
		'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' 'paranthesis_end' stmt_nsi 
		
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' stmt_nsi 
		
	|
		'for' 'paranthesis_start' 'terminator' expr 'terminator' 'paranthesis_end' stmt_nsi 
		
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' 'paranthesis_end' stmt_nsi 
		
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' 'paranthesis_end' stmt_nsi 
		
	;


for_init:
		stmt_expr_list 
		
	|
		type var_declarators 
		
	;


stmt_expr_list:
		stmt_expr_list 'separator' stmt_expr 
		
	|
		stmt_expr 
		
	;


break_stmt:
		'break' 'terminator' 
		
	;


continue_stmt:
		'continue' 'terminator' 
		
	;


return_stmt:
		'return' expr 'terminator' 
		
	|
		'return' 'terminator' 
		
	;


expr:
		cond_expr 
		
	|
		assignment 
		
	;


stmt_expr:
		assignment 
		
	|
		preinc_expr 
		
	|
		predec_expr 
		
	|
		postinc_expr 
		
	|
		postdec_expr 
		
	|
		method_invocation 
		
	|
		class_instance_creation_expr 
		
	;


assignment:
		left_hand_side assignment_operator expr 
		
	;


left_hand_side:
		expr_name 
		
	|
		field_access 
		
	|
		array_access 
		
	;


assignment_operator:
		'op_assign' 
		
	|
		'op_mulAssign' 
		
	|
		'op_divAssign' 
		
	|
		'op_modAssign' 
		
	|
		'op_addAssign' 
		
	|
		'op_subAssign' 
		
	|
		'op_LshiftEqual' 
		
	|
		'op_RshiftEqual' 
		
	|
		'op_andAssign' 
		
	|
		'op_orAssign' 
		
	|
		'op_xorAssign' 
		
	;


cond_expr:
		cond_or_expr 
		
	;


cond_or_expr:
		cond_and_expr 
		
	|
		cond_or_expr 'op_oror' cond_and_expr 
		
	;


cond_and_expr:
		incl_or_expr 
		
	|
		cond_and_expr 'op_andand' incl_or_expr 
		
	;


incl_or_expr:
		excl_or_expr 
		
	|
		incl_or_expr 'op_or' excl_or_expr 
		
	;


excl_or_expr:
		and_expr 
		
	|
		excl_or_expr 'op_xor' and_expr 
		
	;


and_expr:
		equality_expr 
		
	|
		and_expr 'op_and' equality_expr 
		
	;


equality_expr:
		relational_expr 
		
	|
		equality_expr 'op_equalCompare' relational_expr 
		
	|
		equality_expr 'op_notequalCompare' relational_expr 
		
	;


relational_expr:
		shift_expr 
		
	|
		relational_expr 'op_greater' shift_expr 
		
	|
		relational_expr 'op_greaterEqual' shift_expr 
		
	|
		relational_expr 'op_less' shift_expr 
		
	|
		relational_expr 'op_lessEqual' shift_expr 
		
	|
		relational_expr 'instanceof' shift_expr 
		
	;


shift_expr:
		additive_expr 
		
	|
		shift_expr 'op_Lshift' additive_expr 
		
	|
		shift_expr 'op_Rshift' additive_expr 
		
	;


additive_expr:
		multiplicative_expr 
		
	|
		additive_expr 'op_add' multiplicative_expr 
		
	|
		additive_expr 'op_sub' multiplicative_expr 
		
	;


multiplicative_expr:
		unary_expr 
		
	|
		multiplicative_expr 'op_mul' unary_expr 
		
	|
		multiplicative_expr 'op_div' unary_expr 
		
	|
		multiplicative_expr 'op_mod' unary_expr 
		
	;


predec_expr:
		'op_decrement' unary_expr 
		
	;


preinc_expr:
		'op_increment' unary_expr 
		
	;


unary_expr:
		preinc_expr 
		
	|
		predec_expr 
		
	|
		'op_add' unary_expr 
		
	|
		'op_sub' unary_expr 
		
	|
		unary_expr_npm 
		
	;


unary_expr_npm:
		postfix_expr 
		
	|
		'op_not' unary_expr 
		
	|
		cast_expr 
		
	;


cast_expr:
		'paranthesis_start' primitive_type 'paranthesis_end' unary_expr 
		
	;


postdec_expr:
		postfix_expr 'op_decrement' 
		
	;


postinc_expr:
		postfix_expr 'op_increment' 
		
	;


postfix_expr:
		primary 
		
	|
		expr_name 
		
	|
		postinc_expr 
		
	|
		postdec_expr 
		
	;


method_invocation:
		expr_name 'paranthesis_start' argument_list 'paranthesis_end' 
		
	|
		primary 'field_invoker' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		
	|
		'super' 'field_invoker' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		
	|
		expr_name 'paranthesis_start' 'paranthesis_end' 
		
	|
		primary 'field_invoker' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		
	|
		'super' 'field_invoker' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		
	;


field_access:
		primary 'field_invoker' 'identifier' 
		
	|
		'super' 'field_invoker' 'identifier' 
		
	;


array_access:
		expr_name 'colon' dim_exprs 
		
	|
		primary_no_new_array 'colon' dim_exprs 
		
	;


primary:
		primary_no_new_array 
		
	|
		array_creation_expr 
		
	;


primary_no_new_array:
		literal 
		
	|
		'this' 
		
	|
		'paranthesis_start' expr 'paranthesis_end' 
		
	|
		class_instance_creation_expr 
		
	|
		field_access 
		
	|
		array_access 
		
	|
		method_invocation 
		
	;


class_instance_creation_expr:
		'new' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		
	|
		'new' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		
	;


argument_list:
		expr 
		
	|
		argument_list 'separator' expr 
		
	;


array_creation_expr:
		'new' primitive_type dim_exprs dims 
		
	|
		'new' 'identifier' dim_exprs dims 
		
	|
		'new' primitive_type dim_exprs 
		
	|
		'new' 'identifier' dim_exprs 
		
	;


dim_exprs:
		dim_exprs dim_expr 
		
	|
		dim_expr 
		
	;


dim_expr:
		'brackets_start' expr 'brackets_end' 
		
	;


dims:
		'brackets_start' 'brackets_end' 
		
	|
		dims 'brackets_start' 'brackets_end' 
		
	;


expr_name:
		'identifier' 
		
	|
		expr_name 'field_invoker' 'identifier' 
		
	;


literal:
		'integer_literal' 
		
	|
		'float_literal' 
		
	|
		'boolean_literal' 
		
	|
		'character_literal' 
		
	|
		'string_literal' 
		
	|
		'null_literal' 
		
	;


sign:
		'op_add' 
		
	|
		'op_sub' 
		
	;


