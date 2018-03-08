%moduleName MyParser
%mode SLR


code=
		stmt 
		function() { this.push( this, "code", [{"nt":"stmt"}] ) }
	;


stmt=
		id op stmt 
		function() { this.push( this, "stmt", [{"nt":"id"},{"nt":"op"},{"nt":"stmt"}] ) }
	|
		id 
		function() { this.push( this, "stmt", [{"nt":"id"}] ) }
	;


id=
		'identifier' 
		function() { this.push( this, "id", ["identifier"] ) }
	|
		'integer_literal' 
		function() { this.push( this, "id", ["integer_literal"] ) }
	;


op=
		'op_add' 
		function() { this.push( this, "op", ["op_add"] ) }
	|
		'op_sub' 
		function() { this.push( this, "op", ["op_sub"] ) }
	;


