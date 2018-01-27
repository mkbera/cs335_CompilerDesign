%moduleName MyLexer

%%

digit			=	[0-9]

letter			=	[a-zA-Z]
lcase_letter	=	[a-z]
ucase_letter	=	[A-Z]

underscore		=	_

Const			=	const
Static			=	static

Int				=	int
Long			=	long
Char			=	char
Void			=	void
Byte			=	byte
Short			=	short
Float			=	float
Double			=	double
Boolean			=	boolean

Break			=	break
Continue		=	continue

Case			=	case
Switch			=	switch
Default			=	default

New				=	new
This			=	this
Class			=	class
Super			=	super
Extends			=	extends
Instanceof		=	instanceof

For				=	for
Do				=	do
While			=	while

Return			=	return

If				=	if
Else			=	else

Import			=	import

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

<>{boolean}
{
	return "boolean";
}

<>{break}
{
	return "break";
}

<>{byte}
{
	return "byte";
}

<>{case}
{
	return "case";
}
<>{char}
{
	return "char";
}

<>{class}
{
	return "class";
}
<>{const}
{
	return "const";
}
<>{continue}
{
	return "continue";
}
<>{default}
{
	return "default";
}
<>{do}
{
	return "do";
}
<>{double}
{
	return "double";
}
<>{else}
{
	return "else";
}
<>{extends}
{
	return "extends";
}
<>{float}
{
	return "float";
}
<>{for}
{
	return "for";
}
<>{if}
{
	return "if";
}
<>{import}
{
	return "import";
}
<>{instanceof}
{
	return "instanceof";
}
<>{int}
{
	return "int";
}
<>{long}
{
	return "long";
}
<>{new}
{
	return "new";
}
<>{return}
{
	return "return";
}
<>{short}
{
	return "short";
}
<>{static}
{
	return "static";
}
<>{super}
{
	return "super";
}
<>{switch}
{
	return "switch";
}
<>{this}
{
	return "this";
}
<>{void}
{
	return "void";
}
<>{while}
{
	return "while";
}




// ------------------------------------ TOKENS ------------------------------------

<>{digit}*\.{digit}+
{
	this.jjval = parseFloat(this.jjtext);
	return "float";
}

<>{digit}+
{
	this.jjval = parseInt(this.jjtext);
	return "integer";
}

<>{op_add}
{
	return 'op_add';
}

<>{op_sub}
{
	return 'op_sub';
}

<>{op_mul}
{
	return 'op_mul';
}

<>{op_div}
{
	return 'op_div';
}

<>{op_mod}
{
	return 'op_mod';
}

<>{op_addAssign}
{
	return 'op_addAssign';
}

<>{op_subAssign}
{
	return 'op_subAssign';
}

<>{op_mulAssign}
{
	return 'op_mulAssign';
}

<>{op_divAssign}
{
	return 'op_divAssign';
}

<>{op_modAssign}
{
	return 'op_modAssign';
}

<>{op_equalCompare}
{
	return 'op_equalCompare';
}

<>{op_LshiftEqual}
{
	return 'op_LshiftEqual';
}

<>{op_RshiftEqual}
{
	return 'op_RshiftEqual';
}

<>{op_greaterEqual}
{
	return 'op_greaterEqual';
}

<>{op_lessEqual}
{
	return 'op_lessEqual';
}

<>{op_Lshift}
{
	return 'op_Lshift';
}

<>{op_Rshift}
{
	return 'op_Rshift';
}

<>{op_greater}
{
	return 'op_greater';
}

<>{op_less}
{
	return 'op_less';
}

<>{op_assign}
{
	return 'op_assign';
}

<>{op_andand}
{
	return 'op_andand';
}

<>{op_oror}
{
	return 'op_oror';
}

<>{op_and}
{
	return 'op_and';
}

<>{op_or}
{
	return 'op_or';
}

<>{op_not}
{
	return 'op_not';
}

<>{op_xor}
{
	return 'op_xor';
}

<>true|false
{
	this.jjval = (this.jjtext == "true");
	return "boolean";
}

<>{letter}\w*
{
	return "identifier";
}

<>\"(\\.|[^\\\"])*\"
{
	return "string";
}

<>;
{
	return "terminator";
}

<>\.
{
	return "field-invoker";
}

<>,
{
	return "separator";
}

// Bracket Enclosers

<>\(
{
	return "paranthesis-start";
}

<>\)
{
	return "paranthesis-end";
}

<>\[
{
	return "brackets-start";
}

<>\]
{
	return "brackets-end";
}

<>{
{
	return "set-start";
}

<>}
{
	return "set-end";
}

// Comments

<>\/\/.*
{
	return "comment";
}

<>\/\*    
{
	this.pushState('BLOCKCOMMENT');
	return "blockcomment-start";
}

<BLOCKCOMMENT>\*\/    
{
	this.popState();
	return "blockcomment-end";
}

<BLOCKCOMMENT>(\n|\r|.) {}

// ------------------------------------ OTHERS ------------------------------------

<>\s* { }

<>$   { console.log("EOF"); return "EOF"; }
