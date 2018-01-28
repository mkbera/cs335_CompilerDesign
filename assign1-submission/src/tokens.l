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
	return "keyword";
}

<>{BREAK}
{
	return "keyword";
}

<>{BYTE}
{
	return "keyword";
}

<>{CASE}
{
	return "keyword";
}
<>{CHAR}
{
	return "keyword";
}

<>{CLASS}
{
	return "keyword";
}
<>{CONST}
{
	return "keyword";
}
<>{CONTINUE}
{
	return "keyword";
}
<>{DEFAULT}
{
	return "keyword";
}
<>{DO}
{
	return "keyword";
}
<>{DOUBLE}
{
	return "keyword";
}
<>{ELSE}
{
	return "keyword";
}
<>{EXTENDS}
{
	return "keyword";
}
<>{FLOAT}
{
	return "keyword";
}
<>{FOR}
{
	return "keyword";
}
<>{IF}
{
	return "keyword";
}
<>{IMPORT}
{
	return "keyword";
}
<>{INSTANCEOF}
{
	return "keyword";
}
<>{INT}
{
	return "keyword";
}
<>{LONG}
{
	return "keyword";
}
<>{NEW}
{
	return "keyword";
}
<>{PUBLIC}
{
	return "keyword";
}
<>{RETURN}
{
	return "keyword";
}
<>{SHORT}
{
	return "keyword";
}
<>{STATIC}
{
	return "keyword";
}
<>{SUPER}
{
	return "keyword";
}
<>{SWITCH}
{
	return "keyword";
}
<>{THIS}
{
	return "keyword";
}
<>{VOID}
{
	return "keyword";
}
<>{WHILE}
{
	return "keyword";
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





// ------------------------------------ TOKENS ------------------------------------

<>{digit}*\.{digit}+
{
	this.jjval = parseFloat(this.jjtext);
	return "float_literal";
}

<>{digit}+
{
	this.jjval = parseInt(this.jjtext);
	return "integer_literal";
}

<>true|false
{
	this.jjval = (this.jjtext == "true");
	return "boolean_literal";
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