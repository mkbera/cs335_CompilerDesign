// myparser.js
var fs = require("fs");
var jison = require("./index");

var bnf = fs.readFileSync("grammar.jison", "utf8");
var parser = new jison.parser(bnf);

module.exports = parser;