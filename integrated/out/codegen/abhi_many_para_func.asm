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
func_many_para_func_sum:
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
	; HERE
	mov dword eax, [ebp - -44]
	mov dword [ ebp - -44], eax
	add dword eax, [ ebp - -40]
	; HERE
	mov dword [ ebp - 4], eax
	add dword eax, [ ebp - -36]
	; HERE
	mov dword [ ebp - 8], eax
	add dword eax, [ ebp - -32]
	; HERE
	mov dword [ ebp - 12], eax
	add dword eax, [ ebp - -28]
	; HERE
	mov dword [ ebp - 16], eax
	add dword eax, [ ebp - -24]
	; HERE
	mov dword [ ebp - 20], eax
	add dword eax, [ ebp - -20]
	; HERE
	mov dword [ ebp - 24], eax
	add dword eax, [ ebp - -16]
	; HERE
	mov dword [ ebp - 28], eax
	add dword eax, [ ebp - -12]
	; HERE
	mov dword [ ebp - 32], eax
	add dword eax, [ ebp - -8]
	mov dword [ ebp - 36], eax
	mov dword eax, [ebp - 36]
	mov dword esp, ebp
	pop ebp
	ret
push function_return_error_msg
call printf
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
	call func_many_para_func_many_para_func
	add esp, 1* 4
	mov dword eax, [ ebp - 16]
	push eax
	;-1
	push 1
	;-1
	push 2
	;-1
	push 3
	;-1
	push 4
	;-1
	push 5
	;-1
	push 6
	;-1
	push 7
	;-1
	push 8
	;-1
	push 9
	;-1
	push 10
	mov dword [ ebp - 12], eax
	call func_many_para_func_sum
	add esp, 1* 4
	; TEST
	mov dword [ebp - 20], eax
	mov dword eax, [ebp - 4]
	push eax
	mov dword ebx, [ebp - 20]
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 20], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_many_para_func_many_para_func:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
