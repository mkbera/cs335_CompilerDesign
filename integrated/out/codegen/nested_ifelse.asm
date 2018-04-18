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
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword eax, 1
	mov dword ebx, 2
	mov dword [ ebp - 12], 3
	mov dword [ ebp - 16], 4
	mov dword [ ebp - 20], 5
	mov dword [ ebp - 24], 6
	mov dword [ ebp - 28], 1
	cmp dword eax, ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 8], ebx
	jg label_20
	mov dword [ ebp - 28], 0

label_20:
	cmp dword [ ebp - 28], 1
	je label_32
	mov dword [ ebp - 32], 1
	mov dword eax, [ebp - 4]
	cmp dword eax, [ ebp - 8]
	mov dword [ ebp - 4], eax
	jl label_25
	mov dword [ ebp - 32], 0

label_25:
	cmp dword [ ebp - 32], 1
	je label_28
	mov dword esp, ebp
	pop ebp
	ret
jmp label_31

label_28:
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	imul dword eax, eax, 2
	mov dword [ ebp - 36], eax
	mov dword [ ebp - 4], eax

label_31:
	jmp label_88

label_32:
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	add dword eax, 1
	mov dword [ ebp - 40], eax
	mov dword [ ebp - 44], 1
	cmp dword [ ebp - 12], eax
	mov dword [ ebp - 4], eax
	jg label_39
	mov dword [ ebp - 44], 0

label_39:
	cmp dword [ ebp - 44], 1
	je label_85
	mov dword [ ebp - 48], 1
	mov dword eax, [ebp - 12]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 12], eax
	jl label_44
	mov dword [ ebp - 48], 0

label_44:
	cmp dword [ ebp - 48], 1
	je label_49
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 4], eax
	imul dword eax, eax, 2
	mov dword [ ebp - 52], eax
	mov dword [ ebp - 12], eax
	jmp label_84

label_49:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 4], eax
	add dword eax, 1
	mov dword [ ebp - 56], eax
	mov dword [ ebp - 60], 1
	cmp dword eax, [ ebp - 16]
	mov dword [ ebp - 12], eax
	je label_56
	mov dword [ ebp - 60], 0

label_56:
	mov dword [ ebp - 64], 1
	mov dword eax, [ebp - 20]
	cmp dword eax, [ ebp - 24]
	mov dword [ ebp - 20], eax
	jne label_60
	mov dword [ ebp - 64], 0

label_60:
	cmp dword [ ebp - 68], 1
	je label_64
	jmp label_68

label_64:
	cmp dword [ ebp - 4], 1
	je label_67
	mov dword eax, [ ebp - 24]
	mov dword [ ebp - 4], eax
	jmp label_68

label_67:
	mov dword eax, [ ebp - 20]
	mov dword [ ebp - 4], eax

label_68:
	mov dword [ ebp - 72], 1
	mov dword eax, [ebp - 12]
	cmp dword eax, [ ebp - 16]
	mov dword [ ebp - 12], eax
	jne label_72
	mov dword [ ebp - 72], 0

label_72:
	mov dword [ ebp - 76], 1
	mov dword eax, [ebp - 20]
	cmp dword eax, [ ebp - 24]
	mov dword [ ebp - 20], eax
	jg label_76
	mov dword [ ebp - 76], 0

label_76:
	cmp dword [ ebp - 80], 1
	je label_80
	jmp label_84

label_80:
	cmp dword [ ebp - 4], 1
	je label_83
	mov dword eax, [ ebp - 24]
	mov dword [ ebp - 4], eax
	jmp label_84

label_83:
	mov dword eax, [ ebp - 20]
	mov dword [ ebp - 4], eax

label_84:
	jmp label_88

label_85:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 4], eax
	sub dword eax, 1
	mov dword [ ebp - 84], eax
	mov dword [ ebp - 12], eax

label_88:
	mov dword esp, ebp
	pop ebp
	ret
func_nested_ifelse_nested_ifelse:
	push ebp
	mov ebp, esp
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
