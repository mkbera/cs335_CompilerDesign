%moduleName MyParser
 
%left 'PLUS' '-'
%left '*' '/'

expression                                =    conditional_expression | assignment

assignment                                =    left_hand_side assignment_operator assignment_expression

left_hand_side                            =    expression_name | field_access | array_access

assignment_operator                       =    = | *= | /= | %= | += | -= | = | = | &= | ^= | |=

conditional_expression                    =    conditional_or_expression | conditional_or_expression ? expression : conditional_expression

conditional_or_expression                 =    conditional_and_expression | conditional_or_expression || conditional_and_expression

conditional_and_expression                =    inclusive_or_expression | conditional_and_expression && inclusive_or_expression

inclusive_or_expression                   =    exclusive_or_expression | inclusive_or_expression #| exclusive_or_expression

exclusive_or_expression                   =    and_expression | exclusive_or_expression ^ and_expression

and_expression                            =    equality_expression | and_expression & equality_expression

equality_expression                       =    relational_expression | equality_expression == relational_expression | equality_expression != relational_expression

relational_expression                     =    shift_expression | relational_expression  << shift_expression | relational_expression  >> shift_expression | relational_expression = shift_expression | relational_expression = shift_expression | relational_expression instanceof reference_type

shift_expression                          =    additive_expression | shift_expression  << additive_expression | shift_expression >> additive_expression

additive_expression                       =    multiplicative_expression | additive_expression + multiplicative_expression | additive_expression - multiplicative_expression

multiplicative_expression                 =    unary_expression | multiplicative_expression * unary_expression | multiplicative_expression / unary_expression | multiplicative_expression % unary_expression

cast_expression                           =    ( primitive_type ) unary_expression | ( reference_type ) unary_expression_not_plus_minus

unary_expression                          =    preincrement_expression | predecrement_expression | + unary_expression | - unary_expression | unary_expression_not_plus_minus

predecrement_expression                   =    -- unary_expression

preincrement_expression                   =    ++ unary_expression

unary_expression_not_plus_minus           =    postfix_expression | ~ unary_expression | ! unary_expression | cast_expression

postdecrement_expression                  =    postfix_expression --

postincrement_expression                  =    postfix_expression ++

postfix_expression                        =    primary | expression_name | postincrement_expression | postdecrement_expression

method_invocation                         =    method_name ( argument_list? ) | primary.identifier( argument_list? ) | super.identifier ( argument_list? )

field_access                              =    primary.identifier | super.identifier

primary                                   =    primary_no_new_array | array_creation_expression

primary_no_new_array                      =    literal | this | ( expression ) | class_instance_creation_expression | field_access | method_invocation | array_access

class_instance_creation_expression        =    new_class_type ( argument_list? )

argument_list                             =    expression | argument_list , expression

array_creation_expression                 =    new primitive_type dim_exprs dims? | new class_or_interface_type dim_exprs dims?

dim_exprs                                 =    dim_expr | dim_exprs dim_expr

dim_expr                                  =    [ expression ]

dims                                      =    [ ] | dims [ ]

array_access                              =    expression_name [ expression ] | primary_no_new_array [ expression]

type_name                                 =    'identifier';

expression_name                           =    'identifier' | ambiguous_name.'identifier';

method_name                               =    'identifier' | ambiguous_name.'identifier';

ambiguous_name                            =    'identifier' | ambiguous_name.'identifier';

literal                                   =    'integer_literal' | 'float_literal' | 'boolean_literal' | 'character_literal' | 'string_literal' | 'null_literal';

digits                                    =    'digit' | digits 'digit';

signed integer                            =    sign? digits;

sign                                      =    + | -;

keyword                                   =    boolean | break | byte | case | char | class | const | continue | default | do | double | else | extends | float | for | if | import | instanceof | int | long | new | return | short | static | super | switch | this | void | while;
