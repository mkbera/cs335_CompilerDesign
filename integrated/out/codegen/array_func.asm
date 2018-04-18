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

label_10:
	mov dword [ ebp - 8], 1
	cmp dword [ ebp - 4], 5
	jl label_14
	mov dword [ ebp - 8], 0

label_14:
	cmp dword [ ebp - 8], 0
	je label_48
	mov dword [ ebp - 12], 0

label_17:
	mov dword [ ebp - 16], 1
	cmp dword [ ebp - 12], 5
	jl label_21
	mov dword [ ebp - 16], 0

label_21:
	cmp dword [ ebp - 16], 0
	je label_44
	mov dword eax, [ebp - 4]
	mov dword ebx, eax
	add dword ebx, [ ebp - -8]
	mov dword [ ebp - 20], ebx
	sub dword ebx, [ ebp - 12]
	mov dword [ ebp - 28], 0
	cmp dword eax, 0
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 24], ebx
	jge label_30
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_30:
	cmp dword [ ebp - 4], 5
	jl label_32
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_32:
	mov dword eax, [ebp - 28]
	add dword eax, [ ebp - 4]
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - 28], eax
	jge label_35
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_35:
	cmp dword [ ebp - 12], 5
	jl label_37
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_37:
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
	jmp label_17

label_44:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 36], eax
	add dword eax, 1
	mov dword [ ebp - 4], eax
	jmp label_10

label_48:
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
	sub esp, 4
	sub esp, 4
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
	mov dword [ ebp - 16], 9
	mov [ebp - 4], eax
	push 4
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
	mov dword ebx, [ebp - 12]
	push ebx
	mov dword ecx, [ebp - 16]
	push ecx
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 16], ecx
	mov dword [ ebp - 20], eax
	call func_rec_array_func
	add esp, 3* 4
	; TEST
	mov dword [ebp - 28], eax
	mov dword eax, [ ebp - 28]
	mov dword [ ebp - 32], 0
	mov dword [ ebp - 12], eax

label_75:
	mov dword [ ebp - 36], 1
	cmp dword [ ebp - 32], 5
	jl label_79
	mov dword [ ebp - 36], 0

label_79:
	cmp dword [ ebp - 36], 0
	je label_113
	mov dword [ ebp - 40], 0

label_82:
	mov dword [ ebp - 44], 1
	cmp dword [ ebp - 40], 5
	jl label_86
	mov dword [ ebp - 44], 0

label_86:
	cmp dword [ ebp - 44], 0
	je label_109
	mov dword [ ebp - 48], 0
	cmp dword [ ebp - 32], 0
	jge label_91
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_91:
	cmp dword [ ebp - 32], 5
	jl label_93
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_93:
	mov dword eax, [ebp - 48]
	add dword eax, [ ebp - 32]
	cmp dword [ ebp - 40], 0
	mov dword [ ebp - 48], eax
	jge label_96
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_96:
	cmp dword [ ebp - 40], 5
	jl label_98
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_98:
	mov dword eax, [ebp - 48]
	imul dword eax, eax, 5
	add dword eax, [ ebp - 40]
	mov dword ecx, [ebp - 12]
	mov dword ebx, [ecx + eax * 4]
	mov dword edx, [ebp - 4]
	push edx
	push ebx
	mov dword [ ebp - 4], edx
	mov dword [ ebp - 12], ecx
	mov dword [ ebp - 48], eax
	mov dword [ ebp - 52], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 40]
	mov dword [ ebp - 56], eax
	add dword eax, 1
	mov dword [ ebp - 40], eax
	jmp label_82

label_109:
	mov dword eax, [ebp - 32]
	mov dword [ ebp - 60], eax
	add dword eax, 1
	mov dword [ ebp - 32], eax
	jmp label_75

label_113:
	mov dword esp, ebp
	pop ebp
	ret
func_rec_rec:
	push ebp
	mov ebp, esp
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 9
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
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
