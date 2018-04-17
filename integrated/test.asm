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
	mov dword [ ebp - 4], 0

label_9:
	mov dword [ ebp - 8], 1
	cmp dword [ ebp - 4], 5
	jl label_13
	mov dword [ ebp - 8], 0

label_13:
	cmp dword [ ebp - 8], 0
	je label_47
	mov dword [ ebp - 12], 0

label_16:
	mov dword [ ebp - 16], 1
	mov dword eax, [ ebp - 12]
	cmp dword eax, 5
	mov dword [ ebp - 12], eax
	jl label_20
	mov dword [ ebp - 16], 0

label_20:
	cmp dword [ ebp - 16], 0
	je label_43
	mov dword eax, [ebp - -8]
	mov dword ebx, [ ebp - 4]
	mov dword [ ebp - -8], eax
	add dword eax, ebx
	mov dword ecx, [ ebp - 12]
	mov dword [ ebp - 20], eax
	add dword eax, ecx
	mov dword edx, 0
	cmp dword ebx, 0
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 12], ecx
	mov dword [ ebp - 24], eax
	mov dword [ ebp - 28], edx
	jge label_29
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_29:
	mov dword eax, [ ebp - 4]
	cmp dword eax, 5
	mov dword [ ebp - 4], eax
	jl label_31
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_31:
	mov dword eax, [ebp - 28]
	add dword eax, [ ebp - 4]
	mov dword ebx, [ ebp - 12]
	cmp dword ebx, 0
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 28], eax
	jge label_34
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_34:
	mov dword eax, [ ebp - 12]
	cmp dword eax, 5
	mov dword [ ebp - 12], eax
	jl label_36
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_36:
	mov dword eax, [ebp - 28]
	imul dword eax, eax, 5
	mov dword ebx, [ ebp - 12]
	add dword eax, ebx
	mov dword ecx, [ebp - 24]
	mov dword edx, [ebp - -12]
	mov dword [edx + eax * 4], ecx
	mov dword esi, ebx
	add dword ebx, 1
	mov dword [ ebp - -12], edx
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 24], ecx
	mov dword [ ebp - 28], eax
	mov dword [ ebp - 32], esi
	jmp label_16

label_43:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 36], eax
	add dword eax, 1
	mov dword [ ebp - 4], eax
	jmp label_9

label_47:
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
	push 100
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 8], 9
	push 0
	call malloc
	add esp, 4
	mov [ebp -16], eax
	mov dword eax, [ebp - 16]
	push eax
	mov dword [ ebp - 16], eax
	call func_rec_rec
	add esp, 1* 4
	mov dword eax, [ebp - 12]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	mov dword ecx, [ebp - 8]
	push ecx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 8], ecx
	mov dword [ ebp - 12], eax
	call func_rec_array_func
	add esp, 3* 4
	mov dword eax, 0
	add dword eax, 1
	imul dword eax, eax, 5
	add dword eax, 2
	mov dword ecx, [ebp - 4]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 28], ebx
	mov [ebp - 24], eax
	push 0
	call malloc
	add esp, 4
	mov [ebp -36], eax
	mov dword edx, [ebp - 36]
	push edx
	mov dword [ ebp - 4], ecx
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 24], eax
	mov dword [ ebp - 36], edx
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ebp - 32]
	push eax
	mov dword ebx, [ebp - 8]
	push ebx
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 32], eax
	call func_IO_print_int
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_rec_rec:
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
