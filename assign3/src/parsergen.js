class Grammar {
	constructor() {
		this.grammar = "";
	}

	add(s) {
		this.grammar += s + "\n";
	}

	get_rule_string(nt, rule) {
		var s = "";
		rule.forEach(token => {
			if (typeof token === "string") {
				s += "'" + token + "' ";
			}
			else {
				if (token.optional) {
					s += "[" + token.nt + "] ";
				}
				else {
					s += token.nt + " ";
				}
			}
		});
		s += "\n\t\tfunction() { this.push( this, \"" + nt + "\", " + JSON.stringify(rule) + " ) }"

		return s;
	}

	print_to_file(file) {
		var fs = require('fs');

		fs.writeFile(file, this.grammar, function (err) {
			if (err) {
				return console.log(err);
			}

			console.log("The grammar was generated and saved to " + file);
		});
	}
}


function main() {
	var rules = require("./grammar").rules;

	var grammar = new Grammar();

	grammar.add("%moduleName MyParser");
	grammar.add("%mode LR1");
	grammar.add("\n");

	Object.keys(rules).forEach(function (nt) {
		grammar.add(nt + "=");
		for (var i = 0; i < rules[nt].length - 1; i++) {
			grammar.add("\t\t" + grammar.get_rule_string(nt, rules[nt][i]));
			grammar.add("\t|");
		}
		grammar.add("\t\t" + grammar.get_rule_string(nt, rules[nt][rules[nt].length - 1]));
		grammar.add("\t;");
		grammar.add("\n");
	});

	var file = "out";
	if (process.argv.length >= 3) {
		file = process.argv[2];
	}
	grammar.print_to_file(file);
}

main()