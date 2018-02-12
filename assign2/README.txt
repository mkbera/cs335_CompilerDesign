GROUP 24:
    -   Manish Kumar Bera
    -   Gurpreet Singh
    -   Prann Bansal

In this assignment, we provide the source for the code generation part of the
compiler, for conversion from the 3AC (IR) to Assembly Code.


------------------------------------- 3AC --------------------------------------

All the operations and keywords allowed in our 3AC are described in
"/src/descriptor.js".

** Note ** We are note checking for any errors in the 3AC and assume that the
IR generation will handle the correctness of the 3AC.

Each instruction will start with a line number and will have the elements
separated by a tab as shown below: "line_num	op  X	Y	Z"

This convention is strict, and any error in following might lead to wrong
assembly code.

Along with that these are the conventions we made for our 3AC:
-	For X = Y op Z, Y can't take a constant value.
-	array elements can't participate directly in an operation, they will have to
    be loaded in a temporary variable i.e. either "arr[i] = x" or "x = arr[i]"



------------------------------------ SOURCE ------------------------------------

The main file is "index.js" which is used to generate the assembly code from IR.

The descriptions of other source files are given below:

** assembly.js ** Contains the assembly class with constructs to add individual
assembly code instructions to assembly object and also to indent them.

** components.js ** Contains the classes for variables, functions and arrays
declared in the 3AC.

** descriptor.js ** Descibes the keywords and the operations that our 3AC
implements.

** registers.js ** Contains the list of registers to be used and the class
Registers with methods to get registers and unload registers and variables.

** symbol-table.js ** Contains the class SymbolTable and the methods to insert
variables, functions and arrays in the SymbolTable.

** tac.js ** Defines the functions to generate the list of variables, functions,
arrays, nextUseTable and basic blocks from the 3AC.

** translate.js ** Translates the 3AC to assembly code.



------------------------------- RUNNING THE CODE -------------------------------

In order to run the code, first you need to generate the proper binaries using
make. Change the directory to asgn2/ and call make

    make

In order to translate from an test IR file, execute the following command to run
the code:

    bin/codegen test/test.ir [output-file (optional)]
