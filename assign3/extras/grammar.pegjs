compilation_unit                          =    import_declarations? type_declarations? ;

import_declarations                       =    import_declaration / import_declarations import_declaration;

import_declaration                        =    single_type_import_declaration;

single_type_import_declaration            =    "import" type_name "terminator";

type_declarations                         =    type_declaration / type_declarations type_declaration;

type_declaration                          =    class_declaration / "terminator";

class_declaration                         =    class_modifiers? "class" identifier super? class_body;

class_modifiers                           =    class_modifier / class_modifiers class_modifier;

class_modifier                            =    "public";

super                                     =    "extends" class_type;

class_body                                =    "set_start" class_body_declarations? "set_end";

class_body_declarations                   =    class_body_declaration / class_body_declarations class_body_declaration;

class_body_declaration                    =    class_member_declaration / static_initializer / constructor_declaration;

class_member_declaration                  =    field_declaration / method_declaration;

static_initializer                        =    "static" block;

constructor_declaration                   =    constructor_modifiers? constructor_declarator constructor_body;

constructor_modifiers                     =    constructor_modifier / constructor_modifiers constructor_modifier;

constructor_modifier                      =    "public";

constructor_declarator                    =    type_name "paranthesis_start" formal_parameter_list? "paranthesis_end";

formal_parameter_list                     =    formal_parameter / formal_parameter_list "separator" formal_parameter;

formal_parameter                          =    type variable_declarator_id;

constructor_body                          =    "set_start" explicit_constructor_invocation? block_statements? "set_end";

explicit_constructor_invocation           =    "this" "paranthesis_start" argument_list? "paranthesis_end" / "super" "paranthesis_start" argument_list? "paranthesis_end";

field_declaration                         =    field_modifiers? type variable_declarators "terminator";

field_modifiers                           =    field_modifier / field_modifiers field_modifier;

field_modifier                            =    "public" / "static";

variable_declarators                      =    variable_declarator / variable_declarators "separator" variable_declarator;

variable_declarator                       =    variable_declarator_id / variable_declarator_id "op_assign" variable_initializer;

variable_declarator_id                    =    identifier / variable_declarator_id "brackets_start" "brackets_end";

variable_initializer                      =    expression / array_initializer;

method_declaration                        =    method_header method_body;

method_header                             =    method_modifiers? result_type method_declarator;

result_type                               =    type / "void";

method_modifiers                          =    method_modifier / method_modifiers method_modifier;

method_modifier                           =    "public" / "static";

method_declarator                         =    identifier "paranthesis_start" formal_parameter_list? "paranthesis_end";

method_body                               =    block / "terminator";

constant_declaration                      =    constant_modifiers type variable_declarator;

constant_modifiers                        =    "public" / "static";

array_initializer                         =    "set_start" variable_initializers? "separator" ? "set_end";

variable_initializers                     =    variable_initializer / variable_initializers "separator" variable_initializer;

variable_initializer                      =    expression / array_initializer;


type                                      =    primitive_type / reference_type;

primitive_type                            =    numeric_type / "boolean";

numeric_type                              =    integral_type / floating"op_sub"point_type;

integral_type                             =    "byte" / "short" / "int" / "long" / "char";

floating_point_type                       =    "float" / "double";

reference_type                            =    class_or_interface_type / array_type;

class_or_interface_type                   =    class_type / interface_type;

class_type                                =    type_name;

interface_type                            =    type_name;

array_type                                =    type "brackets_start" "brackets_end";

block                                     =    "set_start" block_statements? "set_end";

block_statements                          =    block_statement / block_statements block_statement;

block_statement                           =    local_variable_declaration_statement / statement;

local_variable_declaration_statement      =    local_variable_declaration "terminator";

local_variable_declaration                =    type variable_declarators;

statement                                 =    statement_without_trailing_substatement / if_then_statement / if_then_else_statement / while_statement / for_statement;

statement_no_short_if                     =    statement_without_trailing_substatement / if_then_else_statement_no_short_if / while_statement_no_short_if / for_statement_no_short_if;

statement_without_trailing_substatement   =    block / empty_statement / expression_statement / switch_statement / do_statement / break_statement / continue_statement / return_statement;

empty_statement                           =    "terminator";

expression_statement                      =    statement_expression "terminator";

statement_expression                      =    assignment / preincrement_expression / postincrement_expression / predecrement_expression / postdecrement_expression / method_invocation / class_instance_creation_expression;

if_then_statement                         =    "if" "paranthesis_start" expression "paranthesis_end" statement;

if_then_else_statement                    =    "if" "paranthesis_start" expression "paranthesis_end" statement_no_short_if "else" statement;

if_then_else_statement_no_short_if        =    "if" "paranthesis_start" expression "paranthesis_end" statement_no_short_if "else" statement_no_short_if;

switch_statement                          =    "switch" "paranthesis_start" expression "paranthesis_end" switch_block;

switch_block                              =    "set_start" switch_block_statement_groups? switch_labels? "set_end";

switch_block_statement_groups             =    switch_block_statement_group / switch_block_statement_groups switch_block_statement_group;

switch_block_statement_group              =    switch_labels block_statements;

switch_labels                             =    switch_label / switch_labels switch_label;

switch_label                              =    "case" constant_expression "colon" / "default" "colon";

while_statement                           =    "while" "paranthesis_start" expression "paranthesis_end" statement;

while_statement_no_short_if               =    "while" "paranthesis_start" expression "paranthesis_end" statement_no_short_if;

do_statement                              =    "do" statement "while" "paranthesis_start" expression "paranthesis_end" "terminator";

for_statement                             =    "for" "paranthesis_start" for_init? "terminator" expression? "terminator" for_update? "paranthesis_end" statement;

for_statement_no_short_if                 =    "for" "paranthesis_start" for_init? "terminator" expression? "terminator" for_update? "paranthesis_end" statement_no_short_if;

for_init                                  =    statement_expression_list / local_variable_declaration;

for_update                                =    statement_expression_list;

statement_expression_list                 =    statement_expression / statement_expression_list "separator" statement_expression;

break_statement                           =    "break" "terminator";

continue_statement                        =    "continue" "terminator";

return_statement                          =    "return" expression? "terminator";

expression                                =    conditional_expression / assignment;

assignment                                =    left_hand_side assignment_operator expression;

left_hand_side                            =    expression_name / field_access / array_access;

assignment_operator                       =    "op_assign" / "op_mulAssign" / "op_divAssign" / "op_modAssign" / "op_addAssign" / "op_subAssign" / "op_LshiftEqual" / "op_RshiftEqual" / "op_andAssign" / "op_orAssign" / "op_xorAssign";

conditional_expression                    =    conditional_or_expression / conditional_or_expression ? expression "colon" conditional_expression;

conditional_or_expression                 =    conditional_and_expression / conditional_or_expression "op_oror" conditional_and_expression;

conditional_and_expression                =    inclusive_or_expression / conditional_and_expression "op_andand" inclusive_or_expression;

inclusive_or_expression                   =    exclusive_or_expression / inclusive_or_expression "op_or" exclusive_or_expression;

exclusive_or_expression                   =    and_expression / exclusive_or_expression "op_xor" and_expression;

and_expression                            =    equality_expression / and_expression "op_and" equality_expression;

equality_expression                       =    relational_expression / equality_expression "op_equalCompare" relational_expression / equality_expression "op_notequalCompare" relational_expression;

relational_expression                     =    shift_expression / relational_expression  "op_greater" shift_expression / relational_expression  "op_less" shift_expression / relational_expression "op_greaterEqual" shift_expression / relational_expression "op_lessEqual" shift_expression / relational_expression "instanceof" reference_type;

shift_expression                          =    additive_expression / shift_expression  "op_Lshift" additive_expression / shift_expression "op_Rshift" additive_expression;

additive_expression                       =    multiplicative_expression / additive_expression "op_add" multiplicative_expression / additive_expression "op_sub" multiplicative_expression;

multiplicative_expression                 =    unary_expression / multiplicative_expression "op_mul" unary_expression / multiplicative_expression "op_div" unary_expression / multiplicative_expression "op_mod" unary_expression;

cast_expression                           =    "paranthesis_start" primitive_type "paranthesis_end" unary_expression / "paranthesis_start" reference_type "paranthesis_end" unary_expression_not_plus_minus;

unary_expression                          =    preincrement_expression / predecrement_expression / "op_add" unary_expression / "op_sub" unary_expression / unary_expression_not_plus_minus;

predecrement_expression                   =    "op_decrement" unary_expression;

preincrement_expression                   =    "op_increment" unary_expression;

unary_expression_not_plus_minus           =    postfix_expression / "op_not" unary_expression / cast_expression;

postdecrement_expression                  =    postfix_expression "op_decrement";

postincrement_expression                  =    postfix_expression "op_increment";

postfix_expression                        =    primary / expression_name / postincrement_expression / postdecrement_expression;

method_invocation                         =    method_name "paranthesis_start" argument_list? "paranthesis_end" / primary"field_invoker"identifier"paranthesis_start" argument_list? "paranthesis_end" / "super""field_invoker"identifier "paranthesis_start" argument_list? "paranthesis_end";

field_access                              =    primary "field_invoker" identifier / "super" "field_invoker" identifier;

primary                                   =    primary_no_new_array / array_creation_expression;

primary_no_new_array                      =    literal / "this" / "paranthesis_start" expression "paranthesis_end" / class_instance_creation_expression / field_access / method_invocation / array_access;

class_instance_creation_expression        =    new_class_type "paranthesis_start" argument_list? "paranthesis_end";

argument_list                             =    expression / argument_list "separator" expression;

array_creation_expression                 =    "new" primitive_type dim_exprs dims? / "new" class_or_interface_type dim_exprs dims?;

dim_exprs                                 =    dim_expr / dim_exprs dim_expr;

dim_expr                                  =    "brackets_start" expression "brackets_end";

dims                                      =    "brackets_start" "brackets_end" / dims "brackets_start" "brackets_end";

array_access                              =    expression_name "brackets_start" expression "brackets_end" / primary_no_new_array "brackets_start" expression"brackets_end";

type_name                                 =    "identifier";

expression_name                           =    "identifier" / ambiguous_name"field_invoker""identifier";

method_name                               =    "identifier" / ambiguous_name"field_invoker""identifier";

ambiguous_name                            =    "identifier" / ambiguous_name"field_invoker""identifier";

literal                                   =    "integer_literal" / "float_literal" / "boolean_literal" / "character_literal" / "string_literal" / "null_literal";

digits                                    =    "digit" / digits "digit";

signed_integer                            =    sign? digits;

sign                                      =    "op_add" / "op_sub";

keyword                                   =    "boolean" / "break" / "byte" / "case" / "char" / "class" / "const" / "continue" / "default" / "do" / "double" / "else" / "extends" / "float" / "for" / "if" / "import" / "instanceof" / "int" / "long" / "new" / "public" / "return" / "short" / "static" / "super" / "switch" / "this" / "void" / "while";
