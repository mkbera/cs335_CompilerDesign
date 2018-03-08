#!/bin/bash

node node_modules/jacob/cmd/cmd.js -t tokens.l -l node_modules/lexer/index.js
node node_modules/jacob/cmd/cmd.js -g grammar.y -p node_modules/parser/index.js
