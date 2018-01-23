%moduleName MyLexer
 
%%
 
digits = [0-9]
keyword_boolean = boolean  // 
keyword_break  = break
keyword_byte = byte
keyword_case = case
keyword_char = char
keyword_class = class
keyword_const = const
keyword_continue = continue
keyword_default = default
keyword_do = do
keyword_double = double
keyword_else = else
keyword_extends = extends
keyword_float = float
keyword_for = for
keyword_if = if
keyword_import = import
keyword_instanceof = instanceof
keyword_int = int
keyword_long = long
keyword_new = new
keyword_return = return
keyword_short = short //| "static" | "super" | "switch" | "this" | "void" | "while" 
keyword_static = static
keyword_super = super
keyword_switch = switch
keyword_this = this
keyword_void = void
keyword_while = while

%%
<>{keyword_boolean} {
    // this.jjval = String(this.jjtext);
    return 'keyword_boolean';
}

<>{keyword_break} {
    this.jjval = String(this.jjtext);
    return 'keyword_break';
}

<>{keyword_byte} {
    // this.jjval = String(this.jjtext);
    return 'keyword_byte';
}

<>{keyword_case} {
    // this.jjval = String(this.jjtext);
    return 'keyword_case';
}
<>{keyword_char} {
    // this.jjval = String(this.jjtext);
    return 'keyword_char';
}

<>{keyword_class} {
    // this.jjval = String(this.jjtext);
    return 'keyword_class';
}
<>{keyword_const} {
    // this.jjval = String(this.jjtext);
    return 'keyword_const';
}
<>{keyword_continue} {
    // this.jjval = String(this.jjtext);
    return 'keyword_continue';
}
<>{keyword_default} {
    // this.jjval = String(this.jjtext);
    return 'keyword_default';
}
<>{keyword_do} {
    // this.jjval = String(this.jjtext);
    return 'keyword_do';
}
<>{keyword_double} {
    // this.jjval = String(this.jjtext);
    return 'keyword_double';
}
<>{keyword_else} {
    // this.jjval = String(this.jjtext);
    return 'keyword_else';
}
<>{keyword_extends} {
    // this.jjval = String(this.jjtext);
    return 'keyword_extends';
}
<>{keyword_float} {
    // this.jjval = String(this.jjtext);
    return 'keyword_float';
}
<>{keyword_for} {
    // this.jjval = String(this.jjtext);
    return 'keyword_for';
}
<>{keyword_if} {
    // this.jjval = String(this.jjtext);
    return 'keyword_if';
}
<>{keyword_import} {
    // this.jjval = String(this.jjtext);
    return 'keyword_import';
}
<>{keyword_instanceof} {
    // this.jjval = String(this.jjtext);
    return 'keyword_instanceof';
}
<>{keyword_int} {
    // this.jjval = String(this.jjtext);
    return 'keyword_int';
}
<>{keyword_long} {
    // this.jjval = String(this.jjtext);
    return 'keyword_long';
}
<>{keyword_new} {
    // this.jjval = String(this.jjtext);
    return 'keyword_new';
}
<>{keyword_return} {
    // this.jjval = String(this.jjtext);
    return 'keyword_return';
}
<>{keyword_short} {
    // this.jjval = String(this.jjtext);
    return 'keyword_short';
}
<>{keyword_static} {
    // this.jjval = String(this.jjtext);
    return 'keyword_static';
}
<>{keyword_super} {
    // this.jjval = String(this.jjtext);
    return 'keyword_super';
}
<>{keyword_switch} {
    // this.jjval = String(this.jjtext);
    return 'keyword_switch';
}
<>{keyword_this} {
    // this.jjval = String(this.jjtext);
    return 'keyword_this';
}
<>{keyword_void} {
    // this.jjval = String(this.jjtext);
    return 'keyword_void';
}
<>{keyword_while} {
    // this.jjval = String(this.jjtext);
    return 'keyword_while';
}

<>{digits}*\.{digits}+    {
    this.jjval = parseFloat(this.jjtext);
    return 'float';
}
 
<>{digits}+   {
    this.jjval = parseInt(this.jjtext);
    return 'integer';
}
 
<>print {
  return 'print';
}
 
<>\w+ { return 'id'; }
 
<>\s* { }
 
<>.   { return this.jjtext; }
 
<>$   { console.log('EOF'); return 'EOF'; }