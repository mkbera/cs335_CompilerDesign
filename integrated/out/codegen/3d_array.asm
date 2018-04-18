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


section .text

main:
	push ebp
	mov ebp, esp
	push 4000
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
	mov dword [ ebp - 8], 0

label_7:
	mov dword [ ebp - 12], 1
	cmp dword [ ebp - 8], 10
	jl label_11
	mov dword [ ebp - 12], 0

label_11:
	cmp dword [ ebp - 12], 0
	je label_68
	mov dword [ ebp - 16], 0

label_14:
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 16], 10
	jl label_18
	mov dword [ ebp - 20], 0

label_18:
	cmp dword [ ebp - 20], 0
	je label_64
	mov dword [ ebp - 24], 0

label_21:
	mov dword [ ebp - 28], 1
	cmp dword [ ebp - 24], 10
	jl label_25
	mov dword [ ebp - 28], 0

label_25:
	cmp dword [ ebp - 28], 0
	je label_60
	mov dword eax, [ebp - 8]
	mov dword ebx, eax
	sub dword ebx, [ ebp - 16]
	mov dword ecx, [ ebp - 24]
	mov dword [ ebp - 32], ebx
	imul dword ebx, ecx
	mov dword [ ebp - 44], 0
	cmp dword eax, 0
	mov dword [ ebp - 8], eax
	mov dword [ ebp - 36], ecx
	mov dword [ ebp - 40], ebx
	jge label_37
	push array_access_low_error_msg
	call printf

label_37:
	cmp dword [ ebp - 8], 10
	jl label_39
	push array_access_up_error_msg
	call printf

label_39:
	mov dword eax, [ebp - 44]
	add dword eax, [ ebp - 8]
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - 44], eax
	jge label_42
	push array_access_low_error_msg
	call printf

label_42:
	cmp dword [ ebp - 16], 10
	jl label_44
	push array_access_up_error_msg
	call printf

label_44:
	mov dword eax, [ebp - 44]
	imul dword eax, eax, 10
	add dword eax, [ ebp - 16]
	cmp dword [ ebp - 24], 0
	mov dword [ ebp - 44], eax
	jge label_48
	push array_access_low_error_msg
	call printf

label_48:
	cmp dword [ ebp - 24], 10
	jl label_50
	push array_access_up_error_msg
	call printf

label_50:
	mov dword eax, [ebp - 44]
	imul dword eax, eax, 10
	mov dword ebx, [ ebp - 24]
	add dword eax, ebx
	mov dword edx, [ebp - 4]
	mov dword ecx, [edx + eax * 4]
	add dword ecx, [ ebp - 40]
	mov dword [edx + eax * 4], ecx
	mov dword esi, ebx
	add dword ebx, 1
	mov dword [ ebp - 4], edx
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 44], eax
	mov dword [ ebp - 48], ecx
	mov dword [ ebp - 52], esi
	jmp label_21

label_60:
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 16], eax
	add dword eax, 1
	mov dword [ ebp - 56], eax
	mov dword [ ebp - 16], eax
	jmp label_14

label_64:
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	add dword eax, 1
	mov dword [ ebp - 60], eax
	mov dword [ ebp - 8], eax
	jmp label_7

label_68:
	mov dword esp, ebp
	pop ebp
	ret
func_Threed_array_Threed_array:
	push ebp
	mov ebp, esp
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
