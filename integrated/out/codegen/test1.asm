global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
		_22	DD 1.020
		_79 DD 0.0
		_123 DD 2.0
		_174 DD 5.012
		_181 DD 12
		_184 DD 4
		_197	DD 1.0
	_int db "%i", 0x0a, 0x00
	_float db "%f", 0xA, 0
	__dummy_float dq 0.0
	_float_in db "%lf", 0
	_int_in db "%i", 0


section .text

func_dummy_dummy:
	push ebp
	mov ebp, esp
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 5
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
	mov dword esp, ebp
	pop ebp
	ret
func_test_test2:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	fild dword [ebp - -8]
	fstp dword [ebp - 4]
	fld dword [_22]
	fld dword [ebp -4]
	fadd st0, st1
	fstp dword [ebp - 8]
	fstp st0
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+8]
	mov dword [ebp - 12], eax
	fild dword [ebp - 12]
	fstp dword [ebp - 20]
	fld dword [ebp -20]
	fld dword [ebp -8]
	fadd st0, st1
	fstp dword [ebp - 16]
	fstp st0
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 12], eax
	fld dword [ebp - 16]
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
func_test_test_func:
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
	push 40
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 40
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	mov dword eax, [ ebp - 8]
	mov dword ebx, 0
	mov dword [ ebp - 16], 1
	mov dword ecx, ebx
	add dword ecx, 5
	mov dword eax, [ ebp - 24]
	mov dword [ ebp - 12], ebx
	mov dword eax, [ ebp - 32]
	mov dword edx, [ebp - -12]
	push edx
	push eax
	mov dword [ ebp - -12], edx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 28], ebx
	call func_test_test2
	add esp, 2* 4
	mov dword eax, [ ebp - 40]
	add dword eax, [ ebp - 44]
	mov dword ecx, [ebp - -12]
	mov ebx, [ecx+16]
	mov dword [ ebp - 52], 0
	mov dword edx, 1
	cmp dword edx, 0
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 48], ebx
	mov dword [ ebp - 56], edx
	jge label_74
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_74:
	cmp dword [ ebp - 56], 2
	jl label_76
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_76:
	mov dword eax, [ebp - 52]
	add dword eax, [ ebp - 56]
	imul dword eax, eax, 5
	add dword eax, 4
	fld dword [_79]
	fistp dword [ebp - 60]
	mov dword ebx, [ebp - 60]
	mov dword ecx, [ebp - 48]
	mov dword [ecx + eax * 4], ebx
	mov dword [ ebp - 64], 0
	mov dword [ ebp - 48], ecx
	mov dword [ ebp - 52], eax
	mov dword [ ebp - 60], ebx

label_84:
	mov dword eax, 5
	cmp dword eax, 0
	mov dword [ ebp - 64], eax
	je label_113
	mov dword [ ebp - 68], 0

label_88:
	mov dword eax, 5
	cmp dword eax, 0
	mov dword [ ebp - 68], eax
	je label_111
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 12], eax
	add dword eax, 1
	mov dword ecx, [ebp - -12]
	mov ebx, [ecx+16]
	mov dword [ ebp - 80], 0
	cmp dword [ ebp - 64], 0
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - 72], eax
	mov dword [ ebp - 76], ebx
	jge label_98
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_98:
	cmp dword [ ebp - 64], 2
	jl label_100
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_100:
	mov dword eax, [ebp - 80]
	add dword eax, [ ebp - 64]
	cmp dword [ ebp - 68], 0
	mov dword [ ebp - 80], eax
	jge label_103
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_103:
	cmp dword [ ebp - 68], 5
	jl label_105
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_105:
	mov dword eax, [ebp - 80]
	imul dword eax, eax, 5
	mov dword ebx, [ ebp - 68]
	add dword eax, ebx
	mov dword ecx, [ebp - 72]
	mov dword edx, [ebp - 76]
	mov dword [edx + eax * 4], ecx
	mov dword [ ebp - 68], ebx
	mov dword [ ebp - 72], ecx
	mov dword [ ebp - 76], edx
	mov dword [ ebp - 80], eax
	mov dword eax, 1
	mov dword esp, ebp
	pop ebp
	ret
inc dword [ ebp - 68]
jmp label_88

label_111:
	inc dword [ ebp - 64]
	jmp label_84

label_113:
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
func_test_dummy:
	push ebp
	mov ebp, esp
	mov dword eax, [ebp - -8]
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
	fld dword [_123]
	fistp dword [ebp - 8]
	mov dword eax, [ ebp - 8]
	mov [ebp - 4], eax
	push 24
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword ebx, [ebp - 16]
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 16], ebx
	call func_test_test
	add esp, 1* 4
	mov dword eax, [ebp - 12]
	push eax
	mov dword [ ebp - 12], eax
	call func_test_dummy
	add esp, 1* 4
	mov dword eax, [ebp - 32]
	push eax
	mov dword [ ebp - 32], eax
	call func_test_dummy
	add esp, 1* 4
	mov dword eax, [ebp - 12]
	push eax
	mov dword [ ebp - 12], eax
	call func_test_dummy
	add esp, 1* 4
	mov dword eax, [ebp - 32]
	push eax
	mov dword [ ebp - 32], eax
	call func_test_dummy
	add esp, 1* 4
	mov dword eax, [ebp - 36]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 36], eax
	call func_test_test2
	add esp, 2* 4
	fild dword [ebp - 40]
	fstp dword [ebp - 44]
	fld dword [ebp -44]
	fstp dword [ebp - 20]
	push 0
	call malloc
	add esp, 4
	mov [ebp -52], eax
	mov dword eax, [ebp - 52]
	push eax
	mov dword [ ebp - 52], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ebp - 48]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 48], eax
	call func_IO_print_int
	add esp, 2* 4
	fild dword [ebp - 4]
	fstp dword [ebp - 56]
	fld dword [ebp -56]
	fstp dword [ebp - 20]
	mov dword esp, ebp
	pop ebp
	ret
func_test_test:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 40
	call malloc
	add esp, 4
	push eax
	push 8
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 8
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+4]
	mov dword [ebx+4], 10
	mov ecx, [ebx+8]
	mov edx, [ebx+12]
	fld dword [_174]
	fistp dword [ebp - 16]
	mov dword [ebx+12], esi
	mov edi, [ebx+16]
	mov dword [ ebp - 4], eax
	mov eax, [ebx+20]
	fild dword [_181]
	fstp dword [ebp - 28]
	fld dword [ebp -28]
	fstp dword [eax + 0 * 4]
	fild dword [_184]
	fstp dword [ebp - 32]
	fld dword [ebp -32]
	fstp dword [eax + 1 * 4]
	mov dword [ ebp - 24], eax
	mov eax, [ebx+4]
	mov dword [ebx+8], eax
	mov dword [ ebp - 36], eax
	mov eax, [ebx+20]
	mov dword [ ebp - 44], eax
	mov dword eax, 0
	add dword eax, 1
	imul dword eax, eax, 1
	add dword eax, 0
	fld dword [_197]
	mov dword [ ebp - -8], ebx
	mov dword ebx, [ebp - 44]
	fstp dword [ebx + eax * 4]
	mov dword [ ebp - 8], ecx
	mov dword [ ebp - 12], edx
	mov dword [ ebp - 16], esi
	mov dword [ ebp - 20], edi
	mov dword [ ebp - 44], ebx
	mov dword [ ebp - 48], eax
	mov dword esp, ebp
	pop ebp
	ret

func_IO_IO:
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
