var parser = require('parser').parser;

var fs = require("fs");


function print_rules(parse_tree) {
	var tree = JSON.parse(JSON.stringify(parse_tree));

	var output = "";

	var rules = "\n\n\t<ol>\n\n\t\t<h2>Derivations</h2>"

	var nt = true, nt_index;
	while (nt) {
		nt = false;
		nt_index = -1;

		var s = "";

		for (var index = tree.length - 1; index >= 0; index--) {
			token = tree[index];

			if ("t" in token) {
				s = "\t\t\t<span>" + token.t + "</span>\n" + s;
			}
			else if ("nt" in token) {
				if (!nt) {
					s = "\t\t\t<span class='nt current'>" + token.nt + "</span>\n" + s;
					nt = true;
					nt_index = index;
				}
				else {
					s = "\t\t\t<span class='nt'>" + token.nt + "</span>\n" + s;
				}
			}
			else {
				throw Error("Undefined sequence returned");
			}
		}

		if (nt) {
			var children = tree[nt_index].children;
			children.reverse().forEach(function (child) {
				tree.splice(nt_index, 0, child);
			});
			tree.splice(nt_index + children.length, 1);
		}

		rules += "\n\t\t<li class='rule'>\n" + s + "\t\t</li>";
	}

	rules += "\n\t</ol>";
	output += rules;
	output += "\n\n\t<pre class='output'>\n";

	tree.forEach(function (token) {
		output += token.l + " ";
	});

	output += "\n\t</pre>";

	return output;
}


var input_file = "in.java";
if (process.argv.length >= 3) {
	input_file = process.argv[2];
}
input = fs.readFileSync(input_file).toString();
console.log("Reading Input from file: " + input_file);

parse_tree = parser.parse(input);

rules = print_rules([parse_tree]);

html_head = fs.readFileSync("src/includes/html-head.html")
html_tail = fs.readFileSync("src/includes/html-tail.html")

html_input = "\n\n\t<pre class='input'>\n" + input + "\n</pre>";

html = html_head + html_input + rules + "\n\n" + html_tail

var out_file = "out.html";
if (process.argv.length >= 4) {
	out_file = process.argv[3];
}
fs.writeFile(out_file, html, function (err) {
	if (err) {
		return console.log(err);
	}

	console.log("The grammar was generated and saved to " + out_file);
});
