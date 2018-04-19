global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
		_int db "%i", 0
		_float db "%f", 0
		__dummy_float dq 0.0
		_float_in db "%lf", 0
		_int_in db "%i", 0
		_char db "%c", 0
		_char_in db "%c", 0


section .text

	
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
		push ebp
		mov ebp, esp
		sub esp, 4
		push esp
		push _char_in
		call scanf
		mov dword eax, [ebp - 4]
		mov edx, 0
		mov ebx, 128
		div ebx
		mov eax, edx
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
func_MyBinarySearch_binarySearch:
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
	mov dword [ ebp - 4], 0
	mov dword eax, [ebp - -12]
	mov dword [ ebp - -12], eax
	sub dword eax, 1
	mov dword [ ebp - 16], eax
	mov dword [ ebp - 12], eax

label_15:
	mov dword [ ebp - 20], 1
	mov dword eax, [ebp - 4]
	cmp dword eax, [ ebp - 12]
	mov dword [ ebp - 4], eax
	jle label_19
	mov dword [ ebp - 20], 0

label_19:
	cmp dword [ ebp - 20], 0
	je label_63
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 4], eax
	add dword eax, [ ebp - 12]
	mov dword [ebp - 24], eax
	mov dword edx, 0
	mov dword ebx, 2
	cdq
	idiv dword ebx
	mov dword [ ebp - 28], eax
	mov dword [ ebp - 32], 0
	cmp dword eax, 0
	mov dword [ ebp - 8], eax
	jge label_29
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_29:
	cmp dword [ ebp - 8], 8
	jl label_31
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_31:
	mov dword eax, [ebp - 32]
	add dword eax, [ ebp - 8]
	mov dword ecx, [ebp - -16]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 40], 1
	cmp dword [ ebp - -8], ebx
	mov dword [ ebp - -16], ecx
	mov dword [ ebp - 32], eax
	mov dword [ ebp - 36], ebx
	je label_38
	mov dword [ ebp - 40], 0

label_38:
	cmp dword [ ebp - 40], 1
	je label_40
	jmp label_41

label_40:
	mov dword eax, [ebp - 8]
	mov dword esp, ebp
	pop ebp
	ret

label_41:
	mov dword [ ebp - 44], 0
	cmp dword [ ebp - 8], 0
	jge label_45
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_45:
	cmp dword [ ebp - 8], 8
	jl label_47
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_47:
	mov dword eax, [ebp - 44]
	add dword eax, [ ebp - 8]
	mov dword ecx, [ebp - -16]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 52], 1
	cmp dword [ ebp - -8], ebx
	mov dword [ ebp - -16], ecx
	mov dword [ ebp - 44], eax
	mov dword [ ebp - 48], ebx
	jl label_54
	mov dword [ ebp - 52], 0

label_54:
	cmp dword [ ebp - 52], 1
	je label_59
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	add dword eax, 1
	mov dword [ ebp - 56], eax
	mov dword [ ebp - 4], eax
	jmp label_62

label_59:
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	sub dword eax, 1
	mov dword [ ebp - 60], eax
	mov dword [ ebp - 12], eax

label_62:
	jmp label_15

label_63:
	mov dword eax, 1
	neg dword eax
	mov dword [ ebp - 64], eax
	mov dword eax, [ebp - 64]
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
	push 32
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
	push 32
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
	push 0
	call malloc
	add esp, 4
	mov [ebp -8], eax
	mov dword eax, [ebp - 8]
	push eax
	mov dword [ ebp - 8], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ ebp - 8]
	mov [ebp - 4], eax
	push 0
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword eax, [ebp - 16]
	push eax
	mov dword [ ebp - 16], eax
	call func_MyBinarySearch_MyBinarySearch
	add esp, 1* 4
	mov dword eax, [ ebp - 16]
	mov dword ebx, 0
	add dword ebx, 0
	mov dword ecx, [ebp - 20]
	mov dword [ecx + ebx * 4], 2
	mov dword edx, 0
	add dword edx, 1
	mov dword [ecx + edx * 4], 4
	mov dword esi, 0
	add dword esi, 2
	mov dword [ecx + esi * 4], 6
	mov dword edi, 0
	add dword edi, 3
	mov dword [ecx + edi * 4], 8
	mov dword [ ebp - 12], eax
	mov dword eax, 0
	add dword eax, 4
	mov dword [ecx + eax * 4], 10
	mov dword [ ebp - 40], eax
	mov dword eax, 0
	add dword eax, 5
	mov dword [ecx + eax * 4], 12
	mov dword [ ebp - 44], eax
	mov dword eax, 0
	add dword eax, 6
	mov dword [ecx + eax * 4], 14
	mov dword [ ebp - 48], eax
	mov dword eax, 0
	add dword eax, 7
	mov dword [ecx + eax * 4], 16
	mov dword [ ebp - 52], eax
	mov dword eax, [ebp - 12]
	push eax
	push ecx
	;-1
	push 8
	;-1
	push 14
	mov dword [ ebp - 12], eax
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 28], edx
	mov dword [ ebp - 32], esi
	mov dword [ ebp - 36], edi
	call func_MyBinarySearch_binarySearch
	add esp, 2* 4
	; TEST
	mov dword [ebp - 56], eax
	mov dword eax, [ebp - 4]
	push eax
	mov dword ebx, [ebp - 56]
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 56], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, 0
	add dword eax, 0
	mov dword ebx, [ebp - 60]
	mov dword [ebx + eax * 4], 6
	mov dword ecx, 0
	add dword ecx, 1
	mov dword [ebx + ecx * 4], 34
	mov dword edx, 0
	add dword edx, 2
	mov dword [ebx + edx * 4], 78
	mov dword esi, 0
	add dword esi, 3
	mov dword [ebx + esi * 4], 123
	mov dword edi, 0
	add dword edi, 4
	mov dword [ebx + edi * 4], 432
	mov dword [ ebp - 64], eax
	mov dword eax, 0
	add dword eax, 5
	mov dword [ebx + eax * 4], 900
	mov dword [ ebp - 84], eax
	mov dword eax, 0
	add dword eax, 6
	mov dword [ebx + eax * 4], 990
	mov dword [ ebp - 88], eax
	mov dword eax, 0
	add dword eax, 7
	mov dword [ebx + eax * 4], 1000
	mov dword [ ebp - 92], eax
	mov dword eax, [ebp - 12]
	push eax
	push ebx
	;-1
	push 8
	;-1
	push 431
	mov dword [ ebp - 12], eax
	mov dword [ ebp - 60], ebx
	mov dword [ ebp - 68], ecx
	mov dword [ ebp - 72], edx
	mov dword [ ebp - 76], esi
	mov dword [ ebp - 80], edi
	call func_MyBinarySearch_binarySearch
	add esp, 2* 4
	; TEST
	mov dword [ebp - 96], eax
	mov dword eax, [ebp - 4]
	push eax
	mov dword ebx, [ebp - 96]
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 96], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_MyBinarySearch_MyBinarySearch:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
