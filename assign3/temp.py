import re
import json

with open("temp", "r") as f:
    input = f.read()

input = input.replace("\n\n", "\n").split("\n")

tokens = {}
current_token = None

for line in input:
    if line[0] != '\t':
        current_token = re.sub('([A-Z]{1})', r'_\1', line[:-1]).lower()[1:]
        tokens[current_token] = []
    else:
        tokens[current_token].append(
            [
                {
                    "nt": re.sub('([A-Z]{1})', r'_\1', token).lower()[1:]
                }
                if token[0] != "\"" and token[-4:] != "-opt"
                else
                {
                    "nt": re.sub('([A-Z]{1})', r'_\1', token).lower()[1:-4],
                    "optional": True
                }
                if token[0] != "\"" and token[-4:] == "-opt"
                else
                token[1:-1]
                for token in line[1:].split()
            ]
        )

open("temp2", "w").write(json.dumps(tokens, indent=4)[1:-2] + ",")
