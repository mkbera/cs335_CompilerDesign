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
func_rec_two_times:
	push ebp
	mov ebp, esp
	sub esp, 4
	mov dword eax, [ebp - -8]
	mov dword [ ebp - -8], eax
	imul dword eax, eax, 2
	mov dword [ ebp - 4], eax
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
func_rec_sum:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword eax, [ebp - -12]
	mov dword [ ebp - -12], eax
	add dword eax, [ ebp - -8]
	mov dword ebx, [ebp - -16]
	push ebx
	push eax
	mov dword [ ebp - -16], ebx
	mov dword [ ebp - 8], eax
	call func_rec_two_times
	add esp, 2* 4
	; TEST
	mov dword [ebp - 12], eax
	mov dword eax, [ ebp - 12]
	mov dword [ ebp - 4], eax
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
	push 20
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 20
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	push 20
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	push 20
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 20
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	push 20
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	push 12
	call malloc
	add esp, 4
	mov [ebp -8], eax
	push 20
	call malloc
	add esp, 4
	mov ebx, [ebp - 8]
	mov [ebx + 2 * 4], eax
	mov dword eax, [ebp - 8]
	push eax
	mov dword [ ebp - 8], eax
	call func_rec_rec
	add esp, 1* 4
	mov dword eax, [ ebp - 8]
	mov ebx, [eax+8]
	mov dword ecx, 0
	add dword ecx, 0
	mov dword [ebx + ecx * 4], 1
	mov [ebp - 4], eax
	push 0
	call malloc
	add esp, 4
	mov [ebp -24], eax
	mov dword eax, [ebp - 24]
	push eax
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 16], ecx
	mov dword [ ebp - 24], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ ebp - 24]
	mov dword ecx, [ebp - 4]
	mov ebx, [ecx+8]
	mov dword edx, 0
	add dword edx, 0
	mov dword esi, [ebx + edx * 4]
	push eax
	push esi
	mov dword [ ebp - 4], ecx
	mov dword [ ebp - 20], eax
	mov dword [ ebp - 28], ebx
	mov dword [ ebp - 32], edx
	mov dword [ ebp - 36], esi
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 20]
	push eax
	;-1
	push 10
	mov dword [ ebp - 20], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword ebx, [ebp - 4]
	mov eax, [ebx+8]
	mov dword ecx, 0
	add dword ecx, 0
	mov dword edx, [eax + ecx * 4]
	mov esi, [ebx+8]
	mov dword edi, 0
	add dword edi, 0
	mov dword [ ebp - 40], eax
	mov dword eax, [esi + edi * 4]
	push ebx
	push edx
	push eax
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 44], ecx
	mov dword [ ebp - 48], edx
	mov dword [ ebp - 52], esi
	mov dword [ ebp - 56], edi
	mov dword [ ebp - 60], eax
	call func_rec_sum
	add esp, 3* 4
	; TEST
	mov dword [ebp - 64], eax
	mov dword ebx, [ebp - 4]
	mov eax, [ebx+8]
	mov dword ecx, 0
	add dword ecx, 1
	mov dword edx, [ebp - 64]
	mov dword [eax + ecx * 4], edx
	mov esi, [ebx+8]
	mov dword edi, 0
	add dword edi, 1
	mov dword [ ebp - 68], eax
	mov dword eax, [esi + edi * 4]
	mov dword [ ebp - 84], eax
	mov dword eax, [ebp - 20]
	push eax
	mov dword [ ebp - 20], eax
	mov dword eax, [ebp - 84]
	push eax
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 64], edx
	mov dword [ ebp - 72], ecx
	mov dword [ ebp - 76], esi
	mov dword [ ebp - 80], edi
	mov dword [ ebp - 84], eax
	call func_IO_print_int
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_rec_rec:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	push 20
	call malloc
	add esp, 4
	push eax
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 9
	mov ecx, [ebx+4]
	mov dword [ebx+4], 10
	mov edx, [ebx+8]
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 8], ecx
	mov dword [ ebp - 12], edx
	mov dword esp, ebp
	pop ebp
	ret
