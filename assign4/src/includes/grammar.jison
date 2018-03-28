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
		type_decrs 'EOF' 
		{
			return { nt: 'program', children: [$1,{ t: 'EOF', l: $EOF }] } 
		}
	|
		'EOF' 
		{ return { nt: 'program', children: [{ t: 'EOF', l: $EOF }] } }
	;


import_decrs :
		import_decr 
		{ $$ = { nt: 'import_decrs', children: [$1] } }
	|
		import_decrs import_decr 
		{ $$ = { nt: 'import_decrs', children: [$1,$2] } }
	;


import_decr :
		'import' 'identifier' 'terminator' 
		{ $$ = { nt: 'import_decr', children: [{ t: 'import', l: $import },{ t: 'identifier', l: $identifier },{ t: 'terminator', l: $terminator }] } }
	;


type_decrs :
		type_decrs type_decr 
		{
			$$ = null
		}
	|
		type_decr 
		{
			$$ = null
		}
	;


type_decr :
		class_decr 
		{
			$$ = null
		}
	|
		'terminator' 
		{
			$$ = null
		}
	;


class_decr :
		class_header class_body 
		{
			$$ = null
		}
	;


class_header :
		'public' 'class' 'identifier' extend_decr
		{
			ST.add_class($identifier, $4)
			$$ = null
		}
	|
		'class' 'identifier' extend_decr 
		{
			ST.add_class($identifier, $3)
			$$ = null
		}
	|
		'public' 'class' 'identifier' 
		{
			ST.add_class($identifier, "")
			$$ = null
		}
	|
		'class' 'identifier' 
		{
			ST.add_class($identifier, "")
			$$ = null
		}
	;


extend_decr :
		'extends' 'identifier' 
		{
			$$ = $identifier
		}
	;


class_body :
		'set_start' class_body_decrs 'set_end' 
		{
			$$ = null
		}
	;


class_body_decrs :
		class_body_decrs class_body_decr 
		{
			$$ = null
		}
	|
		class_body_decr 
		{
			$$ = null
		}
	;


class_body_decr :
		class_member_decr 
		{
			$$ = null
		}
	|
		'public' consr_declarator consr_body 
		{ $$ = { nt: 'class_body_decr', children: [{ t: 'public', l: $public },$2,$3] } }
	|
		consr_declarator consr_body 
		{ $$ = { nt: 'class_body_decr', children: [$1,$2] } }
	;


class_member_decr :
		field_decr 
		{
			$$ = null
		}
	|
		method_decr 
		{
			$$ = null
		}
	;


consr_declarator :
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{
			param_types = []
			$3.forEach(function(param) {
				param_types.push(param[0])
			})

			ST.insert_constructor($identifier, param_types)
		}
	;


formal_parameter_list :
		formal_parameter_list 'separator' formal_parameter 
		{
			$$ = $1
			$$.push($3)
		}
	|
		formal_parameter 
		{
			$$ = [$1]
		}
	|
		
		{
			$$ = []
		}
	;


formal_parameter :
		type var_declarator_id 
		{
			$$ = new Variable($2, $1)
		}
	;


consr_body :
		'set_start' explicit_consr_invocation block_stmts 'set_end' 
		{ $$ = { nt: 'consr_body', children: [{ t: 'set_start', l: $set_start },$2,$3,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' block_stmts 'set_end' 
		{ $$ = { nt: 'consr_body', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' explicit_consr_invocation 'set_end' 
		{ $$ = { nt: 'consr_body', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' 'set_end' 
		{ $$ = { nt: 'consr_body', children: [{ t: 'set_start', l: $set_start },{ t: 'set_end', l: $set_end }] } }
	;


explicit_consr_invocation :
		'this' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'explicit_consr_invocation', children: [{ t: 'this', l: $this },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'super' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'explicit_consr_invocation', children: [{ t: 'super', l: $super },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'this' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'explicit_consr_invocation', children: [{ t: 'this', l: $this },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'super' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'explicit_consr_invocation', children: [{ t: 'super', l: $super },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	;


field_decr :
		'public' type var_declarators 'terminator' 
		{
			$3.forEach(function(var_decr) {
				ST.add_variable(var_decr[0], $2);
			})
			$$ = null
		}
	|
		type var_declarators 'terminator' 
		{
			$2.forEach(function(var_decr) {
				ST.add_variable(var_decr[0] , $1);
			})
			$$ = null
		}
	;


var_declarators :
		var_declarators 'separator' var_declarator 
		{
			$$ = $1
			$$.push($3)
		}
	|
		var_declarator 
		{
			$$ = [$1]
		}
	;


var_declarator :
		var_declarator_id 
		{
			$$ = [$1, null]
		}
	|
		var_declarator_id 'op_assign' var_init 
		{
			$$ = [$1, $3]
		}
	;


var_declarator_id :
		var_declarator_id 'brackets_start' 'brackets_end' 
		{
			$$ = $1
		}
	|
		'identifier' 
		{
			$$ = $identifier
		}
	;


var_init :
		expr 
		{ $$ = { nt: 'var_init', children: [$1] } }
	|
		array_init 
		{ $$ = { nt: 'var_init', children: [$1] } }
	;


method_decr :
		'public' 'void' method_declarator method_body 
		{
			ST.add_method($3.name, new Type("void", "basic", 0, null), $3.parameters, $4, main = false)
			$$ = null
		}
	|
		'public' type method_declarator method_body 
		{
			ST.add_method($3.name, $2, $3.parameters, $4, main = false)
			$$ = null
		}
	|
		'void' method_declarator method_body 
		{
			ST.add_method($2.name, new Type("void", "basic", 0, null), $2.parameters, $3, main = false)
			$$ = null
		}
	|
		type method_declarator method_body 
		{
			ST.add_method($2.name, $1, $2.parameters, $3, main = false)
			$$ = null
		}
	;


method_declarator :
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{
			$$ = {
				name: $identifier,
				parameters: $3
			}
		}
	;


method_body :
		block 
		{
			$$ = new ScopeTable(ST.current_class, ST.current_class)
		}
	;


array_init :
		'set_start' var_inits 'separator' 'set_end' 
		{ $$ = { nt: 'array_init', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'separator', l: $separator },{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' var_inits 'set_end' 
		{ $$ = { nt: 'array_init', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' 'separator' 'set_end' 
		{ $$ = { nt: 'array_init', children: [{ t: 'set_start', l: $set_start },{ t: 'separator', l: $separator },{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' 'set_end' 
		{ $$ = { nt: 'array_init', children: [{ t: 'set_start', l: $set_start },{ t: 'set_end', l: $set_end }] } }
	;


var_inits :
		var_inits 'separator' var_init 
		{ $$ = { nt: 'var_inits', children: [$1,{ t: 'separator', l: $separator },$3] } }
	|
		var_init 
		{ $$ = { nt: 'var_inits', children: [$1] } }
	;


type :
		primitive_type 
		{
			$$ = new Type($1.type, $1.category, $1.width, $1.length)
		}
	|
		reference_type 
		{
			$$ = new Type($1.type, $1.category, $1.width, $1.length)
		}
	;


primitive_type :
		integral_type 
		{
			$$ = $1
		}
	|
		floating_type 
		{
			$$ = $1
		}
	|
		'boolean' 
		{
			$$ = {
				type: "boolean",
				category: "basic",
				width: 1,
				length: null
			}
		}
	;


integral_type :
		'byte' 
		{
			$$ = {
				type: "byte",
				category: "basic",
				width: 1,
				length: null
			}
		}
	|
		'short' 
		{
			$$ = {
				type: "short",
				category: "basic",
				width: 2,
				length: null
			}
		}
	|
		'int' 
		{
			$$ = {
				type: "int",
				category: "basic",
				width: 4,
				length: null
			}
		}
	|
		'long' 
		{
			$$ = {
				type: "long",
				category: "basic",
				width: 8,
				length: null
			}
		}
	|
		'char' 
		{
			$$ = {
				type: "char",
				category: "basic",
				width: 1,
				length: null
			}
		}
	;


floating_type :
		'float' 
		{
			$$ = {
				type: "float",
				category: "basic",
				width: 4,
				length: null
			}
		}
	|
		'double' 
		{
			$$ = {
				type: "boolean",
				category: "basic",
				width: 8,
				length: null
			}
		}
	;


reference_type :
		'identifier' 
		{
			$$ = {
				type: ST.get_class($identifier),
				category: "object",
				width: null,
				length: null
			}
		}
	|
		type 'brackets_start' 'brackets_end' 
		{
			$$ = {
				type: $1,
				category: "array",
				width: null,
				length: 0
			}
		}
	;


block :
		'set_start' block_scope_start block_stmts 'set_end' 
		{
			$$ = $3
			// ST.end_scope()
		}
	|
		'set_start' 'set_end' 
		{
			$$ = []
		}
	;

block_scope_start :

		{
			$$ = null
			// ST.begin_scope()
		}
	;


block_stmts :
		block_stmts block_stmt 
		{ $$ = { nt: 'block_stmts', children: [$1,$2] } }
	|
		block_stmt 
		{ $$ = { nt: 'block_stmts', children: [$1] } }
	;


block_stmt :
		type var_declarators 'terminator' 
		{
			$2.forEach(function(var_decr) {
				ST.insert_variable($1, var_decr[0]);
			})
			$$ = {
				code: "",
				value: null
			}
		}
	|
		stmt 
		{ $$ = { nt: 'block_stmt', children: [$1] } }
	;


stmt :
		stmt_wots 
		{ $$ = { nt: 'stmt', children: [$1] } }
	;


stmt_nsi :
		stmt_wots 
		{ $$ = { nt: 'stmt_nsi', children: [$1] } }
	;


stmt_wots :
		block 
		{ $$ = { nt: 'stmt_wots', children: [$1] } }
	|
		break_stmt 
		{ $$ = { nt: 'stmt_wots', children: [$1] } }
	|
		continue_stmt 
		{ $$ = { nt: 'stmt_wots', children: [$1] } }
	|
		return_stmt 
		{ $$ = { nt: 'stmt_wots', children: [$1] } }
	|
		stmt_expr 'terminator' 
		{ $$ = { nt: 'stmt_wots', children: [$1,{ t: 'terminator', l: $terminator }] } }
	|
		'terminator' 
		{ $$ = { nt: 'stmt_wots', children: [{ t: 'terminator', l: $terminator }] } }
	;


stmt_expr_list :
		stmt_expr_list 'separator' stmt_expr 
		{ $$ = { nt: 'stmt_expr_list', children: [$1,{ t: 'separator', l: $separator },$3] } }
	|
		stmt_expr 
		{ $$ = { nt: 'stmt_expr_list', children: [$1] } }
	;


break_stmt :
		'break' 'terminator' 
		{ $$ = { nt: 'break_stmt', children: [{ t: 'break', l: $break },{ t: 'terminator', l: $terminator }] } }
	;


continue_stmt :
		'continue' 'terminator' 
		{ $$ = { nt: 'continue_stmt', children: [{ t: 'continue', l: $continue },{ t: 'terminator', l: $terminator }] } }
	;


return_stmt :
		'return' expr 'terminator' 
		{ $$ = { nt: 'return_stmt', children: [{ t: 'return', l: $return },$2,{ t: 'terminator', l: $terminator }] } }
	|
		'return' 'terminator' 
		{ $$ = { nt: 'return_stmt', children: [{ t: 'return', l: $return },{ t: 'terminator', l: $terminator }] } }
	;


expr :
		additive_expr 
		{ $$ = { nt: 'expr', children: [$1] } }
	|
		assignment 
		{ $$ = { nt: 'expr', children: [$1] } }
	;


stmt_expr :
		assignment 
		{ $$ = { nt: 'stmt_expr', children: [$1] } }
	;


assignment :
		left_hand_side assignment_operator expr 
		{ $$ = { nt: 'assignment', children: [$1,$2,$3] } }
	;


left_hand_side :
		expr_name 
		{ $$ = { nt: 'left_hand_side', children: [$1] } }
	|
		field_access 
		{ $$ = { nt: 'left_hand_side', children: [$1] } }
	|
		array_access 
		{ $$ = { nt: 'left_hand_side', children: [$1] } }
	;


assignment_operator :
		'op_assign' 
		{ $$ = { nt: 'assignment_operator', children: [{ t: 'op_assign', l: $op_assign }] } }
	;


additive_expr :
		multiplicative_expr 
		{ $$ = { nt: 'additive_expr', children: [$1] } }
	|
		additive_expr 'op_add' multiplicative_expr 
		{ $$ = { nt: 'additive_expr', children: [$1,{ t: 'op_add', l: $op_add },$3] } }
	|
		additive_expr 'op_sub' multiplicative_expr 
		{ $$ = { nt: 'additive_expr', children: [$1,{ t: 'op_sub', l: $op_sub },$3] } }
	;


multiplicative_expr :
		unary_expr 
		{ $$ = { nt: 'multiplicative_expr', children: [$1] } }
	|
		multiplicative_expr 'op_mul' unary_expr 
		{ $$ = { nt: 'multiplicative_expr', children: [$1,{ t: 'op_mul', l: $op_mul },$3] } }
	|
		multiplicative_expr 'op_div' unary_expr 
		{ $$ = { nt: 'multiplicative_expr', children: [$1,{ t: 'op_div', l: $op_div },$3] } }
	|
		multiplicative_expr 'op_mod' unary_expr 
		{ $$ = { nt: 'multiplicative_expr', children: [$1,{ t: 'op_mod', l: $op_mod },$3] } }
	;


predec_expr :
		'op_decrement' unary_expr 
		{ $$ = { nt: 'predec_expr', children: [{ t: 'op_decrement', l: $op_decrement },$2] } }
	;


preinc_expr :
		'op_increment' unary_expr 
		{ $$ = { nt: 'preinc_expr', children: [{ t: 'op_increment', l: $op_increment },$2] } }
	;


unary_expr :
		preinc_expr 
		{ $$ = { nt: 'unary_expr', children: [$1] } }
	|
		predec_expr 
		{ $$ = { nt: 'unary_expr', children: [$1] } }
	|
		sign unary_expr 
		{ $$ = { nt: 'unary_expr', children: [$1,$2] } }
	|
		unary_expr_npm 
		{ $$ = { nt: 'unary_expr', children: [$1] } }
	;


unary_expr_npm :
		postfix_expr 
		{ $$ = { nt: 'unary_expr_npm', children: [$1] } }
	|
		post_expr 
		{ $$ = { nt: 'unary_expr_npm', children: [$1] } }
	|
		'op_not' unary_expr 
		{ $$ = { nt: 'unary_expr_npm', children: [{ t: 'op_not', l: $op_not },$2] } }
	|
		cast_expr 
		{ $$ = { nt: 'unary_expr_npm', children: [$1] } }
	;


cast_expr :
		'paranthesis_start' primitive_type 'paranthesis_end' unary_expr 
		{ $$ = { nt: 'cast_expr', children: [{ t: 'paranthesis_start', l: $paranthesis_start },$2,{ t: 'paranthesis_end', l: $paranthesis_end },$4] } }
	;


postdec_expr :
		postfix_expr 'op_decrement' 
		{ $$ = { nt: 'postdec_expr', children: [$1,{ t: 'op_decrement', l: $op_decrement }] } }
	|
		post_expr 'op_decrement' 
		{ $$ = { nt: 'postdec_expr', children: [$1,{ t: 'op_decrement', l: $op_decrement }] } }
	;


postinc_expr :
		postfix_expr 'op_increment' 
		{ $$ = { nt: 'postinc_expr', children: [$1,{ t: 'op_increment', l: $op_increment }] } }
	|
		post_expr 'op_increment' 
		{ $$ = { nt: 'postinc_expr', children: [$1,{ t: 'op_increment', l: $op_increment }] } }
	;


post_expr :
		postinc_expr 
		{ $$ = { nt: 'post_expr', children: [$1] } }
	|
		postdec_expr 
		{ $$ = { nt: 'post_expr', children: [$1] } }
	;


postfix_expr :
		primary 
		{ $$ = { nt: 'postfix_expr', children: [$1] } }
	|
		expr_name 
		{ $$ = { nt: 'postfix_expr', children: [$1] } }
	;


method_invocation :
		expr_name 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		primary 'field_invoker' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },$5,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'super' 'field_invoker' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [{ t: 'super', l: $super },{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },$5,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		expr_name 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		primary 'field_invoker' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'super' 'field_invoker' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [{ t: 'super', l: $super },{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	;


field_access :
		primary 'field_invoker' 'identifier' 
		{ $$ = { nt: 'field_access', children: [$1,{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier }] } }
	|
		'super' 'field_invoker' 'identifier' 
		{ $$ = { nt: 'field_access', children: [{ t: 'super', l: $super },{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier }] } }
	;


array_access :
		expr_name 'colon' dim_exprs 
		{ $$ = { nt: 'array_access', children: [$1,{ t: 'colon', l: $colon },$3] } }
	|
		primary_no_new_array 'colon' dim_exprs 
		{ $$ = { nt: 'array_access', children: [$1,{ t: 'colon', l: $colon },$3] } }
	;


primary :
		primary_no_new_array 
		{ $$ = { nt: 'primary', children: [$1] } }
	|
		array_creation_expr 
		{ $$ = { nt: 'primary', children: [$1] } }
	;


primary_no_new_array :
		literal 
		{ $$ = { nt: 'primary_no_new_array', children: [$1] } }
	|
		'this' 
		{ $$ = { nt: 'primary_no_new_array', children: [{ t: 'this', l: $this }] } }
	|
		'paranthesis_start' expr 'paranthesis_end' 
		{ $$ = { nt: 'primary_no_new_array', children: [{ t: 'paranthesis_start', l: $paranthesis_start },$2,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	;


class_instance_creation_expr :
		'new' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'class_instance_creation_expr', children: [{ t: 'new', l: $new },{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },$4,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'new' 'identifier' 'paranthesis_start' 'paranthesis_end' 
		{ $$ = { nt: 'class_instance_creation_expr', children: [{ t: 'new', l: $new },{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	;


argument_list :
		expr 
		{ $$ = { nt: 'argument_list', children: [$1] } }
	|
		argument_list 'separator' expr 
		{ $$ = { nt: 'argument_list', children: [$1,{ t: 'separator', l: $separator },$3] } }
	;


array_creation_expr :
		'new' primitive_type dim_exprs dims 
		{ $$ = { nt: 'array_creation_expr', children: [{ t: 'new', l: $new },$2,$3,$4] } }
	|
		'new' 'identifier' dim_exprs dims 
		{ $$ = { nt: 'array_creation_expr', children: [{ t: 'new', l: $new },{ t: 'identifier', l: $identifier },$3,$4] } }
	|
		'new' primitive_type dim_exprs 
		{ $$ = { nt: 'array_creation_expr', children: [{ t: 'new', l: $new },$2,$3] } }
	|
		'new' 'identifier' dim_exprs 
		{ $$ = { nt: 'array_creation_expr', children: [{ t: 'new', l: $new },{ t: 'identifier', l: $identifier },$3] } }
	;


dim_exprs :
		dim_exprs dim_expr 
		{ $$ = { nt: 'dim_exprs', children: [$1,$2] } }
	|
		dim_expr 
		{ $$ = { nt: 'dim_exprs', children: [$1] } }
	;


dim_expr :
		'brackets_start' expr 'brackets_end' 
		{ $$ = { nt: 'dim_expr', children: [{ t: 'brackets_start', l: $brackets_start },$2,{ t: 'brackets_end', l: $brackets_end }] } }
	;


dims :
		'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'dims', children: [{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	|
		dims 'brackets_start' 'brackets_end' 
		{ $$ = { nt: 'dims', children: [$1,{ t: 'brackets_start', l: $brackets_start },{ t: 'brackets_end', l: $brackets_end }] } }
	;


expr_name :
		'identifier' 
		{ $$ = { nt: 'expr_name', children: [{ t: 'identifier', l: $identifier }] } }
	|
		expr_name 'field_invoker' 'identifier' 
		{ $$ = { nt: 'expr_name', children: [$1,{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier }] } }
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


sign :
		'op_add' 
		{ $$ = { nt: 'sign', children: [{ t: 'op_add', l: $op_add }] } }
	|
		'op_sub' 
		{ $$ = { nt: 'sign', children: [{ t: 'op_sub', l: $op_sub }] } }
	;


