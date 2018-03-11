%lex

%s BLOCKCOMMENT

%%
\s+									/* SKIP WHITESPACES */

"boolean"							return 'boolean';

"break"								return 'break';

"byte"								return 'byte';

"case"								return 'case';

"char"								return 'char';

"class" 							return 'class';

"const"								return 'const';

"continue"							return 'continue';

"default"							return 'default';

"do"								return 'do';

"double"							return 'double';

"else"								return 'else';

"extends"							return 'extends';

"float"								return 'float';

"for"								return 'for';

"if"								return 'if';

"import"							return 'import';

"instanceof"						return 'instanceof';

"int"								return 'int';

"long"								return 'long';

"new"								return 'new';

"public"							return 'public';

"return"							return 'return';

"short" 							return 'short';

"static"							return 'static';

"super" 							return 'super';

"switch"							return 'switch';

"this"								return 'this';

"void"								return 'void';

"while" 							return 'while';

[+][+]								return 'op_increment';

[-][-]								return 'op_decrement';

[+]									return 'op_add';

[-]									return 'op_sub';

[*]									return 'op_mul';

[/]									return 'op_div';

[%]									return 'op_mod';

[+][=]								return 'op_addAssign';

[-][=]								return 'op_subAssign';

[*][=]								return 'op_mulAssign';

[/][=]								return 'op_divAssign';

[%][=]								return 'op_modAssign';

[&][=]								return 'op_andAssign';

[|][=]								return 'op_orAssign';

[\^][=]								return 'op_xorAssign';

[!][=]								return 'op_notequalCompare';

[=][=]								return 'op_equalCompare';

[<][<][=]							return 'op_LshiftEqual';

[>][>][=]							return 'op_RshiftEqual';

[>][=]								return 'op_greaterEqual';

[<][=]								return 'op_lessEqual';

[<][<]								return 'op_Lshift';

[>][>]								return 'op_Rshift';

[>]									return 'op_greater';

[<]									return 'op_less';

[=]									return 'op_assign';

[&][&]								return 'op_andand';

[|][|]								return 'op_oror';

[&]									return 'op_and';

[|]									return 'op_or';

[!]									return 'op_not';

[\^]								return 'op_xor';

[:] 								return 'colon';

[0-9]+\.[0-9]*						return 'float_literal';

[0-9]+								return 'integer_literal';

"true"								return 'boolean_literal';

"false"								return 'boolean_literal';

"null"								return 'null_literal';

\'(\\.|[^\\\'])*\'					return 'string_literal';

\'(\\.|[^\\\'])\'					return 'character_literal';

([a-z]|[A-Z]|[$]|[_])(\w)*			return 'identifier';

[;]									return 'terminator';

\[.]								return 'field_invoker';

[,]									return 'separator';

[(]									return 'paranthesis_start';

[)]									return 'paranthesis_end';

[\[]								return 'brackets_start';

[\]]								return 'brackets_end';

[{]									return 'set_start';

[}]									return 'set_end';

\/\/.*								/* SKIP COMMENTS */

\/\*								this.begin('BLOCKCOMMENT');

<BLOCKCOMMENT>\*\/					/* SKIP BLOCKCOMMENTS */

<BLOCKCOMMENT>(\n|\r|.)				/* SKIP BLOCKCOMMENTS */

<<EOF>>								return 'EOF';

/lex


%start program
%% /* language grammar */


program :
		import_decrs type_decrs 'EOF' 
		{ return { parent: 'program', children: [$1,$2,'EOF'] } }
	|
		type_decrs 'EOF' 
		{ return { parent: 'program', children: [$1,'EOF'] } }
	|
		import_decrs 'EOF' 
		{ return { parent: 'program', children: [$1,'EOF'] } }
	|
		'EOF' 
		{ return { parent: 'program', children: ['EOF'] } }
	;


import_decrs :
		import_decr 
		{ $$ = { parent: 'import_decrs', children: [$1] } }
	|
		import_decrs import_decr 
		{ $$ = { parent: 'import_decrs', children: [$1,$2] } }
	;


import_decr :
		'import' 'identifier' 'terminator' 
		{ $$ = { parent: 'import_decr', children: ['import','identifier','terminator'] } }
	;


type_decrs :
		type_decrs type_decr 
		{ $$ = { parent: 'type_decrs', children: [$1,$2] } }
	|
		type_decr 
		{ $$ = { parent: 'type_decrs', children: [$1] } }
	;


type_decr :
		class_decr 
		{ $$ = { parent: 'type_decr', children: [$1] } }
	|
		'terminator' 
		{ $$ = { parent: 'type_decr', children: ['terminator'] } }
	;


class_decr :
		'public' 'class' 'identifier' extend_decr class_body 
		{ $$ = { parent: 'class_decr', children: ['public','class','identifier',$1,$2] } }
	|
		'class' 'identifier' extend_decr class_body 
		{ $$ = { parent: 'class_decr', children: ['class','identifier',$1,$2] } }
	|
		'public' 'class' 'identifier' class_body 
		{ $$ = { parent: 'class_decr', children: ['public','class','identifier',$1] } }
	|
		'class' 'identifier' class_body 
		{ $$ = { parent: 'class_decr', children: ['class','identifier',$1] } }
	;


extend_decr :
		'extends' 'identifier' 
		{ $$ = { parent: 'extend_decr', children: ['extends','identifier'] } }
	;


class_body :
		'set_start' class_body_decrs 'set_end' 
		{ $$ = { parent: 'class_body', children: ['set_start',$1,'set_end'] } }
	;


class_body_decrs :
		class_body_decrs class_body_decr 
		{ $$ = { parent: 'class_body_decrs', children: [$1,$2] } }
	|
		class_body_decr 
		{ $$ = { parent: 'class_body_decrs', children: [$1] } }
	;


class_body_decr :
		class_member_decr 
		{ $$ = { parent: 'class_body_decr', children: [$1] } }
	|
		'public' consr_declarator consr_body 
		{ $$ = { parent: 'class_body_decr', children: ['public',$1,$2] } }
	|
		consr_declarator consr_body 
		{ $$ = { parent: 'class_body_decr', children: [$1,$2] } }
	;


class_member_decr :
		field_decr 
		{ $$ = { parent: 'class_member_decr', children: [$1] } }
	|
		method_decr 
		{ $$ = { parent: 'class_member_decr', children: [$1] } }
	;


consr_declarator :
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{ $$ = { parent: 'consr_declarator', children: ['identifier','paranthesis_start',$1,'paranthesis_end'] } }
	;


formal_parameter_list :
		formal_parameter_list 'separator' formal_parameter 
		{ $$ = { parent: 'formal_parameter_list', children: [$1,'separator',$2] } }
	|
		formal_parameter 
		{ $$ = { parent: 'formal_parameter_list', children: [$1] } }
	|
		
		{ $$ = { parent: 'formal_parameter_list', children: [] } }
	;


formal_parameter :
		type var_declarator_id 
		{ $$ = { parent: 'formal_parameter', children: [$1,$2] } }
	;


consr_body :
		'set_start' explicit_consr_invocation block_stmts 'set_end' 
		{ $$ = { parent: 'consr_body', children: ['set_start',$1,$2,'set_end'] } }
	|
		'set_start' block_stmts 'set_end' 
		{ $$ = { parent: 'consr_body', children: ['set_start',$1,'set_end'] } }
	|
		'set_start' explicit_consr_invocation 'set_end' 
		{ $$ = { parent: 'consr_body', children: ['set_start',$1,'set_end'] } }
	|
		'set_start' 'set_end' 
		{ $$ = { parent: 'consr_body', children: ['set_start','set_end'] } }
	;


explicit_consr_invocation :
		'this' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { parent: 'explicit_consr_invocation', children: ['this','paranthesis_start',$1,'paranthesis_end'] } }
	|
		'super' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { parent: 'explicit_consr_invocation', children: ['super','paranthesis_start',$1,'paranthesis_end'] } }
	|
		'this' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { parent: 'explicit_consr_invocation', children: ['this','paranthesis_start','paranthesis_end'] } }
	|
		'super' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { parent: 'explicit_consr_invocation', children: ['super','paranthesis_start','paranthesis_end'] } }
	;


field_decr :
		'public' type var_declarators 'terminator' 
		{ $$ = { parent: 'field_decr', children: ['public',$1,$2,'terminator'] } }
	|
		type var_declarators 'terminator' 
		{ $$ = { parent: 'field_decr', children: [$1,$2,'terminator'] } }
	;


var_declarators :
		var_declarators 'separator' var_declarator 
		{ $$ = { parent: 'var_declarators', children: [$1,'separator',$2] } }
	|
		var_declarator 
		{ $$ = { parent: 'var_declarators', children: [$1] } }
	;


var_declarator :
		var_declarator_id 
		{ $$ = { parent: 'var_declarator', children: [$1] } }
	|
		var_declarator_id 'op_assign' var_init 
		{ $$ = { parent: 'var_declarator', children: [$1,'op_assign',$2] } }
	;


var_declarator_id :
		var_declarator_id 'brackets_start' 'brackets_end' 
		{ $$ = { parent: 'var_declarator_id', children: [$1,'brackets_start','brackets_end'] } }
	|
		'identifier' 
		{ $$ = { parent: 'var_declarator_id', children: ['identifier'] } }
	;


var_init :
		expr 
		{ $$ = { parent: 'var_init', children: [$1] } }
	|
		array_init 
		{ $$ = { parent: 'var_init', children: [$1] } }
	;


method_decr :
		'public' method_declarator 'colon' result_type method_body 
		{ $$ = { parent: 'method_decr', children: ['public',$1,'colon',$2,$3] } }
	|
		method_declarator 'colon' result_type method_body 
		{ $$ = { parent: 'method_decr', children: [$1,'colon',$2,$3] } }
	;


result_type :
		type 
		{ $$ = { parent: 'result_type', children: [$1] } }
	|
		'void' 
		{ $$ = { parent: 'result_type', children: ['void'] } }
	;


method_declarator :
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{ $$ = { parent: 'method_declarator', children: ['identifier','paranthesis_start',$1,'paranthesis_end'] } }
	;


method_body :
		block 
		{ $$ = { parent: 'method_body', children: [$1] } }
	;


array_init :
		'set_start' var_inits 'separator' 'set_end' 
		{ $$ = { parent: 'array_init', children: ['set_start',$1,'separator','set_end'] } }
	|
		'set_start' var_inits 'set_end' 
		{ $$ = { parent: 'array_init', children: ['set_start',$1,'set_end'] } }
	|
		'set_start' 'separator' 'set_end' 
		{ $$ = { parent: 'array_init', children: ['set_start','separator','set_end'] } }
	|
		'set_start' 'set_end' 
		{ $$ = { parent: 'array_init', children: ['set_start','set_end'] } }
	;


var_inits :
		var_inits 'separator' var_init 
		{ $$ = { parent: 'var_inits', children: [$1,'separator',$2] } }
	|
		var_init 
		{ $$ = { parent: 'var_inits', children: [$1] } }
	;


type :
		primitive_type 
		{ $$ = { parent: 'type', children: [$1] } }
	|
		reference_type 
		{ $$ = { parent: 'type', children: [$1] } }
	;


primitive_type :
		integral_type 
		{ $$ = { parent: 'primitive_type', children: [$1] } }
	|
		floating_type 
		{ $$ = { parent: 'primitive_type', children: [$1] } }
	|
		'boolean' 
		{ $$ = { parent: 'primitive_type', children: ['boolean'] } }
	;


integral_type :
		'byte' 
		{ $$ = { parent: 'integral_type', children: ['byte'] } }
	|
		'short' 
		{ $$ = { parent: 'integral_type', children: ['short'] } }
	|
		'int' 
		{ $$ = { parent: 'integral_type', children: ['int'] } }
	|
		'long' 
		{ $$ = { parent: 'integral_type', children: ['long'] } }
	|
		'char' 
		{ $$ = { parent: 'integral_type', children: ['char'] } }
	;


floating_type :
		'float' 
		{ $$ = { parent: 'floating_type', children: ['float'] } }
	|
		'double' 
		{ $$ = { parent: 'floating_type', children: ['double'] } }
	;


reference_type :
		'identifier' 
		{ $$ = { parent: 'reference_type', children: ['identifier'] } }
	|
		type 'brackets_start' 'brackets_end' 
		{ $$ = { parent: 'reference_type', children: [$1,'brackets_start','brackets_end'] } }
	;


block :
		'set_start' block_stmts 'set_end' 
		{ $$ = { parent: 'block', children: ['set_start',$1,'set_end'] } }
	|
		'set_start' 'set_end' 
		{ $$ = { parent: 'block', children: ['set_start','set_end'] } }
	;


block_stmts :
		block_stmts block_stmt 
		{ $$ = { parent: 'block_stmts', children: [$1,$2] } }
	|
		block_stmt 
		{ $$ = { parent: 'block_stmts', children: [$1] } }
	;


block_stmt :
		type var_declarators 'terminator' 
		{ $$ = { parent: 'block_stmt', children: [$1,$2,'terminator'] } }
	|
		stmt 
		{ $$ = { parent: 'block_stmt', children: [$1] } }
	;


stmt :
		stmt_wots 
		{ $$ = { parent: 'stmt', children: [$1] } }
	|
		if_then_stmt 
		{ $$ = { parent: 'stmt', children: [$1] } }
	|
		if_then_else_stmt 
		{ $$ = { parent: 'stmt', children: [$1] } }
	|
		while_stmt 
		{ $$ = { parent: 'stmt', children: [$1] } }
	|
		for_stmt 
		{ $$ = { parent: 'stmt', children: [$1] } }
	;


stmt_nsi :
		stmt_wots 
		{ $$ = { parent: 'stmt_nsi', children: [$1] } }
	|
		if_then_else_stmt_nsi 
		{ $$ = { parent: 'stmt_nsi', children: [$1] } }
	|
		while_stmt_nsi 
		{ $$ = { parent: 'stmt_nsi', children: [$1] } }
	|
		for_stmt_nsi 
		{ $$ = { parent: 'stmt_nsi', children: [$1] } }
	;


stmt_wots :
		block 
		{ $$ = { parent: 'stmt_wots', children: [$1] } }
	|
		switch_stmt 
		{ $$ = { parent: 'stmt_wots', children: [$1] } }
	|
		do_stmt 
		{ $$ = { parent: 'stmt_wots', children: [$1] } }
	|
		break_stmt 
		{ $$ = { parent: 'stmt_wots', children: [$1] } }
	|
		continue_stmt 
		{ $$ = { parent: 'stmt_wots', children: [$1] } }
	|
		return_stmt 
		{ $$ = { parent: 'stmt_wots', children: [$1] } }
	|
		stmt_expr 'terminator' 
		{ $$ = { parent: 'stmt_wots', children: [$1,'terminator'] } }
	|
		'terminator' 
		{ $$ = { parent: 'stmt_wots', children: ['terminator'] } }
	;


if_then_stmt :
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt 
		{ $$ = { parent: 'if_then_stmt', children: ['if','paranthesis_start',$1,'paranthesis_end',$2] } }
	;


if_then_else_stmt :
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 'else' stmt 
		{ $$ = { parent: 'if_then_else_stmt', children: ['if','paranthesis_start',$1,'paranthesis_end',$2,'else',$3] } }
	;


if_then_else_stmt_nsi :
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 'else' stmt_nsi 
		{ $$ = { parent: 'if_then_else_stmt_nsi', children: ['if','paranthesis_start',$1,'paranthesis_end',$2,'else',$3] } }
	;


switch_stmt :
		'switch' 'paranthesis_start' expr 'paranthesis_end' switch_block 
		{ $$ = { parent: 'switch_stmt', children: ['switch','paranthesis_start',$1,'paranthesis_end',$2] } }
	;


switch_block :
		'set_start' switch_block_stmt_groups switch_labels 'set_end' 
		{ $$ = { parent: 'switch_block', children: ['set_start',$1,$2,'set_end'] } }
	|
		'set_start' switch_labels 'set_end' 
		{ $$ = { parent: 'switch_block', children: ['set_start',$1,'set_end'] } }
	|
		'set_start' switch_block_stmt_groups 'set_end' 
		{ $$ = { parent: 'switch_block', children: ['set_start',$1,'set_end'] } }
	|
		'set_start' 'set_end' 
		{ $$ = { parent: 'switch_block', children: ['set_start','set_end'] } }
	;


switch_block_stmt_groups :
		switch_block_stmt_groups switch_block_stmt_group 
		{ $$ = { parent: 'switch_block_stmt_groups', children: [$1,$2] } }
	|
		switch_block_stmt_group 
		{ $$ = { parent: 'switch_block_stmt_groups', children: [$1] } }
	;


switch_block_stmt_group :
		switch_labels block_stmts 
		{ $$ = { parent: 'switch_block_stmt_group', children: [$1,$2] } }
	;


switch_labels :
		switch_labels switch_label 
		{ $$ = { parent: 'switch_labels', children: [$1,$2] } }
	|
		switch_label 
		{ $$ = { parent: 'switch_labels', children: [$1] } }
	;


switch_label :
		'case' literal 'colon' 
		{ $$ = { parent: 'switch_label', children: ['case',$1,'colon'] } }
	|
		'case' 'paranthesis_start' literal 'paranthesis_end' 'colon' 
		{ $$ = { parent: 'switch_label', children: ['case','paranthesis_start',$1,'paranthesis_end','colon'] } }
	|
		'default' 'colon' 
		{ $$ = { parent: 'switch_label', children: ['default','colon'] } }
	;


while_stmt :
		'while' 'paranthesis_start' expr 'paranthesis_end' stmt 
		{ $$ = { parent: 'while_stmt', children: ['while','paranthesis_start',$1,'paranthesis_end',$2] } }
	;


while_stmt_nsi :
		'while' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'while_stmt_nsi', children: ['while','paranthesis_start',$1,'paranthesis_end',$2] } }
	;


do_stmt :
		'do' stmt 'while' 'paranthesis_start' expr 'paranthesis_end' 'terminator' 
		{ $$ = { parent: 'do_stmt', children: ['do',$1,'while','paranthesis_start',$2,'paranthesis_end','terminator'] } }
	;


for_stmt :
		'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' stmt 
		{ $$ = { parent: 'for_stmt', children: ['for','paranthesis_start',$1,'terminator',$2,'terminator',$3,'paranthesis_end',$4] } }
	|
		'for' 'paranthesis_start' 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' stmt 
		{ $$ = { parent: 'for_stmt', children: ['for','paranthesis_start','terminator',$1,'terminator',$2,'paranthesis_end',$3] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' stmt 
		{ $$ = { parent: 'for_stmt', children: ['for','paranthesis_start',$1,'terminator','terminator',$2,'paranthesis_end',$3] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' 'paranthesis_end' stmt 
		{ $$ = { parent: 'for_stmt', children: ['for','paranthesis_start',$1,'terminator',$2,'terminator','paranthesis_end',$3] } }
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' stmt 
		{ $$ = { parent: 'for_stmt', children: ['for','paranthesis_start','terminator','terminator',$1,'paranthesis_end',$2] } }
	|
		'for' 'paranthesis_start' 'terminator' expr 'terminator' 'paranthesis_end' stmt 
		{ $$ = { parent: 'for_stmt', children: ['for','paranthesis_start','terminator',$1,'terminator','paranthesis_end',$2] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' 'paranthesis_end' stmt 
		{ $$ = { parent: 'for_stmt', children: ['for','paranthesis_start',$1,'terminator','terminator','paranthesis_end',$2] } }
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' 'paranthesis_end' stmt 
		{ $$ = { parent: 'for_stmt', children: ['for','paranthesis_start','terminator','terminator','paranthesis_end',$1] } }
	;


for_stmt_nsi :
		'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'for_stmt_nsi', children: ['for','paranthesis_start',$1,'terminator',$2,'terminator',$3,'paranthesis_end',$4] } }
	|
		'for' 'paranthesis_start' 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'for_stmt_nsi', children: ['for','paranthesis_start','terminator',$1,'terminator',$2,'paranthesis_end',$3] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'for_stmt_nsi', children: ['for','paranthesis_start',$1,'terminator','terminator',$2,'paranthesis_end',$3] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'for_stmt_nsi', children: ['for','paranthesis_start',$1,'terminator',$2,'terminator','paranthesis_end',$3] } }
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'for_stmt_nsi', children: ['for','paranthesis_start','terminator','terminator',$1,'paranthesis_end',$2] } }
	|
		'for' 'paranthesis_start' 'terminator' expr 'terminator' 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'for_stmt_nsi', children: ['for','paranthesis_start','terminator',$1,'terminator','paranthesis_end',$2] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'for_stmt_nsi', children: ['for','paranthesis_start',$1,'terminator','terminator','paranthesis_end',$2] } }
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' 'paranthesis_end' stmt_nsi 
		{ $$ = { parent: 'for_stmt_nsi', children: ['for','paranthesis_start','terminator','terminator','paranthesis_end',$1] } }
	;


for_init :
		stmt_expr_list 
		{ $$ = { parent: 'for_init', children: [$1] } }
	|
		type var_declarators 
		{ $$ = { parent: 'for_init', children: [$1,$2] } }
	;


stmt_expr_list :
		stmt_expr_list 'separator' stmt_expr 
		{ $$ = { parent: 'stmt_expr_list', children: [$1,'separator',$2] } }
	|
		stmt_expr 
		{ $$ = { parent: 'stmt_expr_list', children: [$1] } }
	;


break_stmt :
		'break' 'terminator' 
		{ $$ = { parent: 'break_stmt', children: ['break','terminator'] } }
	;


continue_stmt :
		'continue' 'terminator' 
		{ $$ = { parent: 'continue_stmt', children: ['continue','terminator'] } }
	;


return_stmt :
		'return' expr 'terminator' 
		{ $$ = { parent: 'return_stmt', children: ['return',$1,'terminator'] } }
	|
		'return' 'terminator' 
		{ $$ = { parent: 'return_stmt', children: ['return','terminator'] } }
	;


expr :
		cond_expr 
		{ $$ = { parent: 'expr', children: [$1] } }
	|
		assignment 
		{ $$ = { parent: 'expr', children: [$1] } }
	;


stmt_expr :
		assignment 
		{ $$ = { parent: 'stmt_expr', children: [$1] } }
	|
		preinc_expr 
		{ $$ = { parent: 'stmt_expr', children: [$1] } }
	|
		predec_expr 
		{ $$ = { parent: 'stmt_expr', children: [$1] } }
	|
		postinc_expr 
		{ $$ = { parent: 'stmt_expr', children: [$1] } }
	|
		postdec_expr 
		{ $$ = { parent: 'stmt_expr', children: [$1] } }
	|
		method_invocation 
		{ $$ = { parent: 'stmt_expr', children: [$1] } }
	|
		class_instance_creation_expr 
		{ $$ = { parent: 'stmt_expr', children: [$1] } }
	;


assignment :
		left_hand_side assignment_operator expr 
		{ $$ = { parent: 'assignment', children: [$1,$2,$3] } }
	;


left_hand_side :
		expr_name 
		{ $$ = { parent: 'left_hand_side', children: [$1] } }
	|
		field_access 
		{ $$ = { parent: 'left_hand_side', children: [$1] } }
	|
		array_access 
		{ $$ = { parent: 'left_hand_side', children: [$1] } }
	;


assignment_operator :
		'op_assign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_assign'] } }
	|
		'op_mulAssign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_mulAssign'] } }
	|
		'op_divAssign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_divAssign'] } }
	|
		'op_modAssign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_modAssign'] } }
	|
		'op_addAssign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_addAssign'] } }
	|
		'op_subAssign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_subAssign'] } }
	|
		'op_LshiftEqual' 
		{ $$ = { parent: 'assignment_operator', children: ['op_LshiftEqual'] } }
	|
		'op_RshiftEqual' 
		{ $$ = { parent: 'assignment_operator', children: ['op_RshiftEqual'] } }
	|
		'op_andAssign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_andAssign'] } }
	|
		'op_orAssign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_orAssign'] } }
	|
		'op_xorAssign' 
		{ $$ = { parent: 'assignment_operator', children: ['op_xorAssign'] } }
	;


cond_expr :
		cond_or_expr 
		{ $$ = { parent: 'cond_expr', children: [$1] } }
	;


cond_or_expr :
		cond_and_expr 
		{ $$ = { parent: 'cond_or_expr', children: [$1] } }
	|
		cond_or_expr 'op_oror' cond_and_expr 
		{ $$ = { parent: 'cond_or_expr', children: [$1,'op_oror',$2] } }
	;


cond_and_expr :
		incl_or_expr 
		{ $$ = { parent: 'cond_and_expr', children: [$1] } }
	|
		cond_and_expr 'op_andand' incl_or_expr 
		{ $$ = { parent: 'cond_and_expr', children: [$1,'op_andand',$2] } }
	;


incl_or_expr :
		excl_or_expr 
		{ $$ = { parent: 'incl_or_expr', children: [$1] } }
	|
		incl_or_expr 'op_or' excl_or_expr 
		{ $$ = { parent: 'incl_or_expr', children: [$1,'op_or',$2] } }
	;


excl_or_expr :
		and_expr 
		{ $$ = { parent: 'excl_or_expr', children: [$1] } }
	|
		excl_or_expr 'op_xor' and_expr 
		{ $$ = { parent: 'excl_or_expr', children: [$1,'op_xor',$2] } }
	;


and_expr :
		equality_expr 
		{ $$ = { parent: 'and_expr', children: [$1] } }
	|
		and_expr 'op_and' equality_expr 
		{ $$ = { parent: 'and_expr', children: [$1,'op_and',$2] } }
	;


equality_expr :
		relational_expr 
		{ $$ = { parent: 'equality_expr', children: [$1] } }
	|
		equality_expr 'op_equalCompare' relational_expr 
		{ $$ = { parent: 'equality_expr', children: [$1,'op_equalCompare',$2] } }
	|
		equality_expr 'op_notequalCompare' relational_expr 
		{ $$ = { parent: 'equality_expr', children: [$1,'op_notequalCompare',$2] } }
	;


relational_expr :
		shift_expr 
		{ $$ = { parent: 'relational_expr', children: [$1] } }
	|
		relational_expr 'op_greater' shift_expr 
		{ $$ = { parent: 'relational_expr', children: [$1,'op_greater',$2] } }
	|
		relational_expr 'op_greaterEqual' shift_expr 
		{ $$ = { parent: 'relational_expr', children: [$1,'op_greaterEqual',$2] } }
	|
		relational_expr 'op_less' shift_expr 
		{ $$ = { parent: 'relational_expr', children: [$1,'op_less',$2] } }
	|
		relational_expr 'op_lessEqual' shift_expr 
		{ $$ = { parent: 'relational_expr', children: [$1,'op_lessEqual',$2] } }
	|
		relational_expr 'instanceof' shift_expr 
		{ $$ = { parent: 'relational_expr', children: [$1,'instanceof',$2] } }
	;


shift_expr :
		additive_expr 
		{ $$ = { parent: 'shift_expr', children: [$1] } }
	|
		shift_expr 'op_Lshift' additive_expr 
		{ $$ = { parent: 'shift_expr', children: [$1,'op_Lshift',$2] } }
	|
		shift_expr 'op_Rshift' additive_expr 
		{ $$ = { parent: 'shift_expr', children: [$1,'op_Rshift',$2] } }
	;


additive_expr :
		multiplicative_expr 
		{ $$ = { parent: 'additive_expr', children: [$1] } }
	|
		additive_expr 'op_add' multiplicative_expr 
		{ $$ = { parent: 'additive_expr', children: [$1,'op_add',$2] } }
	|
		additive_expr 'op_sub' multiplicative_expr 
		{ $$ = { parent: 'additive_expr', children: [$1,'op_sub',$2] } }
	;


multiplicative_expr :
		unary_expr 
		{ $$ = { parent: 'multiplicative_expr', children: [$1] } }
	|
		multiplicative_expr 'op_mul' unary_expr 
		{ $$ = { parent: 'multiplicative_expr', children: [$1,'op_mul',$2] } }
	|
		multiplicative_expr 'op_div' unary_expr 
		{ $$ = { parent: 'multiplicative_expr', children: [$1,'op_div',$2] } }
	|
		multiplicative_expr 'op_mod' unary_expr 
		{ $$ = { parent: 'multiplicative_expr', children: [$1,'op_mod',$2] } }
	;


predec_expr :
		'op_decrement' unary_expr 
		{ $$ = { parent: 'predec_expr', children: ['op_decrement',$1] } }
	;


preinc_expr :
		'op_increment' unary_expr 
		{ $$ = { parent: 'preinc_expr', children: ['op_increment',$1] } }
	;


unary_expr :
		preinc_expr 
		{ $$ = { parent: 'unary_expr', children: [$1] } }
	|
		predec_expr 
		{ $$ = { parent: 'unary_expr', children: [$1] } }
	|
		'op_add' unary_expr 
		{ $$ = { parent: 'unary_expr', children: ['op_add',$1] } }
	|
		'op_sub' unary_expr 
		{ $$ = { parent: 'unary_expr', children: ['op_sub',$1] } }
	|
		unary_expr_npm 
		{ $$ = { parent: 'unary_expr', children: [$1] } }
	;


unary_expr_npm :
		postfix_expr 
		{ $$ = { parent: 'unary_expr_npm', children: [$1] } }
	|
		postinc_expr 
		{ $$ = { parent: 'unary_expr_npm', children: [$1] } }
	|
		postdec_expr 
		{ $$ = { parent: 'unary_expr_npm', children: [$1] } }
	|
		'op_not' unary_expr 
		{ $$ = { parent: 'unary_expr_npm', children: ['op_not',$1] } }
	|
		cast_expr 
		{ $$ = { parent: 'unary_expr_npm', children: [$1] } }
	;


cast_expr :
		'paranthesis_start' primitive_type 'paranthesis_end' unary_expr 
		{ $$ = { parent: 'cast_expr', children: ['paranthesis_start',$1,'paranthesis_end',$2] } }
	;


postdec_expr :
		postfix_expr 'op_decrement' 
		{ $$ = { parent: 'postdec_expr', children: [$1,'op_decrement'] } }
	;


postinc_expr :
		postfix_expr 'op_increment' 
		{ $$ = { parent: 'postinc_expr', children: [$1,'op_increment'] } }
	;


postfix_expr :
		primary 
		{ $$ = { parent: 'postfix_expr', children: [$1] } }
	|
		expr_name 
		{ $$ = { parent: 'postfix_expr', children: [$1] } }
	;


method_invocation :
		expr_name 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { parent: 'method_invocation', children: [$1,'paranthesis_start',$2,'paranthesis_end'] } }
	|
		primary 'field_invoker' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { parent: 'method_invocation', children: [$1,'field_invoker','identifier','paranthesis_start',$2,'paranthesis_end'] } }
	|
		'super' 'field_invoker' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { parent: 'method_invocation', children: ['super','field_invoker','identifier','paranthesis_start',$1,'paranthesis_end'] } }
	|
		expr_name 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { parent: 'method_invocation', children: [$1,'paranthesis_start','paranthesis_end'] } }
	|
		primary 'field_invoker' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { parent: 'method_invocation', children: [$1,'field_invoker','identifier','paranthesis_start','paranthesis_end'] } }
	|
		'super' 'field_invoker' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { parent: 'method_invocation', children: ['super','field_invoker','identifier','paranthesis_start','paranthesis_end'] } }
	;


field_access :
		primary 'field_invoker' 'identifier' 
		{ $$ = { parent: 'field_access', children: [$1,'field_invoker','identifier'] } }
	|
		'super' 'field_invoker' 'identifier' 
		{ $$ = { parent: 'field_access', children: ['super','field_invoker','identifier'] } }
	;


array_access :
		expr_name 'colon' dim_exprs 
		{ $$ = { parent: 'array_access', children: [$1,'colon',$2] } }
	|
		primary_no_new_array 'colon' dim_exprs 
		{ $$ = { parent: 'array_access', children: [$1,'colon',$2] } }
	;


primary :
		primary_no_new_array 
		{ $$ = { parent: 'primary', children: [$1] } }
	|
		array_creation_expr 
		{ $$ = { parent: 'primary', children: [$1] } }
	;


primary_no_new_array :
		literal 
		{ $$ = { parent: 'primary_no_new_array', children: [$1] } }
	|
		'this' 
		{ $$ = { parent: 'primary_no_new_array', children: ['this'] } }
	|
		'paranthesis_start' expr 'paranthesis_end' 
		{ $$ = { parent: 'primary_no_new_array', children: ['paranthesis_start',$1,'paranthesis_end'] } }
	|
		class_instance_creation_expr 
		{ $$ = { parent: 'primary_no_new_array', children: [$1] } }
	|
		field_access 
		{ $$ = { parent: 'primary_no_new_array', children: [$1] } }
	|
		array_access 
		{ $$ = { parent: 'primary_no_new_array', children: [$1] } }
	|
		method_invocation 
		{ $$ = { parent: 'primary_no_new_array', children: [$1] } }
	;


class_instance_creation_expr :
		'new' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { parent: 'class_instance_creation_expr', children: ['new','identifier','paranthesis_start',$1,'paranthesis_end'] } }
	|
		'new' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { parent: 'class_instance_creation_expr', children: ['new','identifier','paranthesis_start','paranthesis_end'] } }
	;


argument_list :
		expr 
		{ $$ = { parent: 'argument_list', children: [$1] } }
	|
		argument_list 'separator' expr 
		{ $$ = { parent: 'argument_list', children: [$1,'separator',$2] } }
	;


array_creation_expr :
		'new' primitive_type dim_exprs dims 
		{ $$ = { parent: 'array_creation_expr', children: ['new',$1,$2,$3] } }
	|
		'new' 'identifier' dim_exprs dims 
		{ $$ = { parent: 'array_creation_expr', children: ['new','identifier',$1,$2] } }
	|
		'new' primitive_type dim_exprs 
		{ $$ = { parent: 'array_creation_expr', children: ['new',$1,$2] } }
	|
		'new' 'identifier' dim_exprs 
		{ $$ = { parent: 'array_creation_expr', children: ['new','identifier',$1] } }
	;


dim_exprs :
		dim_exprs dim_expr 
		{ $$ = { parent: 'dim_exprs', children: [$1,$2] } }
	|
		dim_expr 
		{ $$ = { parent: 'dim_exprs', children: [$1] } }
	;


dim_expr :
		'brackets_start' expr 'brackets_end' 
		{ $$ = { parent: 'dim_expr', children: ['brackets_start',$1,'brackets_end'] } }
	;


dims :
		'brackets_start' 'brackets_end' 
		{ $$ = { parent: 'dims', children: ['brackets_start','brackets_end'] } }
	|
		dims 'brackets_start' 'brackets_end' 
		{ $$ = { parent: 'dims', children: [$1,'brackets_start','brackets_end'] } }
	;


expr_name :
		'identifier' 
		{ $$ = { parent: 'expr_name', children: ['identifier'] } }
	|
		expr_name 'field_invoker' 'identifier' 
		{ $$ = { parent: 'expr_name', children: [$1,'field_invoker','identifier'] } }
	;


literal :
		'integer_literal' 
		{ $$ = { parent: 'literal', children: ['integer_literal'] } }
	|
		'float_literal' 
		{ $$ = { parent: 'literal', children: ['float_literal'] } }
	|
		'boolean_literal' 
		{ $$ = { parent: 'literal', children: ['boolean_literal'] } }
	|
		'character_literal' 
		{ $$ = { parent: 'literal', children: ['character_literal'] } }
	|
		'string_literal' 
		{ $$ = { parent: 'literal', children: ['string_literal'] } }
	|
		'null_literal' 
		{ $$ = { parent: 'literal', children: ['null_literal'] } }
	;


sign :
		'op_add' 
		{ $$ = { parent: 'sign', children: ['op_add'] } }
	|
		'op_sub' 
		{ $$ = { parent: 'sign', children: ['op_sub'] } }
	;


