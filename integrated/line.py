import sys

fn = sys.argv[1]
with open(fn) as f:
	code = [line.strip() for line in f.readlines()]

for i, line in enumerate(code):
	code[i] = str(i + 1) + "\t" + line

with open(fn, "w") as f:
	f.write("\n".join(code))