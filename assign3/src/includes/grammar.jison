%lex

%s BLOCKCOMMENT
%s COMMENT

%%

\/\*								this.pushState('BLOCKCOMMENT');

<BLOCKCOMMENT>\*\/					this.popState();

<BLOCKCOMMENT>(\n|\r|.)				/* SKIP BLOCKCOMMENTS */

\/\/								this.pushState('COMMENT');

<COMMENT>(.)						/* SKIP COMMENTS */

<COMMENT>(\n|\r)					this.popState();

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

[+]									return 'op_add';

[-]									return 'op_sub';

[*]									return 'op_mul';

[/]									return 'op_div';

[%]									return 'op_mod';

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

\'(\\[^\n\r]|[^\\\'\n\r])\'			return 'character_literal';

\"(\\[^\n\r]|[^\\\'\n\r])*\"		return 'string_literal';

([a-z]|[A-Z]|[$]|[_])(\w)*			return 'identifier';

[;]									return 'terminator';

[.]									return 'field_invoker';

[,]									return 'separator';

[(]									return 'paranthesis_start';

[)]									return 'paranthesis_end';

[\[]								return 'brackets_start';

[\]]								return 'brackets_end';

[{]									return 'set_start';

[}]									return 'set_end';

<<EOF>>								return 'EOF';

/lex


%start program
%% /* language grammar */


program :
		compilation_unit 
		{ return { nt: 'program', children: [$1] } }
	;


literal :
		'integer_literal' 
		{ $$ = { nt: 'literal', children: [{ t: 'integer_literal', l: $integer_literal }] } }
	|
		'float_literal' 
		{ $$ = { nt: 'literal', children: [{ t: 'float_literal', l: $float_literal }] } }
	|
		'boolean_literal' 
		{ $$ = { nt: 'literal', children: [{ t: 'boolean_literal', l: $boolean_literal }] } }
	|
		'character_literal' 
		{ $$ = { nt: 'literal', children: [{ t: 'character_literal', l: $character_literal }] } }
	|
		'string_literal' 
		{ $$ = { nt: 'literal', children: [{ t: 'string_literal', l: $string_literal }] } }
	|
		'null_literal' 
		{ $$ = { nt: 'literal', children: [{ t: 'null_literal', l: $null_literal }] } }
	;


type :
		primitive_type 
		{ $$ = { nt: 'type', children: [$1] } }
	|
		reference_type 
		{ $$ = { nt: 'type', children: [$1] } }
	;


primitive_type :
		numeric_type 
		{ $$ = { nt: 'primitive_type', children: [$1] } }
	|
		'boolean' 
		{ $$ = { nt: 'primitive_type', children: [{ t: 'boolean', l: $boolean }] } }
	;


numeric_type :
		integral_type 
		{ $$ = { nt: 'numeric_type', children: [$1] } }
	|
		floating_point_type 
		{ $$ = { nt: 'numeric_type', children: [$1] } }
	;


integral_type :
		'byte' 
		{ $$ = { nt: 'integral_type', children: [{ t: 'byte', l: $byte }] } }
	|
		'short' 
		{ $$ = { nt: 'integral_type', children: [{ t: 'short', l: $short }] } }
	|
		'int' 
		{ $$ = { nt: 'integral_type', children: [{ t: 'int', l: $int }] } }
	|
		'long' 
		{ $$ = { nt: 'integral_type', children: [{ t: 'long', l: $long }] } }
	|
		'char' 
		{ $$ = { nt: 'integral_type', children: [{ t: 'char', l: $char }] } }
	;


floating_point_type :
		'float' 
		{ $$ = { nt: 'floating_point_type', children: [{ t: 'float', l: $float }] } }
	|
		'double' 
		{ $$ = { nt: 'floating_point_type', children: [{ t: 'double', l: $double }] } }
	;


reference_type :
		class_type 
		{ $$ = { nt: 'reference_type', children: [$1] } }
	|
		array_type 
		{ $$ = { nt: 'reference_type', children: [$1] } }
	;


class_type :
		name 
		{ $$ = { nt: 'class_type', children: [$1] } }
	;


array_type :
		primitive_type 'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'array_type', children: [$1,{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	|
		name 'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'array_type', children: [$1,{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	|
		array_type 'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'array_type', children: [$1,{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	;


name :
		simple_name 
		{ $$ = { nt: 'name', children: [$1] } }
	|
		qualified_name 
		{ $$ = { nt: 'name', children: [$1] } }
	;


simple_name :
		'identifier' 
		{ $$ = { nt: 'simple_name', children: [{ t: 'identifier', l: $identifier }] } }
	;


qualified_name :
		name 'field_invoker' 'identifier' 
		{ $$ = { nt: 'qualified_name', children: [$1,{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier }] } }
	;


class_body_declarations :
		class_body_declaration 
		{ $$ = { nt: 'class_body_declarations', children: [$1] } }
	|
		class_body_declarations class_body_declaration 
		{ $$ = { nt: 'class_body_declarations', children: [$1,$2] } }
	;


class_member_declaration :
		field_declaration 
		{ $$ = { nt: 'class_member_declaration', children: [$1] } }
	|
		method_declaration 
		{ $$ = { nt: 'class_member_declaration', children: [$1] } }
	;


class_body :
		'set_start' class_body_declarations 'set_start' 
		{ $$ = { nt: 'class_body', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_start', l: $set_start }] } }
	|
		'set_start' 'set_start' 
		{ $$ = { nt: 'class_body', children: [{ t: 'set_start', l: $set_start },{ t: 'set_start', l: $set_start }] } }
	;


class_declaration :
		modifiers 'class' identifier super class_body 
		{ $$ = { nt: 'class_declaration', children: [$1,{ t: 'class', l: $class },$3,$4,$5] } }
	|
		'class' identifier super class_body 
		{ $$ = { nt: 'class_declaration', children: [{ t: 'class', l: $class },$2,$3,$4] } }
	|
		modifiers 'class' identifier class_body 
		{ $$ = { nt: 'class_declaration', children: [$1,{ t: 'class', l: $class },$3,$4] } }
	|
		'class' identifier class_body 
		{ $$ = { nt: 'class_declaration', children: [{ t: 'class', l: $class },$2,$3] } }
	;


class_body_declaration :
		class_member_declaration 
		{ $$ = { nt: 'class_body_declaration', children: [$1] } }
	|
		constructor_declaration 
		{ $$ = { nt: 'class_body_declaration', children: [$1] } }
	;


super :
		'extends' class_type 
		{ $$ = { nt: 'super', children: [{ t: 'extends', l: $extends },$2] } }
	;


variable_declarators :
		variable_declarator 
		{ $$ = { nt: 'variable_declarators', children: [$1] } }
	|
		variable_declarators 'separator' variable_declarator 
		{ $$ = { nt: 'variable_declarators', children: [$1,{ t: 'separator', l: $separator },$3] } }
	;


field_declaration :
		modifiers type variable_declarators 'terminator' 
		{ $$ = { nt: 'field_declaration', children: [$1,$2,$3,{ t: 'terminator', l: $terminator }] } }
	|
		type variable_declarators 'terminator' 
		{ $$ = { nt: 'field_declaration', children: [$1,$2,{ t: 'terminator', l: $terminator }] } }
	;


variable_initializer :
		expression 
		{ $$ = { nt: 'variable_initializer', children: [$1] } }
	|
		array_initializer 
		{ $$ = { nt: 'variable_initializer', children: [$1] } }
	;


variable_declarator_id :
		'identifier' 
		{ $$ = { nt: 'variable_declarator_id', children: [{ t: 'identifier', l: $identifier }] } }
	|
		variable_declarator_id 'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'variable_declarator_id', children: [$1,{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	;


variable_declarator :
		variable_declarator_id 
		{ $$ = { nt: 'variable_declarator', children: [$1] } }
	|
		variable_declarator_id 'op_assign' variable_initializer 
		{ $$ = { nt: 'variable_declarator', children: [$1,{ t: 'op_assign', l: $op_assign },$3] } }
	;


formal_parameter :
		type variable_declarator_id 
		{ $$ = { nt: 'formal_parameter', children: [$1,$2] } }
	;


formal_parameter_list :
		formal_parameter 
		{ $$ = { nt: 'formal_parameter_list', children: [$1] } }
	|
		formal_parameter_list 'separator' formal_parameter 
		{ $$ = { nt: 'formal_parameter_list', children: [$1,{ t: 'separator', l: $separator },$3] } }
	;


method_declaration :
		method_header method_body 
		{ $$ = { nt: 'method_declaration', children: [$1,$2] } }
	;


class_type_list :
		class_type 
		{ $$ = { nt: 'class_type_list', children: [$1] } }
	|
		class_type_list 'separator' class_type 
		{ $$ = { nt: 'class_type_list', children: [$1,{ t: 'separator', l: $separator },$3] } }
	;


method_header :
		modifiers type method_declarator 
		{ $$ = { nt: 'method_header', children: [$1,$2,$3] } }
	|
		modifiers oid method_declarator 
		{ $$ = { nt: 'method_header', children: [$1,$2,$3] } }
	|
		type method_declarator 
		{ $$ = { nt: 'method_header', children: [$1,$2] } }
	|
		oid method_declarator 
		{ $$ = { nt: 'method_header', children: [$1,$2] } }
	;


method_body :
		block 
		{ $$ = { nt: 'method_body', children: [$1] } }
	|
		'terminator' 
		{ $$ = { nt: 'method_body', children: [{ t: 'terminator', l: $terminator }] } }
	;


method_declarator :
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{ $$ = { nt: 'method_declarator', children: [{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		method_declarator 'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'method_declarator', children: [$1,{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	|
		'identifier' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'method_declarator', children: [{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	;


constructor_declarator :
		simple_name 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{ $$ = { nt: 'constructor_declarator', children: [$1,{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		simple_name 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'constructor_declarator', children: [$1,{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	;


explicit_constructor_invocation :
		'this' 'paranthesis_start' argument_list 'paranthesis_end'  
		{ $$ = { nt: 'explicit_constructor_invocation', children: [{ t: 'this', l: $this },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	|
		'super' 'paranthesis_start' argument_list 'paranthesis_end'  
		{ $$ = { nt: 'explicit_constructor_invocation', children: [{ t: 'super', l: $super },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	|
		'this' 'paranthesis_start' 'paranthesis_end'  
		{ $$ = { nt: 'explicit_constructor_invocation', children: [{ t: 'this', l: $this },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end },$4] } }
	|
		'super' 'paranthesis_start' 'paranthesis_end'  
		{ $$ = { nt: 'explicit_constructor_invocation', children: [{ t: 'super', l: $super },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end },$4] } }
	;


constructor_declaration :
		modifiers constructor_declarator throws constructor_body 
		{ $$ = { nt: 'constructor_declaration', children: [$1,$2,$3,$4] } }
	|
		constructor_declarator throws constructor_body 
		{ $$ = { nt: 'constructor_declaration', children: [$1,$2,$3] } }
	|
		modifiers constructor_declarator constructor_body 
		{ $$ = { nt: 'constructor_declaration', children: [$1,$2,$3] } }
	|
		constructor_declarator constructor_body 
		{ $$ = { nt: 'constructor_declaration', children: [$1,$2] } }
	;


constructor_body :
		'set_start' explicit_constructor_invocation block_statements 'set_end' 
		{ $$ = { nt: 'constructor_body', children: [{ t: 'set_start', l: $set_start },$2,$3,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' block_statements 'set_end' 
		{ $$ = { nt: 'constructor_body', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' explicit_constructor_invocation 'set_end' 
		{ $$ = { nt: 'constructor_body', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' 'set_end' 
		{ $$ = { nt: 'constructor_body', children: [{ t: 'set_start', l: $set_start },{ t: 'set_end', l: $set_end }] } }
	;


variable_initializers :
		variable_initializer 
		{ $$ = { nt: 'variable_initializers', children: [$1] } }
	|
		variable_initializers 'separator' variable_initializer 
		{ $$ = { nt: 'variable_initializers', children: [$1,{ t: 'separator', l: $separator },$3] } }
	;


array_initializer :
		 variable_initializers 'separator'  
		{ $$ = { nt: 'array_initializer', children: [$1,$2,{ t: 'separator', l: $separator },$4] } }
	|
		 variable_initializers  
		{ $$ = { nt: 'array_initializer', children: [$1,$2,$3] } }
	|
		 'separator'  
		{ $$ = { nt: 'array_initializer', children: [$1,{ t: 'separator', l: $separator },$3] } }
	|
		  
		{ $$ = { nt: 'array_initializer', children: [$1,$2] } }
	;


expression_statement :
		statement_expression 'terminator' 
		{ $$ = { nt: 'expression_statement', children: [$1,{ t: 'terminator', l: $terminator }] } }
	;


statement_no_short_if :
		statement_without_trailing_substatement 
		{ $$ = { nt: 'statement_no_short_if', children: [$1] } }
	|
		if_then_else_statement_no_short_if 
		{ $$ = { nt: 'statement_no_short_if', children: [$1] } }
	|
		while_statement_no_short_if 
		{ $$ = { nt: 'statement_no_short_if', children: [$1] } }
	|
		for_statement_no_short_if 
		{ $$ = { nt: 'statement_no_short_if', children: [$1] } }
	;


for_init :
		statement_expression_list 
		{ $$ = { nt: 'for_init', children: [$1] } }
	|
		local_variable_declaration 
		{ $$ = { nt: 'for_init', children: [$1] } }
	;


break_statement :
		'break' 'terminator' 
		{ $$ = { nt: 'break_statement', children: [{ t: 'break', l: $break },{ t: 'terminator', l: $terminator }] } }
	;


if_then_statement :
		'if' 'paranthesis_start' expression 'paranthesis_end' statement 
		{ $$ = { nt: 'if_then_statement', children: [{ t: 'if', l: $if },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	;


switch_statement :
		'switch' 'paranthesis_start' expression 'paranthesis_end' switch_block 
		{ $$ = { nt: 'switch_statement', children: [{ t: 'switch', l: $switch },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	;


switch_block_statement_groups :
		switch_block_statement_group 
		{ $$ = { nt: 'switch_block_statement_groups', children: [$1] } }
	|
		switch_block_statement_groups switch_block_statement_group 
		{ $$ = { nt: 'switch_block_statement_groups', children: [$1,$2] } }
	;


block_statement :
		local_variable_declaration_statement 
		{ $$ = { nt: 'block_statement', children: [$1] } }
	|
		statement 
		{ $$ = { nt: 'block_statement', children: [$1] } }
	;


switch_labels :
		switch_label 
		{ $$ = { nt: 'switch_labels', children: [$1] } }
	|
		switch_labels switch_label 
		{ $$ = { nt: 'switch_labels', children: [$1,$2] } }
	;


return_statement :
		'return' expression 'terminator' 
		{ $$ = { nt: 'return_statement', children: [{ t: 'return', l: $return },$2,{ t: 'terminator', l: $terminator }] } }
	|
		'return' 'terminator' 
		{ $$ = { nt: 'return_statement', children: [{ t: 'return', l: $return },{ t: 'terminator', l: $terminator }] } }
	;


while_statement :
		'while' 'paranthesis_start' expression 'paranthesis_end' statement 
		{ $$ = { nt: 'while_statement', children: [{ t: 'while', l: $while },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	;


continue_statement :
		'continue' 'terminator' 
		{ $$ = { nt: 'continue_statement', children: [{ t: 'continue', l: $continue },{ t: 'terminator', l: $terminator }] } }
	;


do_statement :
		'do' statement 'while' 'paranthesis_start' expression 'paranthesis_end' 'terminator' 
		{ $$ = { nt: 'do_statement', children: [{ t: 'do', l: $do },$2,{ t: 'while', l: $while },{ t: 'paranthesis_start', l: $paranthesis_start },$5,{ t: 'paranthesis_end', l: $paranthesis_end },{ t: 'terminator', l: $terminator }] } }
	;


statement :
		statement_without_trailing_substatement 
		{ $$ = { nt: 'statement', children: [$1] } }
	|
		labeled_statement 
		{ $$ = { nt: 'statement', children: [$1] } }
	|
		if_then_statement 
		{ $$ = { nt: 'statement', children: [$1] } }
	|
		if_then_else_statement 
		{ $$ = { nt: 'statement', children: [$1] } }
	|
		while_statement 
		{ $$ = { nt: 'statement', children: [$1] } }
	|
		for_statement 
		{ $$ = { nt: 'statement', children: [$1] } }
	;


statement_expression :
		assignment 
		{ $$ = { nt: 'statement_expression', children: [$1] } }
	|
		pre_increment_expression 
		{ $$ = { nt: 'statement_expression', children: [$1] } }
	|
		pre_decrement_expression 
		{ $$ = { nt: 'statement_expression', children: [$1] } }
	|
		post_increment_expression 
		{ $$ = { nt: 'statement_expression', children: [$1] } }
	|
		post_decrement_expression 
		{ $$ = { nt: 'statement_expression', children: [$1] } }
	|
		method_invocation 
		{ $$ = { nt: 'statement_expression', children: [$1] } }
	|
		class_instance_creation_expression 
		{ $$ = { nt: 'statement_expression', children: [$1] } }
	;


while_statement_no_short_if :
		hile 'paranthesis_start' expression 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'while_statement_no_short_if', children: [$1,{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	;


block_statements :
		block_statement 
		{ $$ = { nt: 'block_statements', children: [$1] } }
	|
		block_statements block_statement 
		{ $$ = { nt: 'block_statements', children: [$1,$2] } }
	;


for_statement :
		'for' 'paranthesis_start' for_init 'terminator' expression 'terminator' for_update 'paranthesis_end' statement 
		{ $$ = { nt: 'for_statement', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'terminator', l: $terminator },$5,{ t: 'terminator', l: $terminator },$7,{ t: 'paranthesis_end', l: $paranthesis_end },$9] } }
	|
		'for' 'paranthesis_start' 'terminator' expression 'terminator' for_update 'paranthesis_end' statement 
		{ $$ = { nt: 'for_statement', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'terminator', l: $terminator },$4,{ t: 'terminator', l: $terminator },$6,{ t: 'paranthesis_end', l: $paranthesis_end },$8] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' for_update 'paranthesis_end' statement 
		{ $$ = { nt: 'for_statement', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'terminator', l: $terminator },{ t: 'terminator', l: $terminator },$6,{ t: 'paranthesis_end', l: $paranthesis_end },$8] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' expression 'terminator' 'paranthesis_end' statement 
		{ $$ = { nt: 'for_statement', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'terminator', l: $terminator },$5,{ t: 'terminator', l: $terminator },{ t: 'paranthesis_end', l: $paranthesis_end },$8] } }
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' for_update 'paranthesis_end' statement 
		{ $$ = { nt: 'for_statement', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'terminator', l: $terminator },{ t: 'terminator', l: $terminator },$5,{ t: 'paranthesis_end', l: $paranthesis_end },$7] } }
	|
		'for' 'paranthesis_start' 'terminator' expression 'terminator' 'paranthesis_end' statement 
		{ $$ = { nt: 'for_statement', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'terminator', l: $terminator },$4,{ t: 'terminator', l: $terminator },{ t: 'paranthesis_end', l: $paranthesis_end },$7] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' 'paranthesis_end' statement 
		{ $$ = { nt: 'for_statement', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'terminator', l: $terminator },{ t: 'terminator', l: $terminator },{ t: 'paranthesis_end', l: $paranthesis_end },$7] } }
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' 'paranthesis_end' statement 
		{ $$ = { nt: 'for_statement', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'terminator', l: $terminator },{ t: 'terminator', l: $terminator },{ t: 'paranthesis_end', l: $paranthesis_end },$6] } }
	;


local_variable_declaration_statement :
		local_variable_declaration 'terminator' 
		{ $$ = { nt: 'local_variable_declaration_statement', children: [$1,{ t: 'terminator', l: $terminator }] } }
	;


for_statement_no_short_if :
		'for' 'paranthesis_start' for_init 'terminator' expression 'terminator' for_update 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'for_statement_no_short_if', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'terminator', l: $terminator },$5,{ t: 'terminator', l: $terminator },$7,{ t: 'paranthesis_end', l: $paranthesis_end },$9] } }
	|
		'for' 'paranthesis_start' 'terminator' expression 'terminator' for_update 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'for_statement_no_short_if', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'terminator', l: $terminator },$4,{ t: 'terminator', l: $terminator },$6,{ t: 'paranthesis_end', l: $paranthesis_end },$8] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' for_update 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'for_statement_no_short_if', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'terminator', l: $terminator },{ t: 'terminator', l: $terminator },$6,{ t: 'paranthesis_end', l: $paranthesis_end },$8] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' expression 'terminator' 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'for_statement_no_short_if', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'terminator', l: $terminator },$5,{ t: 'terminator', l: $terminator },{ t: 'paranthesis_end', l: $paranthesis_end },$8] } }
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' for_update 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'for_statement_no_short_if', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'terminator', l: $terminator },{ t: 'terminator', l: $terminator },$5,{ t: 'paranthesis_end', l: $paranthesis_end },$7] } }
	|
		'for' 'paranthesis_start' 'terminator' expression 'terminator' 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'for_statement_no_short_if', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'terminator', l: $terminator },$4,{ t: 'terminator', l: $terminator },{ t: 'paranthesis_end', l: $paranthesis_end },$7] } }
	|
		'for' 'paranthesis_start' for_init 'terminator' 'terminator' 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'for_statement_no_short_if', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'terminator', l: $terminator },{ t: 'terminator', l: $terminator },{ t: 'paranthesis_end', l: $paranthesis_end },$7] } }
	|
		'for' 'paranthesis_start' 'terminator' 'terminator' 'paranthesis_end' statement_no_short_if 
		{ $$ = { nt: 'for_statement_no_short_if', children: [{ t: 'for', l: $for },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'terminator', l: $terminator },{ t: 'terminator', l: $terminator },{ t: 'paranthesis_end', l: $paranthesis_end },$6] } }
	;


statement_without_trailing_substatement :
		block 
		{ $$ = { nt: 'statement_without_trailing_substatement', children: [$1] } }
	|
		empty_statement 
		{ $$ = { nt: 'statement_without_trailing_substatement', children: [$1] } }
	|
		expression_statement 
		{ $$ = { nt: 'statement_without_trailing_substatement', children: [$1] } }
	|
		switch_statement 
		{ $$ = { nt: 'statement_without_trailing_substatement', children: [$1] } }
	|
		do_statement 
		{ $$ = { nt: 'statement_without_trailing_substatement', children: [$1] } }
	|
		break_statement 
		{ $$ = { nt: 'statement_without_trailing_substatement', children: [$1] } }
	|
		continue_statement 
		{ $$ = { nt: 'statement_without_trailing_substatement', children: [$1] } }
	|
		return_statement 
		{ $$ = { nt: 'statement_without_trailing_substatement', children: [$1] } }
	;


for_update :
		statement_expression_list 
		{ $$ = { nt: 'for_update', children: [$1] } }
	;


statement_expression_list :
		statement_expression 
		{ $$ = { nt: 'statement_expression_list', children: [$1] } }
	|
		statement_expression_list 'separator' statement_expression 
		{ $$ = { nt: 'statement_expression_list', children: [$1,{ t: 'separator', l: $separator },$3] } }
	;


switch_label :
		'case' constant_expression 'colon' 
		{ $$ = { nt: 'switch_label', children: [{ t: 'case', l: $case },$2,{ t: 'colon', l: $colon }] } }
	|
		'default' 'colon' 
		{ $$ = { nt: 'switch_label', children: [{ t: 'default', l: $default },{ t: 'colon', l: $colon }] } }
	;


switch_block_statement_group :
		switch_labels block_statements 
		{ $$ = { nt: 'switch_block_statement_group', children: [$1,$2] } }
	;


empty_statement :
		'terminator' 
		{ $$ = { nt: 'empty_statement', children: [{ t: 'terminator', l: $terminator }] } }
	;


if_then_else_statement_no_short_if :
		'if' 'paranthesis_start' expression 'paranthesis_end' statement_no_short_if lse statement_no_short_if 
		{ $$ = { nt: 'if_then_else_statement_no_short_if', children: [{ t: 'if', l: $if },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5,$6,$7] } }
	;


switch_block :
		'set_start' switch_block_statement_groups switch_labels 'set_end' 
		{ $$ = { nt: 'switch_block', children: [{ t: 'set_start', l: $set_start },$2,$3,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' switch_labels 'set_end' 
		{ $$ = { nt: 'switch_block', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' switch_block_statement_groups 'set_end' 
		{ $$ = { nt: 'switch_block', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' 'set_end' 
		{ $$ = { nt: 'switch_block', children: [{ t: 'set_start', l: $set_start },{ t: 'set_end', l: $set_end }] } }
	;


local_variable_declaration :
		type variable_declarators 
		{ $$ = { nt: 'local_variable_declaration', children: [$1,$2] } }
	;


block :
		'set_start' block_statements 'set_end' 
		{ $$ = { nt: 'block', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' 'set_end' 
		{ $$ = { nt: 'block', children: [{ t: 'set_start', l: $set_start },{ t: 'set_end', l: $set_end }] } }
	;


if_then_else_statement :
		'if' 'paranthesis_start' expression 'paranthesis_end' statement_no_short_if lse statement 
		{ $$ = { nt: 'if_then_else_statement', children: [{ t: 'if', l: $if },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5,$6,$7] } }
	;


sign :
		'op_add' 
		{ $$ = { nt: 'sign', children: [{ t: 'op_add', l: $op_add }] } }
	|
		'op_sub' 
		{ $$ = { nt: 'sign', children: [{ t: 'op_sub', l: $op_sub }] } }
	;


unary_expression :
		pre_increment_expression 
		{ $$ = { nt: 'unary_expression', children: [$1] } }
	|
		pre_decrement_expression 
		{ $$ = { nt: 'unary_expression', children: [$1] } }
	|
		sign unary_expression 
		{ $$ = { nt: 'unary_expression', children: [$1,$2] } }
	|
		unary_expression_not_plus_minus 
		{ $$ = { nt: 'unary_expression', children: [$1] } }
	;


exclusive_or_expression :
		and_expression 
		{ $$ = { nt: 'exclusive_or_expression', children: [$1] } }
	|
		exclusive_or_expression 'op_xor' and_expression 
		{ $$ = { nt: 'exclusive_or_expression', children: [$1,{ t: 'op_xor', l: $op_xor },$3] } }
	;


left_hand_side :
		name 
		{ $$ = { nt: 'left_hand_side', children: [$1] } }
	|
		field_access 
		{ $$ = { nt: 'left_hand_side', children: [$1] } }
	|
		array_access 
		{ $$ = { nt: 'left_hand_side', children: [$1] } }
	;


primary :
		primary_no_new_array 
		{ $$ = { nt: 'primary', children: [$1] } }
	|
		array_creation_expression 
		{ $$ = { nt: 'primary', children: [$1] } }
	;


unary_expression_not_plus_minus :
		postfix_expression 
		{ $$ = { nt: 'unary_expression_not_plus_minus', children: [$1] } }
	|
		'op_not' unary_expression 
		{ $$ = { nt: 'unary_expression_not_plus_minus', children: [{ t: 'op_not', l: $op_not },$2] } }
	|
		cast_expression 
		{ $$ = { nt: 'unary_expression_not_plus_minus', children: [$1] } }
	;


array_creation_expression :
		'new' primitive_type dim_exprs dims 
		{ $$ = { nt: 'array_creation_expression', children: [{ t: 'new', l: $new },$2,$3,$4] } }
	|
		'new' class_type dim_exprs dims 
		{ $$ = { nt: 'array_creation_expression', children: [{ t: 'new', l: $new },$2,$3,$4] } }
	|
		'new' primitive_type dim_exprs 
		{ $$ = { nt: 'array_creation_expression', children: [{ t: 'new', l: $new },$2,$3] } }
	|
		'new' class_type dim_exprs 
		{ $$ = { nt: 'array_creation_expression', children: [{ t: 'new', l: $new },$2,$3] } }
	;


dim_exprs :
		dim_expr 
		{ $$ = { nt: 'dim_exprs', children: [$1] } }
	|
		dim_exprs dim_expr 
		{ $$ = { nt: 'dim_exprs', children: [$1,$2] } }
	;


post_decrement_expression :
		postfix_expression 'op_decrement' 
		{ $$ = { nt: 'post_decrement_expression', children: [$1,{ t: 'op_decrement', l: $op_decrement }] } }
	;


additive_expression :
		multiplicative_expression 
		{ $$ = { nt: 'additive_expression', children: [$1] } }
	|
		additive_expression 'op_add' multiplicative_expression 
		{ $$ = { nt: 'additive_expression', children: [$1,{ t: 'op_add', l: $op_add },$3] } }
	|
		additive_expression 'op_sub' multiplicative_expression 
		{ $$ = { nt: 'additive_expression', children: [$1,{ t: 'op_sub', l: $op_sub },$3] } }
	;


dim_expr :
		'brackets_start' expression 'brackets_end' 
		{ $$ = { nt: 'dim_expr', children: [{ t: 'brackets_start', l: $brackets_start },$2,{ t: 'brackets_end', l: $brackets_end }] } }
	;


array_access :
		name 'brackets_start' expression 'brackets_end' 
		{ $$ = { nt: 'array_access', children: [$1,{ t: 'brackets_start', l: $brackets_start },$3,{ t: 'brackets_end', l: $brackets_end }] } }
	|
		primary_no_new_array 'brackets_start' expression 'brackets_end' 
		{ $$ = { nt: 'array_access', children: [$1,{ t: 'brackets_start', l: $brackets_start },$3,{ t: 'brackets_end', l: $brackets_end }] } }
	;


postfix_expression :
		primary 
		{ $$ = { nt: 'postfix_expression', children: [$1] } }
	|
		name 
		{ $$ = { nt: 'postfix_expression', children: [$1] } }
	|
		post_increment_expression 
		{ $$ = { nt: 'postfix_expression', children: [$1] } }
	|
		post_decrement_expression 
		{ $$ = { nt: 'postfix_expression', children: [$1] } }
	;


primary_no_new_array :
		literal 
		{ $$ = { nt: 'primary_no_new_array', children: [$1] } }
	|
		'this' 
		{ $$ = { nt: 'primary_no_new_array', children: [{ t: 'this', l: $this }] } }
	|
		'paranthesis_start' expression 'paranthesis_end' 
		{ $$ = { nt: 'primary_no_new_array', children: [{ t: 'paranthesis_start', l: $paranthesis_start },$2,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		class_instance_creation_expression 
		{ $$ = { nt: 'primary_no_new_array', children: [$1] } }
	|
		field_access 
		{ $$ = { nt: 'primary_no_new_array', children: [$1] } }
	|
		method_invocation 
		{ $$ = { nt: 'primary_no_new_array', children: [$1] } }
	|
		array_access 
		{ $$ = { nt: 'primary_no_new_array', children: [$1] } }
	;


and_expression :
		equality_expression 
		{ $$ = { nt: 'and_expression', children: [$1] } }
	|
		and_expression 'op_and' equality_expression 
		{ $$ = { nt: 'and_expression', children: [$1,{ t: 'op_and', l: $op_and },$3] } }
	;


argument_list :
		expression 
		{ $$ = { nt: 'argument_list', children: [$1] } }
	|
		argument_list 'separator' expression 
		{ $$ = { nt: 'argument_list', children: [$1,{ t: 'separator', l: $separator },$3] } }
	;


cast_expression :
		'paranthesis_start' primitive_type dims 'paranthesis_end' unary_expression 
		{ $$ = { nt: 'cast_expression', children: [{ t: 'paranthesis_start', l: $paranthesis_start },$2,$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	|
		'paranthesis_start' expression 'paranthesis_end' unary_expression_not_plus_minus 
		{ $$ = { nt: 'cast_expression', children: [{ t: 'paranthesis_start', l: $paranthesis_start },$2,{ t: 'paranthesis_end', l: $paranthesis_end },$4] } }
	|
		'paranthesis_start' name dims 'paranthesis_end' unary_expression_not_plus_minus 
		{ $$ = { nt: 'cast_expression', children: [{ t: 'paranthesis_start', l: $paranthesis_start },$2,$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	|
		'paranthesis_start' primitive_type 'paranthesis_end' unary_expression 
		{ $$ = { nt: 'cast_expression', children: [{ t: 'paranthesis_start', l: $paranthesis_start },$2,{ t: 'paranthesis_end', l: $paranthesis_end },$4] } }
	;


conditional_or_expression :
		conditional_and_expression 
		{ $$ = { nt: 'conditional_or_expression', children: [$1] } }
	|
		conditional_or_expression 'op_oror' conditional_and_expression 
		{ $$ = { nt: 'conditional_or_expression', children: [$1,{ t: 'op_oror', l: $op_oror },$3] } }
	;


constant_expression :
		expression 
		{ $$ = { nt: 'constant_expression', children: [$1] } }
	;


relational_expression :
		shift_expression 
		{ $$ = { nt: 'relational_expression', children: [$1] } }
	|
		relational_expression 'op_less' shift_expression 
		{ $$ = { nt: 'relational_expression', children: [$1,{ t: 'op_less', l: $op_less },$3] } }
	|
		relational_expression 'op_greater' shift_expression 
		{ $$ = { nt: 'relational_expression', children: [$1,{ t: 'op_greater', l: $op_greater },$3] } }
	|
		relational_expression 'op_lessEqual' shift_expression 
		{ $$ = { nt: 'relational_expression', children: [$1,{ t: 'op_lessEqual', l: $op_lessEqual },$3] } }
	|
		relational_expression 'op_greaterEqual' shift_expression 
		{ $$ = { nt: 'relational_expression', children: [$1,{ t: 'op_greaterEqual', l: $op_greaterEqual },$3] } }
	|
		relational_expression 'instanceof' reference_type 
		{ $$ = { nt: 'relational_expression', children: [$1,{ t: 'instanceof', l: $instanceof },$3] } }
	;


field_access :
		primary 'field-invoker' identifier 
		{ $$ = { nt: 'field_access', children: [$1,{ t: 'field-invoker', l: $field-invoker },$3] } }
	|
		'super' 'field-invoker' identifier 
		{ $$ = { nt: 'field_access', children: [{ t: 'super', l: $super },{ t: 'field-invoker', l: $field-invoker },$3] } }
	;


assignment_expression :
		conditional_or_expression 
		{ $$ = { nt: 'assignment_expression', children: [$1] } }
	|
		assignment 
		{ $$ = { nt: 'assignment_expression', children: [$1] } }
	;


assignment :
		left_hand_side assignment_operator assignment_expression 
		{ $$ = { nt: 'assignment', children: [$1,$2,$3] } }
	;


multiplicative_expression :
		unary_expression 
		{ $$ = { nt: 'multiplicative_expression', children: [$1] } }
	|
		multiplicative_expression 'op_mul' unary_expression 
		{ $$ = { nt: 'multiplicative_expression', children: [$1,{ t: 'op_mul', l: $op_mul },$3] } }
	|
		multiplicative_expression 'op_div' unary_expression 
		{ $$ = { nt: 'multiplicative_expression', children: [$1,{ t: 'op_div', l: $op_div },$3] } }
	|
		multiplicative_expression 'op_mod' unary_expression 
		{ $$ = { nt: 'multiplicative_expression', children: [$1,{ t: 'op_mod', l: $op_mod },$3] } }
	;


dims :
		'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'dims', children: [{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	|
		dims 'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'dims', children: [$1,{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	;


equality_expression :
		relational_expression 
		{ $$ = { nt: 'equality_expression', children: [$1] } }
	|
		equality_expression 'op_equalCompare' relational_expression 
		{ $$ = { nt: 'equality_expression', children: [$1,{ t: 'op_equalCompare', l: $op_equalCompare },$3] } }
	|
		equality_expression 'op_notequalCompare' relational_expression 
		{ $$ = { nt: 'equality_expression', children: [$1,{ t: 'op_notequalCompare', l: $op_notequalCompare },$3] } }
	;


method_invocation :
		name 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		primary 'field-invoker' identifier 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'field-invoker', l: $field-invoker },$3,{ t: 'paranthesis_start', l: $paranthesis_start },$5,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'super' 'field-invoker' identifier 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [{ t: 'super', l: $super },{ t: 'field-invoker', l: $field-invoker },$3,{ t: 'paranthesis_start', l: $paranthesis_start },$5,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		name 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		primary 'field-invoker' identifier 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'field-invoker', l: $field-invoker },$3,{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'super' 'field-invoker' identifier 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [{ t: 'super', l: $super },{ t: 'field-invoker', l: $field-invoker },$3,{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	;


shift_expression :
		additive_expression 
		{ $$ = { nt: 'shift_expression', children: [$1] } }
	|
		shift_expression 'op_Lshift' additive_expression 
		{ $$ = { nt: 'shift_expression', children: [$1,{ t: 'op_Lshift', l: $op_Lshift },$3] } }
	|
		shift_expression 'op_Rshift' additive_expression 
		{ $$ = { nt: 'shift_expression', children: [$1,{ t: 'op_Rshift', l: $op_Rshift },$3] } }
	;


class_instance_creation_expression :
		'new' class_type 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'class_instance_creation_expression', children: [{ t: 'new', l: $new },$2,{ t: 'paranthesis_start', l: $paranthesis_start },$4,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'new' class_type 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'class_instance_creation_expression', children: [{ t: 'new', l: $new },$2,{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	;


inclusive_or_expression :
		exclusive_or_expression 
		{ $$ = { nt: 'inclusive_or_expression', children: [$1] } }
	|
		inclusive_or_expression 'op_or' exclusive_or_expression 
		{ $$ = { nt: 'inclusive_or_expression', children: [$1,{ t: 'op_or', l: $op_or },$3] } }
	;


pre_increment_expression :
		'op_increment' unary_expression 
		{ $$ = { nt: 'pre_increment_expression', children: [{ t: 'op_increment', l: $op_increment },$2] } }
	;


post_increment_expression :
		postfix_expression 'op_increment' 
		{ $$ = { nt: 'post_increment_expression', children: [$1,{ t: 'op_increment', l: $op_increment }] } }
	;


assignment_operator :
		'op_assign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_assign', l: $op_assign }] } }
	|
		'op_mulAssign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_mulAssign', l: $op_mulAssign }] } }
	|
		'op_divAssign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_divAssign', l: $op_divAssign }] } }
	|
		'op_modAssign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_modAssign', l: $op_modAssign }] } }
	|
		'op_addAssign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_addAssign', l: $op_addAssign }] } }
	|
		'op_subAssign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_subAssign', l: $op_subAssign }] } }
	|
		'op_LshiftEqual' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_LshiftEqual', l: $op_LshiftEqual }] } }
	|
		'op_RshiftEqual' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_RshiftEqual', l: $op_RshiftEqual }] } }
	|
		'op_andAssign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_andAssign', l: $op_andAssign }] } }
	|
		'op_orAssign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_orAssign', l: $op_orAssign }] } }
	|
		'op_xorAssig' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_xorAssig', l: $op_xorAssig }] } }
	;


pre_decrement_expression :
		'op_decrement' unary_expression 
		{ $$ = { nt: 'pre_decrement_expression', children: [{ t: 'op_decrement', l: $op_decrement },$2] } }
	;


expression :
		assignment_expression 
		{ $$ = { nt: 'expression', children: [$1] } }
	;


conditional_and_expression :
		inclusive_or_expression 
		{ $$ = { nt: 'conditional_and_expression', children: [$1] } }
	|
		conditional_and_expression 'op_andand' inclusive_or_expression 
		{ $$ = { nt: 'conditional_and_expression', children: [$1,{ t: 'op_andand', l: $op_andand },$3] } }
	;


import_declaration :
		'import' name 'terminator' 
		{ $$ = { nt: 'import_declaration', children: [{ t: 'import', l: $import },$2,{ t: 'terminator', l: $terminator }] } }
	;


type_declarations :
		type_declaration 
		{ $$ = { nt: 'type_declarations', children: [$1] } }
	|
		type_declarations type_declaration 
		{ $$ = { nt: 'type_declarations', children: [$1,$2] } }
	;


import_declarations :
		import_declaration 
		{ $$ = { nt: 'import_declarations', children: [$1] } }
	|
		import_declarations import_declaration 
		{ $$ = { nt: 'import_declarations', children: [$1,$2] } }
	;


compilation_unit :
		import_declarations type_declarations 
		{ $$ = { nt: 'compilation_unit', children: [$1,$2] } }
	|
		type_declarations 
		{ $$ = { nt: 'compilation_unit', children: [$1] } }
	|
		import_declarations 
		{ $$ = { nt: 'compilation_unit', children: [$1] } }
	|
		
		{ $$ = { nt: 'compilation_unit', children: [] } }
	;


type_declaration :
		class_declaration 
		{ $$ = { nt: 'type_declaration', children: [$1] } }
	|
		'terminator' 
		{ $$ = { nt: 'type_declaration', children: [{ t: 'terminator', l: $terminator }] } }
	;


