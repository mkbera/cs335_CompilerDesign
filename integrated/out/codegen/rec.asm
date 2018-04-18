global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
		_58 DD 9
	_int db "%i", 0x0a, 0x00
	_float db "%f", 0xA, 0
	__dummy_float dq 0.0
	_float_in db "%lf", 0
	_int_in db "%i", 0


section .text

func_rec_array_func:
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
	mov dword [ ebp - 4], 0

label_10:
	mov dword [ ebp - 8], 1
	cmp dword [ ebp - 4], 5
	jl label_14
	mov dword [ ebp - 8], 0

label_14:
	cmp dword [ ebp - 8], 0
	je label_52
	mov dword [ ebp - 12], 0

label_17:
	mov dword [ ebp - 16], 1
	cmp dword [ ebp - 12], 5
	jl label_21
	mov dword [ ebp - 16], 0

label_21:
	cmp dword [ ebp - 16], 0
	je label_48
	fild dword [ebp - 4]
	fstp dword [ebp - 24]
	fld dword [ebp -24]
	fld dword [ebp --8]
	fadd st0, st1
	fstp dword [ebp - 20]
	fstp st0
	fild dword [ebp - 12]
	fstp dword [ebp - 32]
	fld dword [ebp -32]
	fld dword [ebp -20]
	fadd st0, st1
	fstp dword [ebp - 28]
	fstp st0
	mov dword [ ebp - 36], 0
	cmp dword [ ebp - 4], 0
	jge label_34
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_34:
	cmp dword [ ebp - 4], 5
	jl label_36
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_36:
	mov dword eax, [ebp - 36]
	add dword eax, [ ebp - 4]
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - 36], eax
	jge label_39
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_39:
	cmp dword [ ebp - 12], 5
	jl label_41
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_41:
	mov dword eax, [ebp - 36]
	imul dword eax, eax, 5
	mov dword ebx, [ ebp - 12]
	add dword eax, ebx
	fld dword [ebp -28]
	mov dword ecx, [ebp - -12]
	fstp dword [ecx + eax * 4]
	mov dword edx, ebx
	add dword ebx, 1
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 36], eax
	mov dword [ ebp - 40], edx
	jmp label_17

label_48:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 44], eax
	add dword eax, 1
	mov dword [ ebp - 4], eax
	jmp label_10

label_52:
	mov dword eax, [ebp - -12]
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
	push 100
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 100
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
	fild dword [_58]
	fstp dword [ebp - 12]
	fld dword [ebp -12]
	fstp dword [ebp - 8]
	push 4
	call malloc
	add esp, 4
	mov [ebp -20], eax
	mov dword eax, [ebp - 20]
	push eax
	mov dword [ ebp - 20], eax
	call func_rec_rec
	add esp, 1* 4
	mov dword eax, [ebp - 16]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	mov dword ecx, [ebp - 8]
	push ecx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 8], ecx
	mov dword [ ebp - 16], eax
	call func_rec_array_func
	add esp, 3* 4
	push 0
	call malloc
	add esp, 4
	mov [ebp -32], eax
	mov dword eax, [ebp - 32]
	push eax
	mov dword [ ebp - 32], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ebp - 28]
	push eax
	mov dword ebx, [ebp - 8]
	push ebx
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 28], eax
	call func_IO_print_float
	add esp, 2* 4
	mov dword [ ebp - 36], 0

label_84:
	mov dword [ ebp - 40], 1
	cmp dword [ ebp - 36], 5
	jl label_88
	mov dword [ ebp - 40], 0

label_88:
	cmp dword [ ebp - 40], 0
	je label_123
	mov dword [ ebp - 44], 0

label_91:
	mov dword [ ebp - 48], 1
	cmp dword [ ebp - 44], 5
	jl label_95
	mov dword [ ebp - 48], 0

label_95:
	cmp dword [ ebp - 48], 0
	je label_119
	mov dword [ ebp - 52], 0
	cmp dword [ ebp - 36], 0
	jge label_100
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_100:
	cmp dword [ ebp - 36], 5
	jl label_102
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_102:
	mov dword eax, [ebp - 52]
	add dword eax, [ ebp - 36]
	cmp dword [ ebp - 44], 0
	mov dword [ ebp - 52], eax
	jge label_105
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_105:
	cmp dword [ ebp - 44], 5
	jl label_107
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_107:
	mov dword eax, [ebp - 52]
	imul dword eax, eax, 5
	add dword eax, [ ebp - 44]
	mov dword ebx, [ebp - 4]
	fld dword [ebx + eax * 4]
	fstp dword [ebp - 56]
	fld dword [ebp -56]
	fstp dword [ebp - 8]
	mov dword ecx, [ebp - 28]
	push ecx
	mov dword edx, [ebp - 8]
	push edx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 8], edx
	mov dword [ ebp - 28], ecx
	mov dword [ ebp - 52], eax
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 44]
	mov dword [ ebp - 60], eax
	add dword eax, 1
	mov dword [ ebp - 44], eax
	jmp label_91

label_119:
	mov dword eax, [ebp - 36]
	mov dword [ ebp - 64], eax
	add dword eax, 1
	mov dword [ ebp - 36], eax
	jmp label_84

label_123:
	mov dword esp, ebp
	pop ebp
	ret
func_rec_rec:
	push ebp
	mov ebp, esp
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 9
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
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
