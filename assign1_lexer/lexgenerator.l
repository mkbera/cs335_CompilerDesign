%moduleName MyLexer
 
%%
 
digits = [0-9]
keyword_bool = boolean  //| "byte" | "case" | "char" | "class" | "const" | "continue" | "default" | "do" | "double" | "else" | "extends" | "float" | "for" | "if" | "import" | "instanceof" | "int" | "long" | "new" | "return" | "short" | "static" | "super" | "switch" | "this" | "void" | "while" 
keyword_brk  = break

%%
<>{keyword_bool} {
    this.jjval = String(this.jjtext);
    return 'keyword';
}

<>{keyword_brk} {
    this.jjval = String(this.jjtext);
    return 'keyword';
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