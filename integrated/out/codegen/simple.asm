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

func_Main_increase:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 0

label_9:
	mov dword [ ebp - 8], 1
	mov dword eax, [ebp - 4]
	cmp dword eax, [ ebp - -8]
	mov dword [ ebp - 4], eax
	jl label_13
	mov dword [ ebp - 8], 0

label_13:
	cmp dword [ ebp - 8], 0
	je label_23
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov dword ecx, eax
	add dword eax, 1
	mov dword edx, [ebp - 4]
	mov dword [ ebp - 20], edx
	add dword edx, 1
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 4], edx
	mov dword [ ebp - 12], eax
	mov dword [ ebp - 16], ecx
	jmp label_9

label_23:
	mov dword esp, ebp
	pop ebp
	ret
func_Main_test:
	push ebp
	mov ebp, esp
	mov dword eax, 10
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
	push 4
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword eax, [ebp - 16]
	push eax
	mov dword [ ebp - 16], eax
	call func_Main_Main
	add esp, 1* 4
	mov dword eax, 10
	mov dword [ ebp - 20], eax
	imul dword eax, eax, 5
	mov dword ebx, [ebp - 12]
	push ebx
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 28], eax
	call func_Main_test
	call func_IO_print_int
	add esp, 1* 4
	mov dword eax, [ebp - 28]
	mov dword [ ebp - 28], eax
	add dword eax, [ ebp - 32]
	fild dword [ebp - 40]
	fstp dword [ebp - 44]
	fld dword [ebp - 44]
	fistp dword [ebp - 48]
	mov dword ebx, [ ebp - 48]
	mov dword ecx, [ebp - 4]
	push ecx
	push ebx
	mov dword [ ebp - 4], ecx
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 36], eax
	call func_IO_print_int
	add esp, 2* 4
	mov dword [ ebp - 52], 0

label_64:
	mov dword [ ebp - 56], 1
	cmp dword [ ebp - 52], 10
	jl label_68
	mov dword [ ebp - 56], 0

label_68:
	cmp dword [ ebp - 56], 0
	je label_76
	mov dword eax, [ebp - 24]
	mov dword [ ebp - 60], eax
	add dword eax, 1
	mov dword ebx, [ebp - 52]
	mov dword [ ebp - 64], ebx
	add dword ebx, 1
	mov dword [ ebp - 24], eax
	mov dword [ ebp - 52], ebx
	jmp label_64

label_76:
	mov dword eax, [ebp - 4]
	push eax
	mov dword ebx, [ebp - 24]
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 24], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_Main_Main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 0
	mov dword ecx, [ebp - 8]
	add dword ecx, 1
	mov dword [ebx+0], 1
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 8], ecx
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
