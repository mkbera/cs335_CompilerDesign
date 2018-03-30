%{
	var utils = {
		init: function(obj) {
			var self = { code: [], place: null }

			for (var var_index in obj.var_declarators) {
				variable = obj.var_declarators[var_index]
				
				ST.add_variable(variable.identifier, obj.type);

				if (obj.type.category == "array") {
					
					if (variable.init != null) {
						var inits = variable.init
						var type = obj.type

						var length = 1

						if (type.dimension == 0 || type.length != inits.length) {
							throw Error("Array dimensions do not match");
						}

						while (type.dimension != 0) {
							length *= type.length

							type = type.type
							
							var inits_serial = []
							for (var index in inits) {
								if (type.length != inits[index].length) {
									throw Error("Array dimensions do not match");
								}

								inits_serial = inits_serial.concat(inits[index])
							}
							inits = inits_serial
						}

						if (inits[0].length) {
							throw Error("Array dimensions do not match");
						}

						self.code.push(
							"decr" + ir_sep + variable.identifier + ir_sep + "array" + ir_sep + type.get_type() + ir_sep + length + ir_sep
						)

						for (var index in inits) {
							self.code = self.code.concat(inits[index].code)
							self.code.push(
								"arrset" + ir_sep + variable.identifier + ir_sep + index + ir_sep + inits[index].place
							)
						}
					}
					else {
						var length = 1;
						var type = obj.type;

						while (type.dimension != 0) {
							length *= type.length

							type = type.type
						}

						self.code.push(
							"decr" + ir_sep + variable.identifier + ir_sep + "array" + ir_sep + type.get_type() + ir_sep + length + ir_sep
						)
					}
				}
				else {
					self.code.push(
						"decr" + ir_sep + variable.identifier + ir_sep + obj.type.get_type()
					)

					if (variable.init != null) {
						self.code = self.code.concat(variable.init.code)
						self.code.push(
							"=" + ir_sep + variable.identifier + ir_sep + variable.init.place
						)
					}
				}
			}

			return self
		},
		binary: function (obj) {
			var temp = ST.create_temporary()

			var self = { code: [], place: temp }

			self.code = obj.op1.code.concat(obj.op2.code)
			self.code.push(
				obj.operator + ir_sep + temp + ir_sep + obj.op1.place + ir_sep + obj.op2.place
			)

			return self
		}
	}
%}

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
		import_decrs type_decrs 'EOF' 
		{
			return $1.code.concat($2.code)
		}
	|
		import_decrs 'EOF' 
		{
			return $1.code
		}
	|
		type_decrs 'EOF' 
		{
			return $1.code
		}
	|
		'EOF' 
		{
			return []
		}
	;


import_decrs :
		import_decr 
		{
			$$ = { code: [$1.code], place: null }
		}
	|
		import_decrs import_decr 
		{
			$$ = $1
			$$.code.push($2.code)
		}
	;


import_decr :
		'import' 'identifier' 'terminator' 
		{
			$$ = { code: "import" + ir_sep + $identifier, place: null }
		}
	;


type_decrs :
		type_decrs type_decr 
		{
			$$ = $1
			$$.code = $$.code.concat($2.code)
		}
	|
		type_decr 
		{
			$$ = $1
		}
	;


type_decr :
		class_decr 
		{
			$$ = $1
		}
	|
		'terminator' 
		{
			$$ = { code: [], place: null }
		}
	;


class_decr :
		class_header class_body 
		{
			$$ = $1
			$$.code = $$.code.concat($2.code)
		}
	;


class_header :
		'public' 'class' 'identifier' extend_decr
		{
			ST.add_class($identifier, $4)
			$$ = {
				code: ["class" + ir_sep + $identifier + ir_sep + "extends" + ir_sep + $4],
				place: null
			}
		}
	|
		'class' 'identifier' extend_decr 
		{
			ST.add_class($identifier, $3)
			$$ = {
				code: ["class" + ir_sep + $identifier + ir_sep + "extends" + ir_sep + $3],
				place: null
			}
		}
	|
		'public' 'class' 'identifier' 
		{
			ST.add_class($identifier, "")
			$$ = {
				code: ["class" + ir_sep + $identifier],
				place: null
			}
		}
	|
		'class' 'identifier' 
		{
			ST.add_class($identifier, "")
			$$ = {
				code: ["class" + ir_sep + $identifier],
				place: null
			}
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
			$$ = $2
		}
	;


class_body_decrs :
		class_body_decrs class_body_decr 
		{
			$$ = $1
			$$.code = $$.code.concat($2.code)
		}
	|
		class_body_decr 
		{
			$$ = $1
		}
	;


class_body_decr :
		class_member_decr 
		{
			$$ = $1
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
			$$ = $1
		}
	|
		method_decr 
		{
			$$ = $1
		}
	;


consr_declarator :
		'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{
			$$ = { code: [], place: null }
		}
	;


consr_body :
		'set_start' explicit_consr_invocation block_stmts 'set_end' 
		{
			$$ = { code: [], place: null }
		}
	|
		'set_start' block_stmts 'set_end' 
		{
			$$ = { code: [], place: null }
		}
	|
		'set_start' explicit_consr_invocation 'set_end' 
		{
			$$ = { code: [], place: null }
		}
	|
		'set_start' 'set_end' 
		{
			$$ = { code: [], place: null }
		}
	;


explicit_consr_invocation :
		'this' 'paranthesis_start' argument_list 'paranthesis_end' 
		{
			$$ = { code: [], place: null }
		}
	|
		'super' 'paranthesis_start' argument_list 'paranthesis_end' 
		{
			$$ = { code: [], place: null }
		}
	|
		'this' 'paranthesis_start' 'paranthesis_end' 
		{
			$$ = { code: [], place: null }
		}
	|
		'super' 'paranthesis_start' 'paranthesis_end' 
		{
			$$ = { code: [], place: null }
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


field_decr :
		'public' type var_declarators 'terminator' 
		{
			$$ = utils.init({
				type: $2,
				var_declarators: $3
			})
		}
	|
		type var_declarators 'terminator' 
		{
			$$ = utils.init({
				type: $1,
				var_declarators: $2
			})
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
			$$ = { identifier: $1, init: null }
		}
	|
		var_declarator_id 'op_assign' var_init 
		{
			$$ = { identifier: $1, init: $3 }
		}
	;


var_declarator_id :
		'identifier' 
		{
			$$ = $identifier
		}
	;


var_init :
		expr
		{
			$$ = $1
		}
	|
		array_init 
		{
			$$ = $1
		}
	;


array_init :
		'set_start' var_inits 'separator' 'set_end' 
		{
			$$ = $2
		}
	|
		'set_start' var_inits 'set_end' 
		{
			$$ = $2
		}
	;


var_inits :
		var_inits 'separator' var_init 
		{
			$$ = $1
			$$.push($3)
		}
	|
		var_init 
		{
			$$ = [$1]
		}
	;


type :
		primitive_type 
		{
			$$ = new Type($1.type, $1.category, $1.width, $1.length, $1.dimension)
		}
	|
		reference_type 
		{
			$$ = $1
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
				length: null,
				dimension: 0
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
				length: null,
				dimension: 0
			}
		}
	|
		'short' 
		{
			$$ = {
				type: "short",
				category: "basic",
				width: 2,
				length: null,
				dimension: 0
			}
		}
	|
		'int' 
		{
			$$ = {
				type: "int",
				category: "basic",
				width: 4,
				length: null,
				dimension: 0
			}
		}
	|
		'long' 
		{
			$$ = {
				type: "long",
				category: "basic",
				width: 8,
				length: null,
				dimension: 0
			}
		}
	|
		'char' 
		{
			$$ = {
				type: "char",
				category: "basic",
				width: 1,
				length: null,
				dimension: 0
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
				length: null,
				dimension: 0
			}
		}
	|
		'double' 
		{
			$$ = {
				type: "boolean",
				category: "basic",
				width: 8,
				length: null,
				dimension: 0
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
				length: null,
				dimension: 0
			}
		}
	|
		'identifier' dim_exprs 
		{
			var type = new Type(ST.get_class($identifier), "object", null, null, 0)

			var l = $2.length - 1
			while (l >= 0) {
				type = new Type(type, "array", 4, $2[l].place, $2.length - l)

				l -= 1
			}

			$$ = type
		}
	|
		primitive_type dim_exprs 
		{
			var type = new Type($1.type, $1.category, $1.width, $1.length, $1.dimension)

			var l = $2.length - 1
			while (l >= 0) {
				type = new Type(type, "array", 4, $2[l].place, $2.length - l)

				l -= 1
			}

			$$ = type
		}
	;


method_decr :
		'public' 'void' method_declarator method_body 
		{
			var method = ST.add_method($3.name, new Type("void", "basic", 0, null), $3.parameters, $4.scope, main = false)

			$$ = { code: [], place: null }

			$$.code.push(
				"function" + ir_sep + method.name
			)
			for (var index in method.parameters) {
				$$.code.push(
					"pop" + ir_sep + method.parameters[index].name
				)
			}
			$$.code = $$.code.concat($4.code)
		}
	|
		'public' type method_declarator method_body 
		{
			var method = ST.add_method($3.name, $2, $3.parameters, $4.scope, main = false)

			$$ = { code: [], place: null }

			$$.code.push(
				"function" + ir_sep + method.name
			)
			for (var index in method.parameters) {
				$$.code.push(
					"pop" + ir_sep + method.parameters[index].name
				)
			}
			$$.code = $$.code.concat($4.code)
		}
	|
		'void' method_declarator method_body 
		{
			var method = ST.add_method($2.name, new Type("void", "basic", 0, null), $2.parameters, $3.scope, main = false)

			$$ = { code: [], place: null }

			$$.code.push(
				"function" + ir_sep + method.name
			)
			for (var index in method.parameters) {
				$$.code.push(
					"pop" + ir_sep + method.parameters[index].name
				)
			}
			$$.code = $$.code.concat($3.code)
		}
	|
		type method_declarator method_body 
		{
			var method = ST.add_method($2.name, $1, $2.parameters, $3.scope, main = false)

			$$ = { code: [], place: null }

			$$.code.push(
				"function" + ir_sep + method.name
			)
			for (var index in method.parameters) {
				$$.code.push(
					"pop" + ir_sep + method.parameters[index].name
				)
			}
			$$.code = $$.code.concat($3.code)
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
			$$ = $1
		}
	;


block :
		'set_start' block_scope_start block_stmts 'set_end' 
		{
			$$ = {
				code: [],
				scope: ST.scope_end()
			}

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)

			for (var index in $3) {
				$$.code = $$.code.concat($3[index].code)
			}

			$$.code.push(
				"label" + ir_sep + $$.scope.label_end
			)
		}
	|
		'set_start' block_scope_start 'set_end' 
		{
			$$ = {
				code: [],
				scope: ST.scope_end()
			}

			$$.code = $$.code.concat([
				"label" + ir_sep + $$.scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	;

block_scope_start :

		{
			$$ = ST.scope_start()
		}
	;


block_stmts :
		block_stmts block_stmt 
		{
			$$ = $1
			$$.push($2)
		}
	|
		block_stmt 
		{
			$$ = [$1]
		}
	;


block_stmt :
		type var_declarators 'terminator' 
		{
			$$ = utils.init({
				type: $1,
				var_declarators: $2
			})
		}
	|
		stmt 
		{
			$$ = $1
		}
	;


stmt :
		stmt_wots 
		{
			$$ = $1
		}
	|
		for_stmt 
		{
			$$ = $1
		}
	;


stmt_nsi :
		stmt_wots 
		{
			$$ = $1
		}
	|
		for_stmt_nsi 
		{
			$$ = $1
		}
	;


stmt_wots :
		block 
		{
			$$ = $1
		}
	|
		break_stmt 
		{
			$$ = $1
		}
	|
		continue_stmt 
		{
			$$ = $1
		}
	|
		return_stmt 
		{
			$$ = $1
		}
	|
		stmt_expr 'terminator' 
		{
			$$ = $1
		}
	|
		'terminator' 
		{
			$$ = { code: [], place: null }
		}
	;


stmt_expr_list :
		stmt_expr_list 'separator' stmt_expr 
		{
			$$ = $1
			$$.push($3)
		}
	|
		stmt_expr 
		{
			$$ = [$1]
		}
	;


break_stmt :
		'break' 'terminator' 
		{
			$$ = { code: [], place: null }

			var scope = ST.current_scope

			while (scope instanceof ScopeTable) {
				if (scope.category == "while") {
					$$.code.push(
						"jump" + ir_sep + scope.label_end
					)
				}
				else if (scope.category == "for_inner") {
					$$.code.push(
						"jump" + ir_sep + scope.parent.label_end
					)
				}

				scope = scope.parent
			}
	
			if ($$.code.length == 0) {
				throw Error("Continue statement not inside a loop")
			}
		}
	;


continue_stmt :
		'continue' 'terminator' 
		{
			$$ = { code: [], place: null }

			var scope = ST.current_scope

			while (scope instanceof ScopeTable) {
				if (scope.category == "while") {
					$$.code.push(
						"jump" + ir_sep + scope.label_start
					)
				}
				else if (scope.category == "for_inner") {
					$$.code.push(
						"jump" + ir_sep + scope.label_end
					)
				}

				scope = scope.parent
			}
	
			if ($$.code.length == 0) {
				throw Error("Continue statement not inside a loop")
			}
		}
	;


return_stmt :
		'return' expr 'terminator' 
		{
			$$ = $2
			$$.code.push(
				"return" + ir_sep + $2.place
			)
		}
	|
		'return' 'terminator' 
		{
			$$ = { code: ["return"], place: null }
		}
	;


if_then_stmt :
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt 
		{
			$$ = { code: $3.code, place: null }

			var label_start;
			var label_end;
			if ($5.scope == null) {
				label_start = ST.create_label()
				label_end = ST.create_label()
			}
			else {
				label_start = $5.scope.label_start
				label_end = $5.scope.label_end
			}

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $3.place + ir_sep + "1" + ir_sep + label_start
			)

			$$.code.push(
				"jump" + ir_sep + label_end
			)

			if ($5.scope == null) {
				$$.code.push(
					"label" + ir_sep + label_start
				)
			}

			$$.code = $$.code.concat($5.code)

			if ($5.scope == null) {
				$$.code.push(
					"label" + ir_sep + label_end
				)
			}
		}
	;


if_then_else_stmt :
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 'else' stmt 
		{
			$$ = { code: $3.code, place: null }

			var label_start;
			var label_end;
			if ($5.scope == null) {
				label_start = ST.create_label()
				label_end = ST.create_label()
			}
			else {
				label_start = $5.scope.label_start
				label_end = $5.scope.label_end
			}

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $3.place + ir_sep + "1" + ir_sep + label_start
			)

			$$.code = $$.code.concat($7.code)

			$$.code.push(
				"jump" + ir_sep + label_end
			)

			if ($5.scope == null) {
				$$.code.push(
					"label" + ir_sep + label_start
				)
			}

			$$.code = $$.code.concat($5.code)

			if ($5.scope == null) {
				$$.code.push(
					"label" + ir_sep + label_end
				)
			}
		}
	;


if_then_else_stmt_nsi :
		'if' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 'else' stmt_nsi 
		{
			$$ = { code: $3.code, place: null }

			var label_start;
			var label_end;
			if ($5.scope == null) {
				label_start = ST.create_label()
				label_end = ST.create_label()
			}
			else {
				label_start = $5.scope.label_start
				label_end = $5.scope.label_end
			}

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $3.place + ir_sep + "1" + ir_sep + label_start
			)

			$$.code = $$.code.concat($7.code)

			$$.code.push(
				"jump" + ir_sep + label_end
			)

			if ($5.scope == null) {
				$$.code.push(
					"label" + ir_sep + label_start
				)
			}

			$$.code = $$.code.concat($5.code)

			if ($5.scope == null) {
				$$.code.push(
					"label" + ir_sep + label_end
				)
			}
		}
	;

while_stmt :
		while_scope_start 'while' 'paranthesis_start' expr 'paranthesis_end' stmt 
		{
			$$ = { code: [], place: null, scope: ST.scope_end() }
			
			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)

			$$.code = $$.code.concat($4.code)

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $4.place + ir_sep + "0" + ir_sep + $$.scope.label_end
			)
			
			$$.code = $$.code.concat($6.code)

			$$.code = $$.code.concat([
				"jump" + ir_sep + $$.scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	;


while_stmt_nsi :
		while_scope_start 'while' 'paranthesis_start' expr 'paranthesis_end' stmt_nsi 
		{
			$$ = { code: [], place: null, scope: ST.scope_end() }
			
			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)

			$$.code = $$.code.concat($4.code)

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $4.place + ir_sep + "0" + ir_sep + $$.scope.label_end
			)
			
			$$.code = $$.code.concat($6.code)

			$$.code = $$.code.concat([
				"jump" + ir_sep + $$.scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	;

while_scope_start :

		{
			$$ = ST.scope_start(category = "while")
		}
	;

for_stmt :
		for_scope_start 'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' for_inner_scope_start stmt 
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)

			$$.code = $$.code.concat($4.code)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($6.code)

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $6.place + ir_sep + "0" + ir_sep + $$.scope.label_end
			)
			
			$$.code = $$.code.concat($11.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			for (var index in $8) {
				$$.code = $$.code.concat($8[index].code)
			}

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	;


for_stmt_nsi :
		for_scope_start 'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' for_inner_scope_start stmt_nsi 
		{
			
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)

			$$.code = $$.code.concat($4.code)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($6.code)

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $6.place + ir_sep + "0" + ir_sep + $$.scope.label_end
			)
			
			$$.code = $$.code.concat($11.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			for (var index in $8) {
				$$.code = $$.code.concat($8[index].code)
			}

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	;


for_init :
		stmt_expr_list 
		{
			$$ = { code: [], place: null }

			for (var index in $1) {
				$$.code = $$.code.concat($1[index].code)
			}
		}
	|
		type var_declarators 
		{
			$$ = utils.init({
				type: $1,
				var_declarators: $2
			})
		}
	;


for_scope_start :

		{
			$$ = ST.scope_start(category = "for")
		}
	;


for_inner_scope_start :

		{
			$$ = ST.scope_start(category = "for_inner")
		}
	;


expr :
		additive_expr 
		{
			$$ = $1
		}
	|
		assignment 
		{
			$$ = $1
		}
	;


stmt_expr :
		assignment 
		{
			$$ = $1
		}
	|
		preinc_expr 
		{
			$$ = $1
		}
	|
		predec_expr 
		{
			$$ = $1
		}
	|
		post_expr 
		{
			$$ = $1
		}
	|
		method_invocation 
		{
			$$ = $1
		}
	|
		class_instance_creation_expr 
		{
			$$ = $1
		}
	;


assignment :
		left_hand_side_non_array assignment_operator expr 
		{
			$$ = { code: [], place: null }

			ST.lookup_variable($1.place)

			$$.code = $3.code.concat($1.code)
			if ($2.third) {
				$$.code.push(
					$2.operator + ir_sep + $1.place + ir_sep + $1.place + ir_sep + $3.place
				)
			}
			else {
				$$.code.push(
					$2.operator + ir_sep + $1.place + ir_sep + $3.place
				)
			}
		}
	|
		array_access assignment_operator expr
		{
			$$ = { code: [], place: null }

			$$.code = $3.code.concat($1.code)
			if ($2.third) {
				var temp = ST.create_temporary()

				$$.code = $$.code.concat([
					"arrget" + ir_sep + temp + ir_sep + $1.place + ir_sep + $1.offset,
					$2.operator + ir_sep + temp + ir_sep + temp + ir_sep + $3.place,
					"arrset" + ir_sep + $1.place + ir_sep + $1.offset + ir_sep + temp,
				])
			}
			else {
				$$.code.push(
					"arrset" + ir_sep + $1.place + ir_sep + $1.offset + ir_sep + $3.place,
				)
			}
		}
	;


left_hand_side_non_array :
		expr_name 
		{
			$$ = $1
		}
	|
		field_access 
		{
			$$ = $1
		}
	;


assignment_operator :
		'op_assign' 
		{
			$$ = { operator: "=", third: false }
		}
	|
		'op_addAssign' 
		{
			$$ = { operator: "+", third: true }
		}
	;


cond_or_expr :
		cond_and_expr 
		{
			$$ = $1
		}
	|
		cond_or_expr 'op_oror' cond_and_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "||"
			})
		}
	;


cond_and_expr :
		incl_or_expr 
		{
			$$ = $1
		}
	|
		cond_and_expr 'op_andand' incl_or_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "&&"
			})
		}
	;


incl_or_expr :
		excl_or_expr 
		{
			$$ = $1
		}
	|
		incl_or_expr 'op_or' excl_or_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "|"
			})
		}
	;


excl_or_expr :
		and_expr 
		{
			$$ = $1
		}
	|
		excl_or_expr 'op_xor' and_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "^"
			})
		}
	;


and_expr :
		equality_expr 
		{
			$$ = $1
		}
	|
		and_expr 'op_and' equality_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "&"
			})
		}
	;


equality_expr :
		relational_expr 
		{
			$$ = $1
		}
	|
		equality_expr 'op_equalCompare' relational_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "=="
			})
		}
	|
		equality_expr 'op_notequalCompare' relational_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "!="
			})
		}
	;


relational_expr :
		shift_expr 
		{
			$$ = $1
		}
	|
		relational_expr 'op_greater' shift_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: ">"
			})
		}
	|
		relational_expr 'op_greaterEqual' shift_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: ">="
			})
		}
	|
		relational_expr 'op_less' shift_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "<"
			})
		}
	|
		relational_expr 'op_lessEqual' shift_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "<="
			})
		}
	|
		relational_expr 'instanceof' shift_expr 
		{ $$ = { nt: 'relational_expr', children: [$1,{ t: 'instanceof', l: $instanceof },$3] } }
	;


shift_expr :
		additive_expr 
		{
			$$ = $1
		}
	|
		shift_expr 'op_Lshift' additive_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "<<"
			})
		}
	|
		shift_expr 'op_Rshift' additive_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: ">>"
			})
		}
	;


additive_expr :
		multiplicative_expr 
		{
			$$ = $1
		}
	|
		additive_expr 'op_add' multiplicative_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "+"
			})
		}
	|
		additive_expr 'op_sub' multiplicative_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "-"
			})
		}
	;


multiplicative_expr :
		unary_expr 
		{
			$$ = $1
		}
	|
		multiplicative_expr 'op_mul' unary_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "*"
			})
		}
	|
		multiplicative_expr 'op_div' unary_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "/"
			})
		}
	|
		multiplicative_expr 'op_mod' unary_expr 
		{
			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "%"
			})
		}
	;


predec_expr :
		'op_decrement' unary_expr 
		{
			$$ = $2

			$$.code.push(
				"dec" + ir_sep + $$.place
			)
		}
	;


preinc_expr :
		'op_increment' unary_expr 
		{
			$$ = $2

			$$.code.push(
				"inc" + ir_sep + $$.place
			)
		}
	;


unary_expr :
		preinc_expr 
		{
			$$ = $1
		}
	|
		predec_expr 
		{
			$$ = $1
		}
	|
		sign unary_expr 
		{
			if ($1 == "+") {
				$$ = $2
			}
			else {
				temp = ST.create_temporary()

				$$ = {code: $2.code, place: temp}

				$$.code.push(
					"*" + ir_sep + $$.place + ir_sep + $2.place + ir_sep + "-1"
				)
			}
		}
	|
		unary_expr_npm 
		{
			$$ = $1
		}
	;


unary_expr_npm :
		postfix_expr 
		{
			$$ = $1
		}
	|
		post_expr 
		{
			$$ = $1
		}
	|
		'op_not' unary_expr 
		{
			$$ = $2
			$$.code.push(
				"not" + ir_sep + $$.place
			)
		}
	|
		cast_expr 
		{
			$$ = $1
		}
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
		{
			$$ = $1
		}
	|
		postdec_expr 
		{
			$$ = $1
		}
	;


postfix_expr :
		primary 
		{
			$$ = $1
		}
	|
		expr_name 
		{
			$$ = $1
		}
	;


method_invocation :
		expr_name 'paranthesis_start' argument_list 'paranthesis_end' 
		{
			$$ = { code: [], place: null }

			var method = ST.lookup_method($1.place)

			if ($3.length != method.num_parameters) {
				throw Error("The method " + method.name + " requires " + method.num_parameters + ", provided" + $3.length)
			}

			for (var index in $3) {
				$$.code = $$.code.concat($3[index].code)
			}
			for (var index in $3) {
				$$.code.push(
					"param" + ir_sep + $3[index].place
				)
			}

			if (method.type != "void") {
				temp = ST.create_temporary()

				$$.place = temp
				$$.code.push(
					"call" + ir_sep + $1.place + ir_sep + method.num_parameters + ir_sep + temp
				)
			}
			else {
				$$.code.push(
					"call" + ir_sep + $1.place + ir_sep + method.num_parameters
				)
			}
		}
	|
		expr_name 'paranthesis_start' 'paranthesis_end' 
		{
			$$ = { code: [], place: null }

			var method = ST.lookup_method($1.place)

			if ($3.length != method.num_parameters) {
				throw Error("The method " + method.name + " requires " + method.num_parameters + ", provided " + $3.length)
			}

			for (var index in $3) {
				$$.code = $$.code.concat($3[index].code)
			}
			for (var index in $3) {
				$$.code.push(
					"param" + ir_sep + $3[index].place
				)
			}

			if (method.type != "void") {
				temp = ST.create_temporary()

				$$.place = temp
				$$.code.push(
					"call" + ir_sep + $1.place + ir_sep + method.num_parameters + ir_sep + temp
				)
			}
			else {
				$$.code.push(
					"call" + ir_sep + $1.place + ir_sep + method.num_parameters
				)
			}
		}
	|
		primary 'field_invoker' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [$1,{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },$5,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
	|
		'super' 'field_invoker' 'identifier' 'paranthesis_start' argument_list 'paranthesis_end' 
		{ $$ = { nt: 'method_invocation', children: [{ t: 'super', l: $super },{ t: 'field_invoker', l: $field_invoker },{ t: 'identifier', l: $identifier },{ t: 'paranthesis_start', l: $paranthesis_start },$5,{ t: 'paranthesis_end', l: $paranthesis_end }] } }
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
		{
			$$ = { code: [], place: null, offset: null }

			var temp = ST.create_temporary()

			var array = ST.lookup_variable($1.place)
			var type = array.type

			$$.code.push(
				"=" + ir_sep + temp + ir_sep + "0"
			)

			var offset = 0

			for (var index in $3) {
				var dim = $3[index]

				if (dim.literal && dim.type != "integer") {
					throw Error("Array indices can only be of type (int)")
				}
				if (type.category != "array") {
					throw Error("Array dimensions do not match")
				}
				
				$$.code = $$.code.concat(dim.code)

				$$.code = $$.code.concat([
					"*" + ir_sep + temp + ir_sep + temp + ir_sep + type.length,
					"+" + ir_sep + temp + ir_sep + temp + ir_sep + dim.place
				])

				type = type.type
			}

			if (type.category == "array") {
				throw Error("Array dimensions do not match")
			}

			$$.place = array.name
			$$.offset = temp
		}
	;


primary :
		literal 
		{
			$$ = $1
		}
	|
		'this' 
		{ $$ = { nt: 'primary_no_new_array', children: [{ t: 'this', l: $this }] } }
	|
		'paranthesis_start' expr 'paranthesis_end' 
		{
			$$ = $2
		}
	|
		class_instance_creation_expr 
		{
			$$ = $1
		}
	|
		field_access 
		{
			$$ = $1
		}
	|
		array_access 
		{
			$$ = { code: $1.code, place: null }

			$$.place = ST.create_temporary()

			$$.code.push(
				"arrget" + ir_sep + $$.place + ir_sep + $1.place + ir_sep + $1.offset
			)
		}
	|
		method_invocation 
		{
			$$ = $1
		}
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
		{
			$$ = [$1]
		}
	|
		argument_list 'separator' expr 
		{
			$$ = $1
			$$.push($3)
		}
	;


dim_exprs :
		dim_exprs dim_expr 
		{
			$$ = $1
			$$.push($2)
		}
	|
		dim_expr 
		{
			$$ = [$1]
		}
	;


dim_expr :
		'brackets_start' expr 'brackets_end' 
		{
			$$ = $2
		}
	;


expr_name :
		'identifier' 
		{
			$$ = {
				code: [],
				place: $identifier
			}
		}
	|
		expr_name 'field_invoker' 'identifier' 
		{
			$$ = {
				code: [],
				place: $identifier
			}
		}
	;


literal :
		'integer_literal' 
		{
			$$ = {
				code: [],
				place: $integer_literal,
				literal: true,
				type: "integer"
			}
		}
	|
		'float_literal' 
		{
			$$ = {
				code: [],
				place: $float_literal,
				literal: true,
				type: "float"
			}
		}
	|
		'boolean_literal' 
		{
			$$ = {
				code: [],
				place: $boolean_literal,
				literal: true,
				type: "boolean"
			}
		}
	|
		'character_literal' 
		{
			$$ = {
				code: [],
				place: $character_literal,
				literal: true,
				type: "character"
			}
		}
	|
		'string_literal' 
		{
			$$ = {
				code: [],
				place: $string_literal,
				literal: true,
				type: "string"
			}
		}
	|
		'null_literal' 
		{
			$$ = {
				code: [],
				place: $null_literal,
				literal: true,
				type: "null"
			}
		}
	;


sign :
		'op_add' 
		{
			$$ = "+"
		}
	|
		'op_sub' 
		{
			$$ = "-"
		}
	;


