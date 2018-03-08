%moduleName MyParser

%mode SLR

code	=	
				stmt
				function () {
					this.push(
						this, 'code', [{nt: 'stmt'}]
					)
				}
			;

stmt	=
  				id 'op_add' stmt
				function () {
					this.push(
						this, 'stmt', [{nt: 'id'}, 'op_add', {nt: 'stmt'}]
					);
				}
			|
  				id 'op_sub' stmt
				function () {
					this.push(
						this, 'stmt', [{nt: 'id'}, 'op_sub', {nt: 'stmt'}]
					);
				}
			|
				id
				function () {
					this.push(
						this, 'stmt', [{nt: 'id'}]
					);
				}
			;

id		=
				'identifier'
				function() {
					this.push(
						this, 'id', ['identifier']
					)
				}
			|
				'integer_literal'
				function() {
					this.push(
						this, 'id', ['integer_literal']
					)
				}
			;