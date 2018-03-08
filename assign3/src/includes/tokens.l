%moduleName MyLexer

%%

digit					=	[0-9]

letter					=	[a-zA-Z]
lcase_letter			=	[a-z]
ucase_letter			=	[A-Z]

underscore				=	_
dollar					=	\$

CONST					=	const
STATIC					=	static

INT						=	int
LONG					=	long
CHAR					=	char
VOID					=	void
BYTE					=	byte
SHORT					=	short
FLOAT					=	float
DOUBLE					=	double
BOOLEAN					=	boolean
PUBLIC					=	public

BREAK					=	break
CONTINUE				=	continue

CASE					=	case
SWITCH					=	switch
DEFAULT					=	default

NEW						=	new
THIS					=	this
CLASS					=	class
SUPER					=	super
EXTENDS					=	extends
INSTANCEOF				=	instanceof

FOR						=	for
DO						=	do
WHILE					=	while

RETURN					=	return

IF						=	if
ELSE					=	else

IMPORT					=	import

op_increment			=	[+][+]
op_decrement			=	[-][-]
op_add					=	[+]
op_sub					=	[-]
op_mul					=	[*]
op_div					=	[/]
op_mod					=	[%]
op_addAssign			=	[+][=]
op_subAssign			=	[-][=]
op_mulAssign			=	[*][=]
op_divAssign			=	[/][=]
op_modAssign			=	[%][=]
op_andAssign			=	[&][=]
op_orAssign				=	[|][=]
op_xorAssign			=	[\^][=]
op_notequalCompare		=	[!][=]
op_equalCompare			=	[=][=]
op_LshiftEqual			=	[<][<][=]
op_RshiftEqual			=	[>][>][=]
op_greaterEqual			=	[>][=]
op_lessEqual			=	[<][=]
op_Lshift				=	[<][<]
op_Rshift				=	[>][>]
op_greater				=	[>]
op_less					=	[<]
op_assign				=	[=]
op_andand				=	[&][&]
op_oror					=	[|][|]
op_and					=	[&]
op_or					=	[|]
op_not					=	[!]
op_xor					=	[\^]

%%

// ----------------------------------- KEYWORDS -----------------------------------

<>{BOOLEAN}
{
	return "boolean";
}

<>{BREAK}
{
	return "break";
}

<>{BYTE}
{
	return "byte";
}

<>{CASE}
{
	return "case";
}
<>{CHAR}
{
	return "char";
}

<>{CLASS}
{
	return "class";
}
<>{CONST}
{
	return "const";
}
<>{CONTINUE}
{
	return "continue";
}
<>{DEFAULT}
{
	return "default";
}
<>{DO}
{
	return "do";
}
<>{DOUBLE}
{
	return "double";
}
<>{ELSE}
{
	return "else";
}
<>{EXTENDS}
{
	return "extends";
}
<>{FLOAT}
{
	return "float";
}
<>{FOR}
{
	return "for";
}
<>{IF}
{
	return "if";
}
<>{IMPORT}
{
	return "import";
}
<>{INSTANCEOF}
{
	return "instanceof";
}
<>{INT}
{
	return "int";
}
<>{LONG}
{
	return "long";
}
<>{NEW}
{
	return "new";
}
<>{PUBLIC}
{
	return "public";
}
<>{RETURN}
{
	return "return";
}
<>{SHORT}
{
	return "short";
}
<>{STATIC}
{
	return "static";
}
<>{SUPER}
{
	return "super";
}
<>{SWITCH}
{
	return "switch";
}
<>{THIS}
{
	return "this";
}
<>{VOID}
{
	return "void";
}
<>{WHILE}
{
	return "while";
}





// ------------------------------------ TOKENS ------------------------------------

<>{op_increment}
{
	return "op_increment";
}

<>{op_decrement}
{
	return "op_decrement";
}

<>{op_add}
{
	return "op_add";
}

<>{op_sub}
{
	return "op_sub";
}

<>{op_mul}
{
	return "op_mul";
}

<>{op_div}
{
	return "op_div";
}

<>{op_mod}
{
	return "op_mod";
}

<>{op_addAssign}
{
	return "op_addAssign";
}

<>{op_subAssign}
{
	return "op_subAssign";
}

<>{op_mulAssign}
{
	return "op_mulAssign";
}

<>{op_divAssign}
{
	return "op_divAssign";
}

<>{op_modAssign}
{
	return "op_modAssign";
}

<>{op_andAssign}
{
	return "op_andAssign";
}

<>{op_orAssign}
{
	return "op_orAssign";
}

<>{op_xorAssign}
{
	return "op_xorAssign";
}

<>{op_notequalCompare}
{
	return "op_notequalCompare";
}

<>{op_equalCompare}
{
	return "op_equalCompare";
}

<>{op_LshiftEqual}
{
	return "op_LshiftEqual";
}

<>{op_RshiftEqual}
{
	return "op_RshiftEqual";
}

<>{op_greaterEqual}
{
	return "op_greaterEqual";
}

<>{op_lessEqual}
{
	return "op_lessEqual";
}

<>{op_Lshift}
{
	return "op_Lshift";
}

<>{op_Rshift}
{
	return "op_Rshift";
}

<>{op_greater}
{
	return "op_greater";
}

<>{op_less}
{
	return "op_less";
}

<>{op_assign}
{
	return "op_assign";
}

<>{op_andand}
{
	return "op_andand";
}

<>{op_oror}
{
	return "op_oror";
}

<>{op_and}
{
	return "op_and";
}

<>{op_or}
{
	return "op_or";
}

<>{op_not}
{
	return "op_not";
}

<>{op_xor}
{
	return "op_xor";
}

<>:
{
	return "colon";
}





// ------------------------------------ TOKENS ------------------------------------

<>{digit}+\.{digit}*
{
	return "float_literal";
}

<>{digit}+
{
	return "integer_literal";
}

<>true|false
{
	return "boolean_literal";
}

<>null
{
	return "null_literal";
}

<>\"(\\.|[^\\\"])*\"
{
	return "string_literal";
}

<>\'(\\.|[^\\\'])\'
{
	return "character_literal";
}

<>({letter}|{dollar}|{underscore})({letter}|{dollar}|{underscore}|{digit})*
{
	return "identifier";
}

<>;
{
	return "terminator";
}

<>\.
{
	return "field_invoker";
}

<>,
{
	return "separator";
}

// Bracket Enclosers

<>\(
{
	return "paranthesis_start";
}

<>\)
{
	return "paranthesis_end";
}

<>\[
{
	return "brackets_start";
}

<>\]
{
	return "brackets_end";
}

<>{
{
	return "set_start";
}

<>}
{
	return "set_end";
}

// Comments

<>\/\/.*
{
	return "comment";
}

<>\/\*
{
	this.pushState('BLOCKCOMMENT');
	return "blockcomment_start";
}

<BLOCKCOMMENT>\*\/    
{
	this.popState();
	return "blockcomment_end";
}

<BLOCKCOMMENT>(\n|\r|.) {}





// ------------------------------------ OTHERS ------------------------------------

<>\s* { }

<>. {
	return this.jjtext;
}

<>$   { console.log("EOF"); return "EOF"; }