%moduleName MyLexer

%%

digit					=	[0-9]

letter					=	[a-zA-Z]
lcase_letter			=	[a-z]
ucase_letter			=	[A-Z]

underscore				=	_

keyword_const			=	const
keyword_static			=	static

keyword_int				=	int
keyword_long			=	long
keyword_char			=	char
keyword_void			=	void
keyword_byte			=	byte
keyword_short			=	short
keyword_float			=	float
keyword_double			=	double
keyword_boolean			=	boolean

keyword_break			=	break
keyword_continue		=	continue

keyword_case			=	case
keyword_switch			=	switch
keyword_default			=	default

keyword_new				=	new
keyword_this			=	this
keyword_class			=	class
keyword_super			=	super
keyword_extends			=	extends
keyword_instanceof		=	instanceof

keyword_for				=	for
keyword_do				=	do
keyword_while			=	while

keyword_return			=	return

keyword_if				=	if
keyword_else			=	else

keyword_import			=	import

%%

// ----------------------------------- KEYWORDS -----------------------------------

<>{keyword_boolean}
{
	return 'keyword_boolean';
}

<>{keyword_break}
{
	return 'keyword_break';
}

<>{keyword_byte}
{
	return 'keyword_byte';
}

<>{keyword_case}
{
	return 'keyword_case';
}
<>{keyword_char}
{
	return 'keyword_char';
}

<>{keyword_class}
{
	return 'keyword_class';
}
<>{keyword_const}
{
	return 'keyword_const';
}
<>{keyword_continue}
{
	return 'keyword_continue';
}
<>{keyword_default}
{
	return 'keyword_default';
}
<>{keyword_do}
{
	return 'keyword_do';
}
<>{keyword_double}
{
	return 'keyword_double';
}
<>{keyword_else}
{
	return 'keyword_else';
}
<>{keyword_extends}
{
	return 'keyword_extends';
}
<>{keyword_float}
{
	return 'keyword_float';
}
<>{keyword_for}
{
	return 'keyword_for';
}
<>{keyword_if}
{
	return 'keyword_if';
}
<>{keyword_import}
{
	return 'keyword_import';
}
<>{keyword_instanceof}
{
	return 'keyword_instanceof';
}
<>{keyword_int}
{
	return 'keyword_int';
}
<>{keyword_long}
{
	return 'keyword_long';
}
<>{keyword_new}
{
	return 'keyword_new';
}
<>{keyword_return}
{
	return 'keyword_return';
}
<>{keyword_short}
{
	return 'keyword_short';
}
<>{keyword_static}
{
	return 'keyword_static';
}
<>{keyword_super}
{
	return 'keyword_super';
}
<>{keyword_switch}
{
	return 'keyword_switch';
}
<>{keyword_this}
{
	return 'keyword_this';
}
<>{keyword_void}
{
	return 'keyword_void';
}
<>{keyword_while}
{
	return 'keyword_while';
}




// ------------------------------------ TOKENS ------------------------------------

<>{digit}*\.{digit}+
{
	this.jjval = parseFloat(this.jjtext);
	return 'float';
}

<>{digit}+
{
	this.jjval = parseInt(this.jjtext);
	return 'integer';
}

<>{letter}+({underscore}*{letter}*{digit}*)*
{
	return 'identifier';
}




// ------------------------------------ OTHERS ------------------------------------

<>\s* { }

<>[^\s]+ { return 'invalid'; }

<>$   { console.log('EOF'); return 'EOF'; }
