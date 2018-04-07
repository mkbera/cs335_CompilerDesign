%{
	var utils = {
		assign: function(obj) {
			var self = { code: [], place: null }

			for (var var_index in obj.var_declarators) {
				variable = obj.var_declarators[var_index]
				
				variable.identifier = ST.add_variable(variable.identifier, obj.type).display_name

				if (obj.type.category == "array") {
					
					if (variable.init != null) {
						var inits = variable.init
						var type = obj.type

						var length = 1

						if (type.dimension == 0 || type.length != inits.length) {
							throw Error("Array dimensions do not match")
						}

						while (type.dimension != 0) {
							length *= type.length

							type = type.type
							
							var inits_serial = []
							for (var index in inits) {
								if (type.length != inits[index].length) {
									throw Error("Array dimensions do not match")
								}

								inits_serial = inits_serial.concat(inits[index])
							}
							inits = inits_serial
						}

						if (inits[0].length) {
							throw Error("Array dimensions do not match")
						}

						self.code.push(
							"decr" + ir_sep + variable.identifier + ir_sep + "array" + ir_sep + type.type + ir_sep + length + ir_sep
						)

						for (var index in inits) {
							if (!(inits[index].type.type == type.type || (inits[index].type.numeric() && type.numeric()))) {
								throw Error("Cannot convert '" + inits[index].type.type + "' to '" + type.type + "'")
							}

							self.code = self.code.concat(inits[index].code)

							if (inits[index].type.type != type.type) {
								var temp = ST.create_temporary()

								self.code = self.code.concat([
									"decr" + ir_sep + temp + ir_sep + type.type,
									"cast" + ir_sep + temp + ir_sep + inits[index].type.type + ir_sep + type.type + ir_sep + inits[index].place,
									"arrset" + ir_sep + variable.identifier + ir_sep + index + ir_sep + temp
								])
							}
							else {
								self.code.push(
									"arrset" + ir_sep + variable.identifier + ir_sep + index + ir_sep + inits[index].place
								)
							}
						}
					}
					else {
						var length = 1
						var type = obj.type

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
						if (!(variable.init.type.type == obj.type.type || (variable.init.type.numeric() && obj.type.numeric()))) {
							throw Error("Cannot convert '" + variable.init.type.type + "' to '" + obj.type.type + "'")
						}

						self.code = self.code.concat(variable.init.code)

						if (variable.init.type.type != obj.type.type) {
							var temp = ST.create_temporary()

							self.code = self.code.concat([
								"decr" + ir_sep + temp + ir_sep + obj.type.type,
								"cast" + ir_sep + temp + ir_sep + variable.init.type.type + ir_sep + obj.type.type + ir_sep + variable.init.place,
								"=" + ir_sep + variable.identifier + ir_sep + temp
							])
						}
						else {
							self.code.push(
								"=" + ir_sep + variable.identifier + ir_sep + variable.init.place
							)
						}
					}
				}
			}

			return self
		},

		binary: function (obj) {

			var self = {
				code: obj.op1.code.concat(obj.op2.code),
				place: null,
				type: null,
				literal: false
			}

			if (obj.op1.type.type == "float" || obj.op2.type.type == "float") {
				self.type = new Type("float", "basic", 4, 0, 0)
			}
			else if (obj.op1.type.type == "long" || obj.op2.type.type == "long") {
				self.type = new Type("long", "basic", 8, 0, 0)
			}
			else if (obj.op1.type.type == "int" || obj.op2.type.type == "int") {
				self.type = new Type("int", "basic", 4, 0, 0)
			}
			else if (obj.op1.type.type == "short" || obj.op2.type.type == "short") {
				self.type = new Type("short", "basic", 2, 0, 0)
			}
			else if (obj.op1.type.type == "byte" || obj.op2.type.type == "byte") {
				self.type = new Type("byte", "basic", 1, 0, 0)
			}
			else if (obj.op1.type.type == "boolean" || obj.op2.type.type == "boolean") {
				self.type = new Type("boolean", "basic", 1, 0, 0)
			}

			if (!obj.op1.literal) {
				var temp = ST.create_temporary()
				self.code.push(
					"decr" + ir_sep + temp + ir_sep + self.type.type
				)

				var t1 = obj.op1.place
				if (obj.op1.type.type != self.type.type) {
					t1 = ST.create_temporary()
					self.code = self.code.concat([
						"decr" + ir_sep + t1 + ir_sep + self.type.type,
						"cast" + ir_sep + t1 + ir_sep + obj.op1.type.type + ir_sep + self.type.type + ir_sep + obj.op1.place
					])
				}

				var t2 = obj.op2.place
				if (obj.op2.type.type != self.type.type) {
					t2 = ST.create_temporary()
					self.code = self.code.concat([
						"decr" + ir_sep + t2 + ir_sep + self.type.type,
						"cast" + ir_sep + t2 + ir_sep + obj.op2.type.type + ir_sep + self.type.type + ir_sep + obj.op2.place
					])
				}

				self.code.push(
					obj.operator + ir_sep + temp + ir_sep + t1 + ir_sep + t2
				)

				self.place = temp
			}
			else if (!obj.op2.literal) {
				var temp = ST.create_temporary()
				self.code.push(
					"decr" + ir_sep + temp + ir_sep + self.type.type
				)

				var t1 = obj.op1.place
				if (obj.op1.type.type != self.type.type) {
					t1 = ST.create_temporary()
					self.code = self.code.concat([
						"decr" + ir_sep + t1 + ir_sep + self.type.type,
						"cast" + ir_sep + t1 + ir_sep + obj.op1.type.type + ir_sep + self.type.type + ir_sep + obj.op1.place
					])
				}

				var t2 = obj.op2.place
				if (obj.op2.type.type != self.type.type) {
					t2 = ST.create_temporary()
					self.code = self.code.concat([
						"decr" + ir_sep + t2 + ir_sep + self.type.type,
						"cast" + ir_sep + t2 + ir_sep + obj.op2.type.type + ir_sep + self.type.type + ir_sep + obj.op2.place
					])
				}

				self.code.push(
					obj.operator + ir_sep + temp + ir_sep + t2 + ir_sep + t1
				)

				self.place = temp
			}
			else {
				self.place = eval(obj.op1.place + " " + obj.operator + " " + obj.op2.place)
				self.literal = true
			}

			return self
		},

		relational: function (obj) {

			var self = { code: [], place: null, type: null, literal: false }

			if (!obj.op1.literal) {
				self.code = obj.op1.code.concat(obj.op2.code)

				var temp = ST.create_temporary()
				self.code.push(
					"decr" + ir_sep + temp + ir_sep + "int"
				)

				var label = ST.create_label()
			
				self.code = self.code.concat([
					"=" + ir_sep + temp + ir_sep + "1",
					"ifgoto" + ir_sep + obj.operator + ir_sep + obj.op1.place + ir_sep + obj.op2.place + ir_sep + label,
					"=" + ir_sep + temp + ir_sep + "0",
					"label" + ir_sep + label
				])
				self.place = temp
			}
			else if (!obj.op2.literal) {
				self.code = obj.op2.code.concat(obj.op1.code)
				var temp = ST.create_temporary()
			
				self.code.push(
					"decr" + ir_sep + temp + ir_sep + "int"
				)

				var label = ST.create_label()

				self.code = self.code.concat([
					"=" + ir_sep + temp + ir_sep + "1",
					"ifgoto" + ir_sep + obj.operator + ir_sep + obj.op2.place + ir_sep + obj.op1.place + ir_sep + label,
					"=" + ir_sep + temp + ir_sep + "0",
					"label" + ir_sep + label
				])
				self.place = temp
			}
			else {
				self.place = eval(obj.op1.place + " " + obj.operator + " " + obj.op2.place) ? 1 : 0
				self.literal = true
			}

			self.type = new Type("boolean", "basic", 1, 0, 0)

			return self
		},

		boolean_type_array: ["boolean"],
		numeric_type_array: ["int", "short", "long", "char", "byte", "float"],

		compare_types: function(type1, type2) {
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
			var labels = {}
			var line_number = 0
			var code = $1.code.concat($2.code)
			var filtered_code = []

			for (var index in code) {
				var line = code[index].split(ir_sep)

				if (line[0] == "label") {
					labels[line[1]] = line_number + 1
				}
				else {
					line_number += 1
					filtered_code.push(code[index])
				}
			}

			for (var index in filtered_code) {
				var line = filtered_code[index].split(ir_sep)

				if (line[0] == "jump") {
					line[1] = labels[line[1]]
				}
				else if (line[0] == "ifgoto") {
					line[4] = labels[line[4]]
				}

				filtered_code[index] = line.join("\t")
			}

			return filtered_code
		}
	|
		import_decrs 'EOF' 
		{
			return $1.code
		}
	|
		type_decrs 'EOF' 
		{
			var labels = {}
			var line_number = 0
			var code = $1.code
			var filtered_code = []

			for (var index in code) {
				var line = code[index].split(ir_sep)

				if (line[0] == "label") {
					labels[line[1]] = line_number + 1
				}
				else {
					line_number += 1
					filtered_code.push(code[index])
				}
			}

			for (var index in filtered_code) {
				var line = filtered_code[index].split(ir_sep)

				if (line[0] == "jump") {
					line[1] = labels[line[1]]
				}
				else if (line[0] == "ifgoto") {
					line[4] = labels[line[4]]
				}

				filtered_code[index] = line.join("\t")
			}

			return filtered_code
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
			ST.import($identifier)
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
		{ $$ = { code: [], place: null } }
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
			$$ = { name: $2, type: $1 }
		}
	;


field_decr :
		'public' type var_declarators 'terminator' 
		{
			$$ = utils.assign({
				type: $2,
				var_declarators: $3
			})
		}
	|
		type var_declarators 'terminator' 
		{
			$$ = utils.assign({
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
		method_declarator method_body 
		{
			var scope = ST.scope_end()

			var method = $1.method

			if (scope.return_types.length == 0 && method.return_type.type != "null") {
				throw Error("A method with a defined return type must have a return statement")
			}
			else {
				for (var index in scope.return_types) {
					var return_type = scope.return_types[index]
					if (!(return_type.get_serial_type() == method.return_type.get_serial_type() || (method.return_type.numeric() && return_type.numeric()))) {
						throw Error("The return type '" + return_type.get_serial_type() + "' does not match with the method's return type '" + method.return_type.get_serial_type() + "'")
					}
					else if (return_type.category == "array" && return_type.get_size() != method.return_type.get_size()) {
						throw Error("Array dimensions do not match")
					}
				}
			}

			$$ = { code: [], place: null }

			$$.code.push(
				"function" + ir_sep + method.name
			)

			for (var index = method.parameters.length - 1; index >= 0; index--) {
				$$.code.push(
					"arg" + ir_sep + method.parameters[index].display_name + ir_sep + method.parameters[index].type.category + ir_sep + method.parameters[index].type.get_basic_type() + ir_sep + method.parameters[index].type.get_size()
				)
			}
			$$.code = $$.code.concat($2.code)

			if (method.return_type.type == "null") {
				$$.code.push("return")
			}
			else {
				$$.code = $$.code.concat([
					"error" + ir_sep + "function_return",
					"exit"
				])
			}
		}
	;


method_declarator :
		'public' 'void' 'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{
			$$ = {
				name: $identifier,
				scope: null,
				method: null
			}

			var scope = ST.scope_start(category = "function")
			var parameters = []

			for (var index in $5) {
				ST.variables_count += 1
				var variable = scope.add_variable($5[index].name, $5[index].type, ST.variables_count, isparam = true)
				scope.parameters[variable.name] = variable
				parameters.push(variable)
			}

			$$.method = ST.add_method($identifier, new Type("null", "basic", null, null, 0), parameters, scope)

			$$.scope = scope
		}
	|
		'public' type 'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{
			$$ = {
				name: $identifier,
				scope: null,
				method: null
			}

			var scope = ST.scope_start(category = "function")
			var parameters = []

			for (var index in $5) {
				ST.variables_count += 1
				var variable = scope.add_variable($5[index].name, $5[index].type, ST.variables_count, isparam = true)
				scope.parameters[variable.name] = variable
				parameters.push(variable)
			}

			$$.method = ST.add_method($identifier, $2, parameters, scope)

			$$.scope = scope
		}
	|
		'void' 'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{
			$$ = {
				name: $identifier,
				scope: null,
				method: null
			}

			var scope = ST.scope_start(category = "function")
			var parameters = []

			for (var index in $4) {
				ST.variables_count += 1
				var variable = scope.add_variable($4[index].name, $4[index].type, ST.variables_count, isparam = true)
				scope.parameters[variable.name] = variable
				parameters.push(variable)
			}

			$$.method = ST.add_method($identifier, new Type("null", "basic", null, null, 0), parameters, scope)
			
			$$.scope = scope
		}
	|
		type 'identifier' 'paranthesis_start' formal_parameter_list 'paranthesis_end' 
		{
			$$ = {
				name: $identifier,
				scope: null,
				method: null
			}

			var scope = ST.scope_start(category = "function")
			var parameters = []

			for (var index in $4) {
				ST.variables_count += 1
				var variable = scope.add_variable($4[index].name, $4[index].type, ST.variables_count, isparam = true)
				scope.parameters[variable.name] = variable
				parameters.push(variable)
			}

			$$.method = ST.add_method($identifier, $1, parameters, scope)

			$$.scope = scope
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
			$$ = utils.assign({
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
		if_then_stmt 
		{
			$$ = $1
		}
	|
		if_then_else_stmt 
		{
			$$ = $1
		}
	|
		while_stmt 
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
		if_then_else_stmt_nsi 
		{
			$$ = $1
		}
	|
		while_stmt_nsi 
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
					break
				}
				else if (scope.category == "for_inner") {
					$$.code.push(
						"jump" + ir_sep + scope.parent.label_end
					)
					break
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
					break
				}
				else if (scope.category == "for_inner") {
					$$.code.push(
						"jump" + ir_sep + scope.label_end
					)
					break
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
			$$ = { code: $2.code, place: null }

			var scope = ST.current_scope
			while (!(scope.parent instanceof Class)) {
				scope = scope.parent
			}

			scope.return_types.push($2.type)

			$$.code.push(
				"return" + ir_sep + $2.place
			)
		}
	|
		'return' 'terminator' 
		{
			$$ = { code: ["return"], place: null }

			var scope = ST.current_scope
			while (!(scope.parent instanceof Class)) {
				scope = scope.parent
			}

			scope.return_type = new Type("null", "basic", null, null, 0)
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
	|
		for_scope_start 'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' 'paranthesis_end' for_inner_scope_start stmt 
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
			
			$$.code = $$.code.concat($10.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' for_init 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' for_inner_scope_start stmt 
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
			
			$$.code = $$.code.concat($10.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			for (var index in $7) {
				$$.code = $$.code.concat($7[index].code)
			}

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' for_init 'terminator' 'terminator' 'paranthesis_end' for_inner_scope_start stmt 
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

			$$.code = $$.code.concat($9.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' for_inner_scope_start stmt 
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($5.code)

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $5.place + ir_sep + "0" + ir_sep + $$.scope.label_end
			)
			
			$$.code = $$.code.concat($10.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			for (var index in $7) {
				$$.code = $$.code.concat($7[index].code)
			}

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' 'terminator' expr 'terminator' 'paranthesis_end' for_inner_scope_start stmt 
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($5.code)

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $5.place + ir_sep + "0" + ir_sep + $$.scope.label_end
			)
			
			$$.code = $$.code.concat($9.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' for_inner_scope_start stmt 
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($9.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			for (var index in $6) {
				$$.code = $$.code.concat($6[index].code)
			}

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' 'terminator' 'terminator' 'paranthesis_end' for_inner_scope_start stmt 
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($8.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

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
	|
		for_scope_start 'for' 'paranthesis_start' for_init 'terminator' expr 'terminator' 'paranthesis_end' for_inner_scope_start stmt_nsi
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
			
			$$.code = $$.code.concat($10.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' for_init 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' for_inner_scope_start stmt_nsi
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
			
			$$.code = $$.code.concat($10.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			for (var index in $7) {
				$$.code = $$.code.concat($7[index].code)
			}

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' for_init 'terminator' 'terminator' 'paranthesis_end' for_inner_scope_start stmt_nsi
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

			$$.code = $$.code.concat($9.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' 'terminator' expr 'terminator' stmt_expr_list 'paranthesis_end' for_inner_scope_start stmt_nsi
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($5.code)

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $5.place + ir_sep + "0" + ir_sep + $$.scope.label_end
			)
			
			$$.code = $$.code.concat($10.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			for (var index in $7) {
				$$.code = $$.code.concat($7[index].code)
			}

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' 'terminator' expr 'terminator' 'paranthesis_end' for_inner_scope_start stmt_nsi
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($5.code)

			$$.code.push(
				"ifgoto" + ir_sep + "eq" + ir_sep + $5.place + ir_sep + "0" + ir_sep + $$.scope.label_end
			)
			
			$$.code = $$.code.concat($9.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' 'terminator' 'terminator' stmt_expr_list 'paranthesis_end' for_inner_scope_start stmt_nsi
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($9.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

			for (var index in $6) {
				$$.code = $$.code.concat($6[index].code)
			}

			$$.code = $$.code.concat([
				"jump" + ir_sep + inner_scope.label_start,
				"label" + ir_sep + $$.scope.label_end
			])
		}
	|
		for_scope_start 'for' 'paranthesis_start' 'terminator' 'terminator' 'paranthesis_end' for_inner_scope_start stmt_nsi
		{
			var inner_scope = ST.scope_end()

			$$ = { code: [], place: null, scope: ST.scope_end() }

			$$.code.push(
				"label" + ir_sep + $$.scope.label_start
			)
			
			$$.code.push(
				"label" + ir_sep + inner_scope.label_start
			)

			$$.code = $$.code.concat($8.code)

			$$.code.push(
				"label" + ir_sep + inner_scope.label_end
			)

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
			$$ = utils.assign({
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


switch_stmt :
		'switch' 'paranthesis_start' expr 'paranthesis_end' switch_block 
		{ $$ = { nt: 'switch_stmt', children: [{ t: 'switch', l: $switch },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },$5] } }
	;


switch_block :
		'set_start' switch_block_stmt_groups switch_labels 'set_end' 
		{ $$ = { nt: 'switch_block', children: [{ t: 'set_start', l: $set_start },$2,$3,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' switch_labels 'set_end' 
		{ $$ = { nt: 'switch_block', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' switch_block_stmt_groups 'set_end' 
		{ $$ = { nt: 'switch_block', children: [{ t: 'set_start', l: $set_start },$2,{ t: 'set_end', l: $set_end }] } }
	|
		'set_start' 'set_end' 
		{ $$ = { nt: 'switch_block', children: [{ t: 'set_start', l: $set_start },{ t: 'set_end', l: $set_end }] } }
	;


switch_block_stmt_groups :
		switch_block_stmt_groups switch_block_stmt_group 
		{ $$ = { nt: 'switch_block_stmt_groups', children: [$1,$2] } }
	|
		switch_block_stmt_group 
		{ $$ = { nt: 'switch_block_stmt_groups', children: [$1] } }
	;


switch_block_stmt_group :
		switch_labels block_stmts 
		{ $$ = { nt: 'switch_block_stmt_group', children: [$1,$2] } }
	;


switch_labels :
		switch_labels switch_label 
		{ $$ = { nt: 'switch_labels', children: [$1,$2] } }
	|
		switch_label 
		{ $$ = { nt: 'switch_labels', children: [$1] } }
	;


switch_label :
		'case' literal 'colon' 
		{ $$ = { nt: 'switch_label', children: [{ t: 'case', l: $case },$2,{ t: 'colon', l: $colon }] } }
	|
		'case' 'paranthesis_start' literal 'paranthesis_end' 'colon' 
		{ $$ = { nt: 'switch_label', children: [{ t: 'case', l: $case },{ t: 'paranthesis_start', l: $paranthesis_start },$3,{ t: 'paranthesis_end', l: $paranthesis_end },{ t: 'colon', l: $colon }] } }
	|
		'default' 'colon' 
		{ $$ = { nt: 'switch_label', children: [{ t: 'default', l: $default },{ t: 'colon', l: $colon }] } }
	;



expr :
		cond_or_expr 
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
		left_hand_side assignment_operator expr 
		{
			$$ = { code: [], place: $1.place, type: $1.type }

			if (!($1.type.get_serial_type() == $3.type.get_serial_type() || ($1.type.numeric() && $3.type.numeric()))) {
				throw Error("Cannot convert '" + $3.type.get_serial_type() + "' to '" + $1.type.get_serial_type + "'")
			}

			if ($1.type.category == "array" && $1.type.get_size() != $3.type.get_size()) {
				throw Error("Array dimensions do not match")
			}

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
			$$ = { code: [], place: null, type: $1.type }

			if (!($1.type.get_serial_type() == $3.type.get_serial_type() || ($1.type.numeric() && $3.type.numeric()))) {
				throw Error("Cannot convert '" + $3.type.get_serial_type() + "' to '" + $1.type.get_serial_type() + "'")
			}

			$$.code = $3.code.concat($1.code)

			if ($2.third) {
				var temp = ST.create_temporary()

				$$.code = $$.code.concat([
					"decr" + ir_sep + temp + ir_sep + $1.type.type,
					"arrget" + ir_sep + temp + ir_sep + $1.place + ir_sep + $1.offset,
					$2.operator + ir_sep + temp + ir_sep + temp + ir_sep + $3.place,
					"arrset" + ir_sep + $1.place + ir_sep + $1.offset + ir_sep + temp,
				])

				$$.place = temp
			}
			else {
				$$.code.push(
					"arrset" + ir_sep + $1.place + ir_sep + $1.offset + ir_sep + $3.place,
				)
				
				$$.place = $3.place
			}
		}
	;


left_hand_side :
		expr_name 
		{
			$$ = $1

			var variable = ST.lookup_variable($$.place)
			$$.place = variable.display_name
			$$.type = variable.type
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
			var invalid = ["float"]
			if (invalid.indexOf($1.type.get_serial_type()) > -1 || invalid.indexOf($3.type.get_serial_type()) > -1) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '||'")
			}

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
			var invalid = ["float"]
			if (invalid.indexOf($1.type.get_serial_type()) > -1 || invalid.indexOf($3.type.get_serial_type()) > -1) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '&&'")
			}

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
			var invalid = ["float"]
			if (invalid.indexOf($1.type.get_serial_type()) > -1 || invalid.indexOf($3.type.get_serial_type()) > -1) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '|'")
			}

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
			var invalid = ["float"]
			if (invalid.indexOf($1.type.get_serial_type()) > -1 || invalid.indexOf($3.type.get_serial_type()) > -1) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '^'")
			}

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
			var invalid = ["float"]
			if (invalid.indexOf($1.type.get_serial_type()) > -1 || invalid.indexOf($3.type.get_serial_type()) > -1) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '&'")
			}

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
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Incomparable operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '<='")
			}

			$$ = utils.relational({
				op1: $1,
				op2: $3,
				operator: "eq"
			})
		}
	|
		equality_expr 'op_notequalCompare' relational_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Incomparable operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on operator '!='")
			}

			$$ = utils.relational({
				op1: $1,
				op2: $3,
				operator: "ne"
			})
		}
	;


relational_expr :
		additive_expr 
		{
			$$ = $1
		}
	|
		relational_expr 'op_greater' additive_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Incomparable operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on operator '>'")
			}

			$$ = utils.relational({
				op1: $1,
				op2: $3,
				operator: "gt"
			})
		}
	|
		relational_expr 'op_greaterEqual' additive_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Incomparable operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on operator '>='")
			}

			$$ = utils.relational({
				op1: $1,
				op2: $3,
				operator: "ge"
			})
		}
	|
		relational_expr 'op_less' additive_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Incomparable operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on operator '<'")
			}

			$$ = utils.relational({
				op1: $1,
				op2: $3,
				operator: "lt"
			})
		}
	|
		relational_expr 'op_lessEqual' additive_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Incomparable operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on operator '<='")
			}

			$$ = utils.relational({
				op1: $1,
				op2: $3,
				operator: "le"
			})
		}
	|
		relational_expr 'instanceof' additive_expr 
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
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '<<'")
			}

			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "<<"
			})
		}
	|
		shift_expr 'op_Rshift' additive_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '>>'")
			}

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
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '+'")
			}

			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "+"
			})
		}
	|
		additive_expr 'op_sub' multiplicative_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '-'")
			}

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
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '*'")
			}

			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "*"
			})
		}
	|
		multiplicative_expr 'op_div' unary_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric()) {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '/'")
			}

			$$ = utils.binary({
				op1: $1,
				op2: $3,
				operator: "/"
			})
		}
	|
		multiplicative_expr 'op_mod' unary_expr 
		{
			if (!$1.type.numeric() || !$3.type.numeric() || $3.type.get_serial_type() == "float") {
				throw Error("Bad operand types '" + $1.type.get_serial_type() + "' and '" + $3.type.get_serial_type() + "' on binary operator '%'")
			}

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

			if (!$$.type.numeric()) {
				throw Error("Bad operand type '" + $$.type.get_serial_type() + "' on unary operator '++'")
			}

			$$.code.push(
				"dec" + ir_sep + $$.place
			)
		}
	;


preinc_expr :
		'op_increment' unary_expr 
		{
			$$ = $2

			if (!$$.type.numeric()) {
				throw Error("Bad operand type '" + $$.type.get_serial_type() + "' on unary operator '++'")
			}

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
				$$ = $2
				
				if (!$$.type.numeric()) {
					throw Error("Bad operand type '" + $$.type.get_serial_type() + "' on unary operator '-'")
				}

				var temp = ST.create_temporary()
				$$.code = $$.code.concat([
					"decr" + ir_sep + temp + ir_sep + "int",
					"=" + ir_sep + temp + ir_sep + $$.place,
					"neg" + ir_sep + temp
				])

				$$.place = temp
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
			
			if ($$.type.get_serial_type() != "boolean") {
				throw Error("Bad operand type '" + $$.type.get_serial_type() + "' on unary operator '!'")
			}

			var temp = ST.create_temporary()
			$$.code = $$.code.concat([
				"decr" + ir_sep + temp + ir_sep + "int",
				"=" + ir_sep + temp + ir_sep + $$.place,
				"not" + ir_sep + temp
			])

			$$.place = temp
		}
	|
		cast_expr 
		{
			$$ = $1
		}
	;


cast_expr :
		'paranthesis_start' primitive_type 'paranthesis_end' unary_expr 
		{
			$$ = { 
				code: $4.code,
				type: new Type($2.type, "basic", $2.width, $2.length, 0),
				place: null
			}

			if (!($4.type.category == "basic" && ($4.type.type == $2.type || ($4.type.numeric() && $$.type.numeric())))) {
				throw Error("Cannot convert '" + $4.type.get_serial_type() + "' to '" + $2.type + "'")
			}

			temp = ST.create_temporary()

			$$.code = $$.code.concat([
				"decr" + ir_sep + temp + ir_sep + $2.type,
				"cast" + ir_sep + temp + ir_sep + $4.type.type + ir_sep + $2.type + ir_sep + $4.place
			])

			$$.place = temp
		}
	;


postdec_expr :
		postfix_expr 'op_decrement' 
		{
			$$ = { code: $1.code, place: null, type: $1.type }

			if (!$1.type.numeric()) {
				throw Error("Bad operand type '" + $1.type.get_serial_type() + "' on unary operator '++'")
			}

			var temp = ST.create_temporary()

			$$.code = $$.code.concat([
				"decr" + ir_sep + temp + ir_sep + $1.type.type,
				"=" + ir_sep + temp + ir_sep + $1.place,
				"-" + ir_sep + $1.place + ir_sep + $1.place + ir_sep + "1"
			])

			$$.place = temp
		}
	|
		post_expr 'op_decrement' 
		{
			$$ = { code: $1.code, place: null, type: $1.type }

			if (!$1.type.numeric()) {
				throw Error("Bad operand type '" + $1.type.get_serial_type() + "' on unary operator '++'")
			}

			var temp = ST.create_temporary()

			$$.code = $$.code.concat([
				"decr" + ir_sep + temp + ir_sep + $1.type.type,
				"=" + ir_sep + temp + ir_sep + $1.place,
				"-" + ir_sep + $1.place + ir_sep + $1.place + ir_sep + "1"
			])

			$$.place = temp
		}
	;


postinc_expr :
		postfix_expr 'op_increment' 
		{
			$$ = { code: $1.code, place: null, type: $1.type }

			if (!$1.type.numeric()) {
				throw Error("Bad operand type '" + $1.type.get_serial_type() + "' on unary operator '++'")
			}

			var temp = ST.create_temporary()

			$$.code = $$.code.concat([
				"decr" + ir_sep + temp + ir_sep + $1.type.type,
				"=" + ir_sep + temp + ir_sep + $1.place,
				"+" + ir_sep + $1.place + ir_sep + $1.place + ir_sep + "1"
			])

			$$.place = temp
		}
	|
		post_expr 'op_increment' 
		{
			$$ = { code: $1.code, place: null, type: $1.type }

			if (!$1.type.numeric()) {
				throw Error("Bad operand type '" + $1.type.get_serial_type() + "' on unary operator '++'")
			}

			var temp = ST.create_temporary()

			$$.code = $$.code.concat([
				"decr" + ir_sep + temp + ir_sep + $1.type.type,
				"=" + ir_sep + temp + ir_sep + $1.place,
				"+" + ir_sep + $1.place + ir_sep + $1.place + ir_sep + "1"
			])

			$$.place = temp
		}
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

			var variable = ST.lookup_variable($$.place)
			$$.place = variable.display_name
			$$.type = variable.type
		}
	;


method_invocation :
		expr_name 'paranthesis_start' argument_list 'paranthesis_end' 
		{
			$$ = { code: [], place: null, type: null }

			var method = ST.lookup_method($1.place)

			if ($3.length != method.num_parameters) {
				throw Error("The method " + method.name + " requires " + method.num_parameters + ", provided" + $3.length)
			}

			for (var index in $3) {
				$$.code = $$.code.concat($3[index].code)

				if (!($3[index].type.get_serial_type() == method.parameters[index].type.get_serial_type() || ($3[index].type.numeric() && method.parameters.type.numeric()))) {
					throw Error("Argument must be of type " + method.parameters[index].type.get_serial_type())
				}
				if ($3[index].type.category == "array" && $3[index].type.get_size() != method.parameters[index].type.get_size()) {
					throw Error("Array dimensions do not match")
				}
			}
			for (var index in $3) {
				$$.code.push(
					"param" + ir_sep + $3[index].place
				)
			}

			if (method.return_type.type != "null") {
				temp = ST.create_temporary()


				if (method.return_type.category == "basic") {
					$$.code.push(
						"decr" + ir_sep + temp + ir_sep + method.return_type.type,
					)
				}
				else {
					$$.code.push(
						"decr" + ir_sep + temp + ir_sep + method.return_type.category + ir_sep + method.return_type.get_basic_type() + ir_sep + method.return_type.get_size(),
					)
				}

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

			$$.type = method.return_type
		}
	|
		expr_name 'paranthesis_start' 'paranthesis_end' 
		{
			$$ = { code: [], place: null, type: null }

			var method = ST.lookup_method($1.place)

			if (method.num_parameters) {
				throw Error("The method " + method.name + " requires " + method.num_parameters + ", provided 0")
			}

			if (method.return_type.type != "null") {
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

			$$.type = method.return_type
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
			$$ = { code: [], place: null, offset: null, type: null }

			var temp = ST.create_temporary()

			var array = ST.lookup_variable($1.place)
			var type = array.type

			$$.code = $$.code.concat([
				"decr" + ir_sep + temp + ir_sep + "int",
				"=" + ir_sep + temp + ir_sep + "0"
			])

			var first = true

			for (var index in $3) {
				var dim = $3[index]

				if (dim.type.category != "basic" && dim.type.type != "int") {
					throw Error("Array indices can only be of type (int)")
				}
				if (type.category != "array") {
					throw Error("Array dimensions do not match")
				}
				
				$$.code = $$.code.concat(dim.code)

				if (first) {
					$$.code.push(
						"+" + ir_sep + temp + ir_sep + temp + ir_sep + dim.place
					)
					first = false
				}
				else {
					$$.code = $$.code.concat([
						"*" + ir_sep + temp + ir_sep + temp + ir_sep + type.length,
						"+" + ir_sep + temp + ir_sep + temp + ir_sep + dim.place
					])
				}

				type = type.type
			}

			if (type.category == "array") {
				throw Error("Array dimensions do not match")
			}

			$$.place = array.display_name
			$$.offset = temp
			$$.type = type
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
			$$ = { code: $1.code, place: null, type: null }

			$$.place = ST.create_temporary()

			$$.code.push(
				"arrget" + ir_sep + $$.place + ir_sep + $1.place + ir_sep + $1.offset
			)

			$$.type = $1.type
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
			
			if ($2.type.get_serial_type() != "int") {
				throw Error("Array dimension should be of int type")
			}
		}
	;


expr_name :
		'identifier' 
		{
			$$ = {
				code: [],
				place: $identifier,
				type: null
			}
		}
	|
		expr_name 'field_invoker' 'identifier' 
		{
			$$ = {
				code: [],
				place: $identifier,
				type: null
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
				type: new Type("int", "basic", 4, null, 0)
			}
		}
	|
		'float_literal' 
		{
			$$ = {
				code: [],
				place: $float_literal,
				literal: true,
				type: new Type("float", "basic", 4, null, 0)
			}
		}
	|
		'boolean_literal' 
		{
			$$ = {
				code: [],
				place: ($boolean_literal == "true") ? 1 : 0,
				literal: true,
				type: new Type("boolean", "basic", 1, null, 0)
			}
		}
	|
		'character_literal' 
		{
			$$ = {
				code: [],
				place: $character_literal.charCodeAt(1).toString(),
				literal: true,
				type: new Type("int", "basic", 4, null, 0)
			}
		}
	|
		'null_literal' 
		{
			$$ = {
				code: [],
				place: $null_literal,
				literal: true,
				type: new Type("null", "basic", null, null, 0)
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


