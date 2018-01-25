%moduleName MyLexer

%%

digit			=	[0-9]

letter			=	[a-zA-Z]
lcase_letter	=	[a-z]
ucase_letter	=	[A-Z]

underscore		=	_

const			=	const
static			=	static

int				=	int
long			=	long
char			=	char
void			=	void
byte			=	byte
short			=	short
float			=	float
double			=	double
boolean			=	boolean

break			=	break
continue		=	continue

case			=	case
switch			=	switch
default			=	default

new				=	new
this			=	this
class			=	class
super			=	super
extends			=	extends
instanceof		=	instanceof

for				=	for
do				=	do
while			=	while

return			=	return

if				=	if
else			=	else

import			=	import

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

<>{letter}\w*
{
	return "identifier";
}


// ------------------------------------ OTHERS ------------------------------------

<>\s* { }

<>[^\s]+ { return "invalid"; }

<>$   { console.log("EOF"); return "EOF"; }
