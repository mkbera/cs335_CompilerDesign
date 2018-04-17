Array.prototype.contains = function (v) {
	for (var i = 0; i < this.length; i += 1) {
		if (this[i] === v) return true;
	}
	return false;
};

Array.prototype.unique = function () {
	var arr = [];
	for (var i = 0; i < this.length; i += 1) {
		if (!arr.includes(this[i])) {
			arr.push(this[i]);
		}
	}
	return arr;
}