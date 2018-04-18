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

func_rec_two_times:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword eax, 7
	mov dword ecx, [ebp - -8]
	mov ebx, [ecx+4]
	mov dword [ ebp - 8], ebx
	imul dword ebx, ebx, 2
	mov dword [ ebp - 12], ebx
	add dword ebx, eax
	mov dword [ ebp - -8], ecx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 16], ebx
	mov dword eax, [ebp - 16]
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
	mov dword eax, [ebp - -16]
	push eax
	mov dword [ ebp - -16], eax
	call func_rec_two_times
	add esp, 1* 4
	; TEST
	mov dword [ebp - 8], eax
	mov dword eax, [ ebp - 8]
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
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 909
	mov dword [ ebp - 8], 101
	push 0
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword eax, [ebp - 16]
	push eax
	mov dword [ ebp - 16], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ ebp - 16]
	mov [ebp - 12], eax
	push 8
	call malloc
	add esp, 4
	mov [ebp -24], eax
	mov dword eax, [ebp - 24]
	push eax
	mov dword [ ebp - 24], eax
	call func_rec_rec
	add esp, 1* 4
	mov dword eax, [ ebp - 24]
	push eax
	mov dword [ ebp - 20], eax
	call func_rec_two_times
	add esp, 1* 4
	; TEST
	mov dword [ebp - 32], eax
	mov dword eax, [ ebp - 32]
	mov dword ebx, [ebp - 12]
	push ebx
	push eax
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 28], eax
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
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 4
	mov ecx, [ebx+4]
	mov dword [ebx+4], 9
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 8], ecx
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
