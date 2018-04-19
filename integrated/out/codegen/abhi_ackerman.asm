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
func_ackermann_Ack:
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
	mov dword eax, 1
	neg dword eax
	mov dword [ ebp - 8], eax
	mov dword ebx, 1
	neg dword ebx
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - -12], 0
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 12], ebx
	jge label_21
	mov dword [ ebp - 20], 0

label_21:
	mov dword [ ebp - 24], 1
	cmp dword [ ebp - -8], 0
	jge label_25
	mov dword [ ebp - 24], 0

label_25:
	mov dword eax, [ebp - 20]
	mov dword [ ebp - 20], eax
	and dword eax, [ ebp - 24]
	cmp dword eax, 1
	mov dword [ ebp - 28], eax
	je label_29
	jmp label_68

label_29:
	mov dword [ ebp - 32], 1
	cmp dword [ ebp - -12], 0
	je label_33
	mov dword [ ebp - 32], 0

label_33:
	cmp dword [ ebp - 32], 1
	je label_65
	mov dword [ ebp - 36], 1
	cmp dword [ ebp - -8], 0
	je label_38
	mov dword [ ebp - 36], 0

label_38:
	cmp dword [ ebp - 36], 1
	je label_56
	mov dword eax, [ebp - -8]
	mov dword [ ebp - -8], eax
	sub dword eax, 1
	mov dword ebx, [ebp - -16]
	push ebx
	mov dword ecx, [ebp - -12]
	push ecx
	push eax
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - -16], ebx
	mov dword [ ebp - 40], eax
	call func_ackermann_Ack
	add esp, 3* 4
	; TEST
	mov dword [ebp - 44], eax
	mov dword eax, [ ebp - 44]
	mov dword ebx, [ebp - -12]
	mov dword [ ebp - -12], ebx
	sub dword ebx, 1
	mov dword ecx, [ebp - -16]
	push ecx
	push ebx
	push eax
	mov dword [ ebp - -16], ecx
	mov dword [ ebp - 12], eax
	mov dword [ ebp - 48], ebx
	call func_ackermann_Ack
	add esp, 3* 4
	; TEST
	mov dword [ebp - 52], eax
	mov dword eax, [ ebp - 52]
	mov dword [ ebp - 4], eax
	jmp label_64

label_56:
	mov dword eax, [ebp - -12]
	mov dword [ ebp - -12], eax
	sub dword eax, 1
	mov dword ebx, [ebp - -16]
	push ebx
	push eax
	;-1
	push 1
	mov dword [ ebp - -16], ebx
	mov dword [ ebp - 56], eax
	call func_ackermann_Ack
	add esp, 2* 4
	; TEST
	mov dword [ebp - 60], eax
	mov dword eax, [ ebp - 60]
	mov dword [ ebp - 4], eax

label_64:
	jmp label_68

label_65:
	mov dword eax, [ebp - -8]
	mov dword [ ebp - -8], eax
	add dword eax, 1
	mov dword [ ebp - 64], eax
	mov dword [ ebp - 4], eax

label_68:
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
	call func_ackermann_ackermann
	add esp, 1* 4
	mov dword eax, [ ebp - 16]
	push eax
	;-1
	push 3
	;-1
	push 4
	mov dword [ ebp - 12], eax
	call func_ackermann_Ack
	add esp, 1* 4
	; TEST
	mov dword [ebp - 24], eax
	mov dword eax, [ ebp - 24]
	mov dword ebx, [ebp - 4]
	push ebx
	push eax
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 20], eax
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword esp, ebp
	pop ebp
	ret
func_ackermann_ackermann:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
