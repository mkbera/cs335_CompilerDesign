global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
	_int db "%i", 0x0a, 0x00
	_float db "%f", 0xA, 0
	__dummy_float dq 0.0
	_float_in db "%lf", 0
	_int_in db "%i", 0
	_char db "%c", 10, 0


section .text

func_Life_show:
	push ebp
	mov ebp, esp
	sub esp, 4
	mov dword [ ebp - 4], 10
	mov dword esp, ebp
	pop ebp
	ret
func_Life_gen:
	push ebp
	mov ebp, esp
	push 400
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 8], 0

label_14:
	mov dword [ ebp - 12], 1
	cmp dword [ ebp - 8], 10
	jl label_18
	mov dword [ ebp - 12], 0

label_18:
	cmp dword [ ebp - 12], 0
	je label_54
	mov dword [ ebp - 16], 0

label_21:
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 16], 10
	jl label_25
	mov dword [ ebp - 20], 0

label_25:
	cmp dword [ ebp - 20], 0
	je label_50
	mov dword [ ebp - 24], 1
	cmp dword [ ebp - 16], 0.7
	jg label_30
	mov dword [ ebp - 24], 0

label_30:
	cmp dword [ ebp - 24], 1
	je label_32
	jmp label_46

label_32:
	mov dword [ ebp - 28], 0
	cmp dword [ ebp - 8], 0
	jge label_36
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_36:
	cmp dword [ ebp - 8], 10
	jl label_38
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_38:
	mov dword eax, [ebp - 28]
	add dword eax, [ ebp - 8]
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - 28], eax
	jge label_41
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_41:
	cmp dword [ ebp - 16], 10
	jl label_43
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_43:
	mov dword eax, [ebp - 28]
	imul dword eax, eax, 10
	add dword eax, [ ebp - 16]
	mov dword ebx, [ebp - 4]
	mov dword [ebx + eax * 4], 1
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 28], eax

label_46:
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 32], eax
	add dword eax, 1
	mov dword [ ebp - 16], eax
	jmp label_21

label_50:
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 36], eax
	add dword eax, 1
	mov dword [ ebp - 8], eax
	jmp label_14

label_54:
	mov dword eax, [ebp - 4]
	mov dword esp, ebp
	pop ebp
	ret
push function_return_error_msg
call printf
mov dword eax, 1
int 0x80

mov dword esp, ebp
pop ebp
mov dword eax, 1
int 0x80
func_Life_occupiedNext:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 1
	cmp dword [ ebp - -12], 2
	je label_65
	mov dword [ ebp - 4], 0

label_65:
	mov dword [ ebp - 8], 1
	cmp dword [ ebp - -12], 3
	je label_69
	mov dword [ ebp - 8], 0

label_69:
	cmp dword [ ebp - 16], 1
	je label_88
	mov dword eax, [ ebp - -8]
	not dword eax
	mov dword [ ebp - 24], 1
	cmp dword [ ebp - -12], 3
	mov dword [ ebp - 20], eax
	je label_81
	mov dword [ ebp - 24], 0

label_81:
	cmp dword [ ebp - 28], 1
	je label_86
	mov dword eax, 0
	mov dword esp, ebp
	pop ebp
	ret
jmp label_87

label_86:
	mov dword eax, 1
	mov dword esp, ebp
	pop ebp
	ret

label_87:
	jmp label_89

label_88:
	mov dword eax, 1
	mov dword esp, ebp
	pop ebp
	ret

label_89:
	push function_return_error_msg
	call printf
	mov dword eax, 1
	int 0x80

mov dword esp, ebp
pop ebp
mov dword eax, 1
int 0x80
func_Life_inbounds:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 1
	cmp dword [ ebp - -12], 0
	jge label_100
	mov dword [ ebp - 4], 0

label_100:
	mov dword ebx, [ebp - -20]
	mov eax, [ebx+0]
	mov dword [ ebp - 12], 1
	cmp dword [ ebp - -12], eax
	mov dword [ ebp - -20], ebx
	mov dword [ ebp - 8], eax
	jl label_106
	mov dword [ ebp - 12], 0

label_106:
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - -8], 0
	jge label_112
	mov dword [ ebp - 20], 0

label_112:
	mov dword ebx, [ebp - -20]
	mov eax, [ebx+0]
	mov dword [ ebp - 32], 1
	cmp dword [ ebp - -8], eax
	mov dword [ ebp - -20], ebx
	mov dword [ ebp - 28], eax
	jl label_120
	mov dword [ ebp - 32], 0

label_120:
	mov dword eax, [ebp - 36]
	mov dword esp, ebp
	pop ebp
	ret
push function_return_error_msg
call printf
mov dword eax, 1
int 0x80

mov dword esp, ebp
pop ebp
mov dword eax, 1
int 0x80
func_Life_numNeighbors:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 5
	mov dword eax, [ebp - -12]
	mov dword [ ebp - -12], eax
	sub dword eax, 1
	mov dword [ ebp - 12], eax
	mov dword [ ebp - 8], eax

label_136:
	mov dword eax, [ebp - -12]
	mov dword [ ebp - -12], eax
	add dword eax, 1
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 8], eax
	mov dword [ ebp - 16], eax
	jle label_142
	mov dword [ ebp - 20], 0

label_142:
	cmp dword [ ebp - 20], 0
	je label_173
	mov dword eax, [ebp - -8]
	mov dword [ ebp - -8], eax
	sub dword eax, 1
	mov dword [ ebp - 28], eax
	mov dword [ ebp - 24], eax

label_147:
	mov dword eax, [ebp - -8]
	mov dword [ ebp - -8], eax
	add dword eax, 1
	mov dword [ ebp - 36], 1
	cmp dword [ ebp - 24], eax
	mov dword [ ebp - 32], eax
	jle label_153
	mov dword [ ebp - 36], 0

label_153:
	cmp dword [ ebp - 36], 0
	je label_169
	mov dword eax, [ebp - -20]
	push eax
	mov dword ebx, [ebp - -16]
	push ebx
	mov dword ecx, [ebp - 8]
	push ecx
	mov dword edx, [ebp - 24]
	push edx
	mov dword [ ebp - -20], eax
	mov dword [ ebp - -16], ebx
	mov dword [ ebp - 8], ecx
	mov dword [ ebp - 24], edx
	call func_Life_inbounds
	add esp, 4* 4
	; TEST
	mov dword [ebp - 40], eax
	cmp dword [ ebp - 40], 1
	je label_162
	jmp label_165

label_162:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 44], eax
	add dword eax, 1
	mov dword [ ebp - 4], eax

label_165:
	mov dword eax, [ebp - 24]
	mov dword [ ebp - 48], eax
	add dword eax, 1
	mov dword [ ebp - 24], eax
	jmp label_147

label_169:
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 52], eax
	add dword eax, 1
	mov dword [ ebp - 8], eax
	jmp label_136

label_173:
	mov dword eax, [ebp - 4]
	mov dword esp, ebp
	pop ebp
	ret
push function_return_error_msg
call printf
mov dword eax, 1
int 0x80

mov dword esp, ebp
pop ebp
mov dword eax, 1
int 0x80
func_Life_nextGen:
	push ebp
	mov ebp, esp
	push 400
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 12], 0

label_183:
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 12], eax
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 16], eax
	jl label_189
	mov dword [ ebp - 20], 0

label_189:
	cmp dword [ ebp - 20], 0
	je label_250
	mov dword [ ebp - 24], 0

label_192:
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov dword [ ebp - 32], 1
	cmp dword [ ebp - 24], eax
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 28], eax
	jl label_198
	mov dword [ ebp - 32], 0

label_198:
	cmp dword [ ebp - 32], 0
	je label_246
	mov dword eax, [ebp - -12]
	push eax
	mov dword ebx, [ebp - -8]
	push ebx
	mov dword ecx, [ebp - 12]
	push ecx
	mov dword edx, [ebp - 24]
	push edx
	mov dword [ ebp - -12], eax
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 12], ecx
	mov dword [ ebp - 24], edx
	call func_Life_numNeighbors
	add esp, 4* 4
	; TEST
	mov dword [ebp - 36], eax
	mov dword eax, [ ebp - 36]
	mov dword [ ebp - 40], 0
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - 8], eax
	jge label_210
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_210:
	cmp dword [ ebp - 12], 10
	jl label_212
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_212:
	mov dword eax, [ebp - 40]
	add dword eax, [ ebp - 12]
	cmp dword [ ebp - 24], 0
	mov dword [ ebp - 40], eax
	jge label_215
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_215:
	cmp dword [ ebp - 24], 10
	jl label_217
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_217:
	mov dword eax, [ebp - 40]
	imul dword eax, eax, 10
	add dword eax, [ ebp - 24]
	mov dword ecx, [ebp - -8]
	mov dword ebx, [ecx + eax * 4]
	mov dword edx, [ebp - -12]
	push edx
	mov dword esi, [ebp - 8]
	push esi
	push ebx
	mov dword [ ebp - -12], edx
	mov dword [ ebp - -8], ecx
	mov dword [ ebp - 8], esi
	mov dword [ ebp - 40], eax
	mov dword [ ebp - 44], ebx
	call func_Life_occupiedNext
	add esp, 3* 4
	; TEST
	mov dword [ebp - 48], eax
	cmp dword [ ebp - 48], 1
	je label_228
	jmp label_242

label_228:
	mov dword [ ebp - 52], 0
	cmp dword [ ebp - 12], 0
	jge label_232
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_232:
	cmp dword [ ebp - 12], 10
	jl label_234
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_234:
	mov dword eax, [ebp - 52]
	add dword eax, [ ebp - 12]
	cmp dword [ ebp - 24], 0
	mov dword [ ebp - 52], eax
	jge label_237
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_237:
	cmp dword [ ebp - 24], 10
	jl label_239
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_239:
	mov dword eax, [ebp - 52]
	imul dword eax, eax, 10
	add dword eax, [ ebp - 24]
	mov dword ebx, [ebp - 4]
	mov dword [ebx + eax * 4], 1
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 52], eax

label_242:
	mov dword eax, [ebp - 24]
	mov dword [ ebp - 56], eax
	add dword eax, 1
	mov dword [ ebp - 24], eax
	jmp label_192

label_246:
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 60], eax
	add dword eax, 1
	mov dword [ ebp - 12], eax
	jmp label_183

label_250:
	mov dword eax, [ebp - 4]
	mov dword esp, ebp
	pop ebp
	ret
push function_return_error_msg
call printf
mov dword eax, 1
int 0x80

mov dword esp, ebp
pop ebp
mov dword eax, 1
int 0x80
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	push 400
	call malloc
	add esp, 4
	push eax
	push 400
	call malloc
	add esp, 4
	push eax
	push 400
	call malloc
	add esp, 4
	push eax
	push 4
	call malloc
	add esp, 4
	mov [ebp -8], eax
	mov dword eax, [ebp - 8]
	push eax
	mov dword [ ebp - 8], eax
	call func_Life_Life
	add esp, 1* 4
	mov dword eax, [ ebp - 8]
	push eax
	mov dword [ ebp - 4], eax
	call func_Life_gen
	add esp, 1* 4
	; TEST
	mov dword [ebp - 16], eax
	mov dword eax, [ ebp - 16]
	mov dword ebx, [ebp - 4]
	push ebx
	push eax
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 12], eax
	call func_Life_show
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	mov dword ebx, [ebp - 12]
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 12], ebx
	call func_Life_nextGen
	add esp, 2* 4
	; TEST
	mov dword [ebp - 20], eax
	mov dword eax, [ ebp - 20]
	mov dword ebx, [ebp - 4]
	push ebx
	push eax
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 12], eax
	call func_Life_show
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_Life_Life:
	push ebp
	mov ebp, esp
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 10
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
	mov dword esp, ebp
	pop ebp
	ret

func_IO_IO:
	ret
func_IO_print_char:
	push ebp
	mov ebp, esp
	mov eax, [ebp+8]
	mov edx, 0
	mov ebx, 128
	div ebx
	push edx
	push _char
	call printf
	mov esp, ebp
	pop ebp
	ret
func_IO_print_int:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	push eax
	push _int
	call printf
	mov esp, ebp
	pop ebp
	ret
func_IO_print_float:
	push ebp
	mov ebp, esp
	fld dword [ebp + 8]
	sub esp, 8
	fstp qword [esp]
	push _float
	call printf
	mov esp, ebp
	pop ebp
	ret
func_IO_scan_char:
func_IO_scan_int:
	push ebp
	mov ebp, esp
	sub esp, 4
	push esp 
	push _int_in
	call scanf
	mov eax, [ebp - 4]
	mov esp, ebp
	pop ebp
	ret
func_IO_scan_float:
	push ebp
	mov ebp, esp
	push __dummy_float
	push _float_in
	call scanf
	fld qword [__dummy_float]
	mov esp, ebp
	pop ebp
	ret
