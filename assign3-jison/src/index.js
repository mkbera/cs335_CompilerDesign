var parser = require('parser').parser;

var fs = require("fs");


function print_string(string) {
	var s = ""
	var flag = true;
	for (var i = string.length - 1; i >= 0; i--) {
		token = string[i];
		if (typeof token === "string") {
			s = token + " " + s;
		}
		else {
			if (flag) {
				s = "\x1b[4m" + token.nt + "\x1b[0m " + s;
				flag = false;
			}
			else {
				s = token.nt + " " + s;
			}
		}
	}
	console.log(s);
}


function print_rules(rules) {
	var rule = rules.pop()
	var s = rule.children;
	var nt = 0;

	print_string([{ nt: rule.parent }]);

	while (nt != -1) {
		nt = -1;
		print_string(s);

		for (var i = s.length - 1; i >= 0; i--) {
			token = s[i];
			if (typeof token !== "string") {
				nt = i;
				break;
			}
		}

		rule = rules.pop();

		var ss = [];
		var flag = true;
		s.reverse().forEach(function (token) {
			if (typeof token !== "string" && flag) {
				flag = false;
				if (token.nt == rule.parent) {
					ss = ss.concat(rule.children.reverse());
				}
				else {
					throw Error("Not a valid string");
				}
			}
			else {
				ss.push(token);
			}
		});
		s = ss.reverse();
	}
}

input = fs.readFileSync("in.java").toString();

console.log("Input:\n\t" + input + "\n\n");

var ctx = {
	rules: [],
	push: function (obj, parent, children) {
		obj.rules.push({
			"parent": parent,
			"children": children
		})
	}
}

console.log(parser.parse(input));
// print_rules(ctx.rules);
