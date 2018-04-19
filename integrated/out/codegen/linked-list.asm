global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
	_int db "%i", 0x00
	_float db "%f", 0
	__dummy_float dq 0.0
	_float_in db "%lf", 0
	_int_in db "%i", 0
	_char db "%c", 0
	_char_in db "%c", 0


section .text

func_List_set_value:
	push ebp
	mov ebp, esp
	sub esp, 4
	;mem
	;x_5
	mov dword eax, [ebp - -8]
	mov dword ebx, [ebp - -12]
	mov dword [ebx+0], eax
	mov dword [ ebp - -8], eax
	mov dword [ ebp - -12], ebx
	mov dword esp, ebp
	pop ebp
	ret
func_List_set_next:
	push ebp
	mov ebp, esp
	sub esp, 4
	;mem
	;next_7
	mov dword eax, [ebp - -8]
	mov dword ebx, [ebp - -12]
	mov dword [ebx+4], eax
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - -8], eax
	mov dword esp, ebp
	pop ebp
	ret
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	push 40
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
	mov dword eax, [ ebp - 8]
	mov dword [ ebp - 16], 0
	mov dword [ ebp - 4], eax

label_27:
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 16], 10
	jl label_31
	mov dword [ ebp - 20], 0

label_31:
	cmp dword [ ebp - 20], 0
	je label_61
	push 8
	call malloc
	add esp, 4
	mov [ebp -24], eax
	mov dword eax, [ebp - 24]
	push eax
	mov dword [ ebp - 24], eax
	call func_List_List
	add esp, 1* 4
	mov dword [ ebp - 28], 0
	cmp dword [ ebp - 16], 0
	jge label_40
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_40:
	cmp dword [ ebp - 16], 10
	jl label_42
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_42:
	mov dword eax, [ebp - 28]
	mov dword ebx, [ ebp - 16]
	add dword eax, ebx
	mov dword ecx, [ebp - 24]
	mov dword edx, [ebp - 12]
	mov dword [edx + eax * 4], ecx
	imul dword esi, ebx, 2
	mov dword [ ebp - 36], 0
	cmp dword ebx, 0
	mov dword [ ebp - 12], edx
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 24], ecx
	mov dword [ ebp - 28], eax
	mov dword [ ebp - 32], esi
	jge label_50
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_50:
	cmp dword [ ebp - 16], 10
	jl label_52
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_52:
	mov dword eax, [ebp - 36]
	mov dword ebx, [ ebp - 16]
	add dword eax, ebx
	mov dword edx, [ebp - 12]
	mov dword ecx, [edx + eax * 4]
	;mem
	;t13
	mov dword esi, [ebp - 32]
	mov dword [ecx+0], esi
	mov dword edi, ebx
	add dword ebx, 1
	mov dword [ ebp - 12], edx
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 32], esi
	mov dword [ ebp - 36], eax
	mov dword [ ebp - 40], ecx
	mov dword [ ebp - 48], edi
	jmp label_27

label_61:
	mov dword [ ebp - 56], 0

label_64:
	mov dword [ ebp - 60], 1
	cmp dword [ ebp - 56], 9
	jl label_68
	mov dword [ ebp - 60], 0

label_68:
	cmp dword [ ebp - 60], 0
	je label_95
	mov dword [ ebp - 64], 0
	mov dword eax, [ebp - 56]
	mov dword [ ebp - 56], eax
	add dword eax, 1
	cmp dword eax, 0
	mov dword [ ebp - 68], eax
	jge label_75
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_75:
	cmp dword [ ebp - 68], 10
	jl label_77
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_77:
	mov dword eax, [ebp - 64]
	add dword eax, [ ebp - 68]
	mov dword ecx, [ebp - 12]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 76], 0
	cmp dword [ ebp - 56], 0
	mov dword [ ebp - 12], ecx
	mov dword [ ebp - 64], eax
	mov dword [ ebp - 72], ebx
	jge label_84
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_84:
	cmp dword [ ebp - 56], 10
	jl label_86
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_86:
	mov dword eax, [ebp - 76]
	mov dword ebx, [ ebp - 56]
	add dword eax, ebx
	mov dword edx, [ebp - 12]
	mov dword ecx, [edx + eax * 4]
	;mem
	;t21
	mov dword esi, [ebp - 72]
	mov dword [ecx+4], esi
	mov dword edi, ebx
	add dword ebx, 1
	mov dword [ ebp - 12], edx
	mov dword [ ebp - 56], ebx
	mov dword [ ebp - 72], esi
	mov dword [ ebp - 76], eax
	mov dword [ ebp - 80], ecx
	mov dword [ ebp - 88], edi
	jmp label_64

label_95:
	mov dword eax, 0
	add dword eax, 0
	mov dword ecx, [ebp - 12]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 100], ebx
	mov dword [ ebp - 104], 0
	mov dword [ ebp - 12], ecx
	mov dword [ ebp - 92], ebx
	mov dword [ ebp - 96], eax

label_104:
	mov dword [ ebp - 108], 1
	cmp dword [ ebp - 104], 10
	jl label_108
	mov dword [ ebp - 108], 0

label_108:
	cmp dword [ ebp - 108], 0
	je label_124
	mov dword ebx, [ebp - 92]
	mov eax, [ebx+0]
	mov dword ecx, [ebp - 4]
	push ecx
	push eax
	mov dword [ ebp - 4], ecx
	mov dword [ ebp - 92], ebx
	mov dword [ ebp - 112], eax
	call func_IO_print_int
	add esp, 2* 4
	mov dword ebx, [ebp - 92]
	mov eax, [ebx+4]
	mov dword ebx, eax
	mov dword ecx, [ebp - 4]
	push ecx
	;-1
	push 32
	mov dword [ ebp - 4], ecx
	mov dword [ ebp - 92], ebx
	mov dword [ ebp - 116], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 104]
	mov dword [ ebp - 120], eax
	add dword eax, 1
	mov dword [ ebp - 104], eax
	jmp label_104

label_124:
	mov dword esp, ebp
	pop ebp
	ret
func_List_List:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ebx+0], 10
	mov ecx, [ebx+4]
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
	push ebp
	mov ebp, esp
	sub esp, 4
	push esp
	push _char_in
	call scanf
	mov dword eax, [ebp - 4]
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
