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
	mov dword [ ebp - 8], 0

label_7:
	mov dword [ ebp - 12], 1
	cmp dword [ ebp - 8], 10
	jl label_11
	mov dword [ ebp - 12], 0

label_11:
	cmp dword [ ebp - 12], 0
	je label_65
	mov dword [ ebp - 16], 0

label_14:
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 16], 10
	jl label_18
	mov dword [ ebp - 20], 0

label_18:
	cmp dword [ ebp - 20], 0
	je label_61
	mov dword [ ebp - 24], 0

label_21:
	mov dword [ ebp - 28], 1
	mov dword eax, [ ebp - 24]
	cmp dword eax, 10
	mov dword [ ebp - 24], eax
	jl label_25
	mov dword [ ebp - 28], 0

label_25:
	cmp dword [ ebp - 28], 0
	je label_57
	mov dword eax, [ebp - 8]
	mov dword ebx, [ ebp - 16]
	mov dword ecx, eax
	sub dword ecx, ebx
	mov dword esi, [ ebp - 24]
	mov dword edx, esi
	mov dword [ ebp - 32], ecx
	imul dword ecx, edx
	mov dword edi, 0
	cmp dword eax, 0
	mov dword [ ebp - 8], eax
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 24], esi
	mov dword [ ebp - 36], edx
	mov dword [ ebp - 40], ecx
	mov dword [ ebp - 44], edi
	jge label_37
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_37:
	mov dword eax, [ ebp - 8]
	cmp dword eax, 10
	mov dword [ ebp - 8], eax
	jl label_39
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_39:
	mov dword eax, [ebp - 44]
	add dword eax, [ ebp - 8]
	mov dword ebx, [ ebp - 16]
	cmp dword ebx, 0
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 44], eax
	jge label_42
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_42:
	mov dword eax, [ ebp - 16]
	cmp dword eax, 10
	mov dword [ ebp - 16], eax
	jl label_44
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_44:
	mov dword eax, [ebp - 44]
	imul dword eax, eax, 10
	add dword eax, [ ebp - 16]
	mov dword ebx, [ ebp - 24]
	cmp dword ebx, 0
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 44], eax
	jge label_48
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_48:
	mov dword eax, [ ebp - 24]
	cmp dword eax, 10
	mov dword [ ebp - 24], eax
	jl label_50
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_50:
	mov dword eax, [ebp - 44]
	imul dword eax, eax, 10
	mov dword ebx, [ ebp - 24]
	add dword eax, ebx
	mov dword ecx, [ebp - 40]
	mov dword edx, [ebp - 4]
	mov dword [edx + eax * 4], ecx
	mov dword esi, ebx
	add dword ebx, 1
	mov dword [ ebp - 4], edx
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 40], ecx
	mov dword [ ebp - 44], eax
	mov dword [ ebp - 48], esi
	jmp label_21

label_57:
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 16], eax
	add dword eax, 1
	mov dword [ ebp - 52], eax
	mov dword [ ebp - 16], eax
	jmp label_14

label_61:
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	add dword eax, 1
	mov dword [ ebp - 56], eax
	mov dword [ ebp - 8], eax
	jmp label_7

label_65:
	mov dword esp, ebp
	pop ebp
	ret
func_Threed_array_Threed_array:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
main:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret

func_syscall_print_int:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	push eax
	push _int
	call printf
	mov esp, ebp
	pop ebp
	ret
func_syscall_print_float:
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
syscall_scan_int:
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
func_syscall_scan_float:
	push ebp
	mov ebp, esp
	push __dummy_float
	push _float_in
	call scanf
	fld qword [__dummy_float]
	mov esp, ebp
	pop ebp
	ret
