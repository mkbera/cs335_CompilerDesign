global.tac;

function getLabels() {
	var labels = [];

	tac.forEach(function (instr) {
		if (instr[1] == "if" || instr[1] == "jump") {
			labels.push(parseInt(instr[instr.length - 1]));
		}
	});

	labels = labels.unique();
	labels.sort(function (a, b) { return a - b });

	return labels;
}


function getVariables() {
	var variables = [];

	tac.forEach(function (instr) {
		if (math_ops.indexOf(instr[1]) > -1 && keywords.indexOf(instr[2]) == -1) {
			variables.push(instr[2]);
		}
	});

	return variables.unique();
}


function getArrays() {
	var arrays = {};

	tac.forEach(function (instr) {
		if (instr[1] == "array") {
			arrays[instr[2]] = instr[3];
		}
	});

	return arrays;
}


function getBasicBlocks() {
	var splits = [];

	tac.forEach(function (instr, index) {
		switch (instr[1]) {
			case "if": {
				splits.push(parseInt(index + 1))
				splits.push(instr[instr.length - 1] - 1)
				break;
			}
			case "jump": {
				splits.push(index + 1)
				splits.push(instr[instr.length - 1] - 1)
				break;
			}
			case "function": {
				splits.push(index);
				break;
			}
		}
	});

	splits = splits.unique();
	splits.sort(function (a, b) { return a - b });
	splits.push(-1);

	var basic_blocks = [[]];
	var curr = 0;
	tac.forEach(function (instr, index) {
		if (splits[curr] == index) {
			basic_blocks.push([]);
			curr += 1;
		}
		basic_blocks[basic_blocks.length - 1].push(instr);
	});

	return basic_blocks;
}


function getNextUseTable(basic_blocks, variables) {
	var next_use_table = new Array(tac.length).fill(null);;

	var variable_status = {};

	basic_blocks.forEach(function (block) {
		variables.forEach(function (variable) { variable_status[variable] = ["dead", Infinity]; });
		for (var i = block.length - 1; i >= 0; i--) {
			var curr_variable_status = {};
			variables.forEach(function (variable) { curr_variable_status[variable] = variable_status[variable]; });

			var instr = block[i];

			next_use_table[parseInt(instr[0]) - 1] = curr_variable_status;

			if (math_ops_binary.indexOf(instr[1]) > -1 || math_ops_involved.indexOf(instr[1]) > -1) {
				var dt = instr[2];
				var s1 = instr[3];
				var s2 = instr[4];

				variable_status[dt] = ["dead", Infinity];

				variable_status[s1] = ["live", parseInt(instr[0])];
				if (variables.indexOf(s2) > -1) {
					variable_status[s2] = ["live", parseInt(instr[0])];
				}
			}
			else if (math_ops_unary.indexOf(instr[1]) > -1) {
				var v1 = instr[2];

				if (variables.indexOf(v1) > -1) {
					variable_status[v1] = ["live", parseInt(instr[0])];
				}
				break;
			}
			switch (instr[1]) {
				case "if": {
					var c1 = instr[3];
					var c2 = instr[4];

					variable_status[c1] = ["live", parseInt(instr[0])];

					if (variables.indexOf(c2) > -1) {
						variable_status[c2] = ["live", parseInt(instr[0])];
					}
					break;
				}
				case "print": {
					var v1 = instr[2];

					if (variables.indexOf(v1) > -1) {
						variable_status[v1] = ["live", parseInt(instr[0])];
					}
					break;
				}
				case "=": {
					var v1 = instr[2];
					var v2 = instr[3];

					variable_status[v1] = ["dead", Infinity];

					if (variables.indexOf(v2) > -1) {
						variable_status[v2] = ["live", parseInt(instr[0])];
					}
					break;
				}
				case "arr=": {
					var index = instr[3];
					var value = instr[4];

					if (variables.indexOf(index) > -1) {
						variable_status[index] = ["live", parseInt(instr[0])];
					}
					if (variables.indexOf(value) > -1) {
						variable_status[value] = ["live", parseInt(instr[0])];
					}
				}
				case "=arr": {
					var destn = instr[2];
					var value = instr[4];

					variable_status[destn] = ["live", parseInt(instr[0])];

					if (variables.indexOf(value) > -1) {
						variable_status[value] = ["live", parseInt(instr[0])];
					}
				}
			}
		}
	});

	console.log(next_use_table);

	return next_use_table;
}


module.exports = {
	getArrays: getArrays,
	getVariables: getVariables,
	getLabels: getLabels,
	getBasicBlocks: getBasicBlocks,
	getNextUseTable: getNextUseTable
}