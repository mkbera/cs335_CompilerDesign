node assign4/src/index.js $1 test.ir

node classes_project/src/index.js test.ir test.asm

nasm -f elf32 test.asm -o t.o
gcc -m32 t.o -o t

./t
rm t.o
rm t
# rm test.ir
# rm test.asm