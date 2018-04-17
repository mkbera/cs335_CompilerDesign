# node ../src/index.js $1.ir $1.asm
nasm -f elf32 $1.asm -o t.o; gcc -m32 t.o -o t; ./t; rm t.o t;
