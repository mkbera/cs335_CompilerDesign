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
func_Qsort_quicksort:
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
	mov dword [ ebp - 32], 1
	mov dword eax, [ebp - -12]
	cmp dword eax, [ ebp - -8]
	mov dword [ ebp - -12], eax
	jl label_19
	mov dword [ ebp - 32], 0

label_19:
	cmp dword [ ebp - 32], 1
	je label_21
	jmp label_184

label_21:
	mov dword eax, [ebp - -12]
	mov dword [ ebp - 4], eax
	mov dword [ ebp - -12], eax
	mov dword ebx, [ ebp - -8]
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 16], eax

label_24:
	mov dword [ ebp - 36], 1
	mov dword eax, [ebp - 16]
	cmp dword eax, [ ebp - 8]
	mov dword [ ebp - 16], eax
	jl label_28
	mov dword [ ebp - 36], 0

label_28:
	cmp dword [ ebp - 36], 0
	je label_131

label_29:
	mov dword [ ebp - 40], 0
	cmp dword [ ebp - 16], 0
	jge label_33
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_33:
	cmp dword [ ebp - 16], 5
	jl label_35
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_35:
	; HERE
	mov dword eax, [ebp - 40]
	add dword eax, [ ebp - 16]
	mov dword esi, [ebp - -16]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 48], 0
	cmp dword [ ebp - 4], 0
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 40], eax
	mov dword [ ebp - 44], ebx
	jge label_42
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_42:
	cmp dword [ ebp - 4], 5
	jl label_44
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_44:
	; HERE
	mov dword eax, [ebp - 48]
	add dword eax, [ ebp - 4]
	mov dword esi, [ebp - -16]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 56], 1
	cmp dword [ ebp - 44], ebx
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 48], eax
	mov dword [ ebp - 52], ebx
	jle label_51
	mov dword [ ebp - 56], 0

label_51:
	mov dword [ ebp - 60], 1
	mov dword eax, [ebp - 16]
	cmp dword eax, [ ebp - -8]
	mov dword [ ebp - 16], eax
	jl label_55
	mov dword [ ebp - 60], 0

label_55:
	; HERE
	mov dword eax, [ebp - 56]
	mov dword [ ebp - 56], eax
	and dword eax, [ ebp - 60]
	cmp dword eax, 0
	mov dword [ ebp - 64], eax
	je label_62
	; HERE
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 16], eax
	add dword eax, 1
	mov dword [ ebp - 68], eax
	mov dword [ ebp - 16], eax
	jmp label_29

label_62:
	mov dword [ ebp - 72], 0
	cmp dword [ ebp - 8], 0
	jge label_66
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_66:
	cmp dword [ ebp - 8], 5
	jl label_68
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_68:
	; HERE
	mov dword eax, [ebp - 72]
	add dword eax, [ ebp - 8]
	mov dword esi, [ebp - -16]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 80], 0
	cmp dword [ ebp - 4], 0
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 72], eax
	mov dword [ ebp - 76], ebx
	jge label_75
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_75:
	cmp dword [ ebp - 4], 5
	jl label_77
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_77:
	; HERE
	mov dword eax, [ebp - 80]
	add dword eax, [ ebp - 4]
	mov dword esi, [ebp - -16]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 88], 1
	cmp dword [ ebp - 76], ebx
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 80], eax
	mov dword [ ebp - 84], ebx
	jg label_84
	mov dword [ ebp - 88], 0

label_84:
	cmp dword [ ebp - 88], 0
	je label_89
	; HERE
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	sub dword eax, 1
	mov dword [ ebp - 92], eax
	mov dword [ ebp - 8], eax
	jmp label_62

label_89:
	mov dword [ ebp - 96], 1
	mov dword eax, [ebp - 16]
	cmp dword eax, [ ebp - 8]
	mov dword [ ebp - 16], eax
	jl label_93
	mov dword [ ebp - 96], 0

label_93:
	cmp dword [ ebp - 96], 1
	je label_95
	jmp label_130

label_95:
	mov dword [ ebp - 100], 0
	cmp dword [ ebp - 16], 0
	jge label_99
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_99:
	cmp dword [ ebp - 16], 5
	jl label_101
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_101:
	; HERE
	mov dword eax, [ebp - 100]
	add dword eax, [ ebp - 16]
	mov dword esi, [ebp - -16]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 104], ebx
	mov dword [ ebp - 108], 0
	cmp dword [ ebp - 8], 0
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 100], eax
	jge label_109
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_109:
	cmp dword [ ebp - 8], 5
	jl label_111
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_111:
	; HERE
	mov dword eax, [ebp - 108]
	add dword eax, [ ebp - 8]
	mov dword esi, [ebp - -16]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 116], 0
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 108], eax
	mov dword [ ebp - 112], ebx
	jge label_118
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_118:
	cmp dword [ ebp - 16], 5
	jl label_120
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_120:
	; HERE
	mov dword eax, [ebp - 116]
	add dword eax, [ ebp - 16]
	mov dword ebx, [ebp - 112]
	mov dword esi, [ebp - -16]
	mov dword [esi + eax * 4], ebx
	mov dword [ ebp - 120], 0
	cmp dword [ ebp - 8], 0
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 112], ebx
	mov dword [ ebp - 116], eax
	jge label_126
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_126:
	cmp dword [ ebp - 8], 5
	jl label_128
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_128:
	; HERE
	mov dword eax, [ebp - 120]
	add dword eax, [ ebp - 8]
	mov dword ebx, [ebp - 12]
	mov dword esi, [ebp - -16]
	mov dword [esi + eax * 4], ebx
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 120], eax

label_130:
	jmp label_24

label_131:
	mov dword [ ebp - 124], 0
	cmp dword [ ebp - 4], 0
	jge label_135
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_135:
	cmp dword [ ebp - 4], 5
	jl label_137
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_137:
	; HERE
	mov dword eax, [ebp - 124]
	add dword eax, [ ebp - 4]
	mov dword esi, [ebp - -16]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 128], ebx
	mov dword [ ebp - 132], 0
	cmp dword [ ebp - 8], 0
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 124], eax
	jge label_145
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_145:
	cmp dword [ ebp - 8], 5
	jl label_147
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_147:
	; HERE
	mov dword eax, [ebp - 132]
	add dword eax, [ ebp - 8]
	mov dword esi, [ebp - -16]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 140], 0
	cmp dword [ ebp - 4], 0
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 132], eax
	mov dword [ ebp - 136], ebx
	jge label_154
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_154:
	cmp dword [ ebp - 4], 5
	jl label_156
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_156:
	; HERE
	mov dword eax, [ebp - 140]
	add dword eax, [ ebp - 4]
	mov dword ebx, [ebp - 136]
	mov dword esi, [ebp - -16]
	mov dword [esi + eax * 4], ebx
	mov dword [ ebp - 144], 0
	cmp dword [ ebp - 8], 0
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 136], ebx
	mov dword [ ebp - 140], eax
	jge label_162
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_162:
	cmp dword [ ebp - 8], 5
	jl label_164
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_164:
	; HERE
	mov dword eax, [ebp - 144]
	mov dword ebx, [ ebp - 8]
	add dword eax, ebx
	mov dword esi, [ebp - 12]
	mov dword edi, [ebp - -16]
	mov dword [edi + eax * 4], esi
	; HERE
	mov dword [ ebp - 144], eax
	mov dword eax, ebx
	sub dword eax, 1
	mov dword [ ebp - 148], eax
	; HERE
	mov dword [ ebp - 8], ebx
	add dword ebx, 1
	mov dword [ ebp - 152], ebx
	mov dword [ ebp - 20], eax
	mov dword eax, [ebp - -20]
	push eax
	push edi
	mov dword [ ebp - -20], eax
	mov dword eax, [ebp - -12]
	push eax
	mov dword [ ebp - -12], eax
	mov dword eax, [ebp - 20]
	push eax
	mov dword [ ebp - -16], edi
	mov dword [ ebp - 12], esi
	mov dword [ ebp - 20], eax
	mov dword [ ebp - 24], ebx
	call func_Qsort_quicksort
	add esp, 4* 4
	; TEST
	mov dword [ebp - 156], eax
	mov dword eax, [ebp - -20]
	push eax
	mov dword ebx, [ebp - -16]
	push ebx
	mov dword esi, [ebp - 24]
	push esi
	mov dword edi, [ebp - -8]
	push edi
	mov dword [ ebp - -8], edi
	mov dword [ ebp - -16], ebx
	mov dword [ ebp - -20], eax
	mov dword [ ebp - 24], esi
	call func_Qsort_quicksort
	add esp, 4* 4
	; TEST
	mov dword [ebp - 160], eax

label_184:
	mov dword eax, 0
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
	push 20
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
	mov dword ebx, 5
	mov dword [ ebp - 20], 0
	; HERE
	mov dword [ ebp - 16], ebx
	sub dword ebx, 1
	mov dword [ ebp - 28], ebx
	mov dword esi, 0
	; HERE
	add dword esi, 0
	mov dword edi, [ebp - 12]
	mov dword [edi + esi * 4], 2
	mov dword [ ebp - 4], eax
	mov dword eax, 0
	; HERE
	add dword eax, 1
	mov dword [edi + eax * 4], 1
	mov dword [ ebp - 40], eax
	mov dword eax, 0
	; HERE
	add dword eax, 2
	mov dword [edi + eax * 4], 0
	mov dword [ ebp - 44], eax
	mov dword eax, 0
	; HERE
	add dword eax, 3
	mov dword [edi + eax * 4], 5
	mov dword [ ebp - 48], eax
	mov dword eax, 0
	; HERE
	add dword eax, 4
	mov dword [edi + eax * 4], 6
	mov [ebp - 52], eax
	push 0
	call malloc
	add esp, 4
	mov [ebp -60], eax
	mov dword eax, [ebp - 60]
	push eax
	mov dword [ ebp - 12], edi
	mov dword [ ebp - 24], ebx
	mov dword [ ebp - 36], esi
	mov dword [ ebp - 60], eax
	call func_Qsort_Qsort
	add esp, 1* 4
	mov dword eax, [ ebp - 60]
	push eax
	mov dword ebx, [ebp - 12]
	push ebx
	mov dword esi, [ebp - 20]
	push esi
	mov dword edi, [ebp - 24]
	push edi
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 20], esi
	mov dword [ ebp - 24], edi
	mov dword [ ebp - 56], eax
	call func_Qsort_quicksort
	add esp, 4* 4
	; TEST
	mov dword [ebp - 68], eax
	mov dword eax, [ ebp - 68]
	mov dword [ ebp - 32], 0
	mov dword [ ebp - 64], eax

label_238:
	mov dword [ ebp - 72], 1
	cmp dword [ ebp - 32], 5
	jl label_242
	mov dword [ ebp - 72], 0

label_242:
	cmp dword [ ebp - 72], 0
	je label_255
	mov dword eax, 0
	; HERE
	add dword eax, 0
	mov dword esi, [ebp - 12]
	mov dword ebx, [esi + eax * 4]
	mov dword edi, [ebp - 4]
	push edi
	push ebx
	mov dword [ ebp - 4], edi
	mov dword [ ebp - 12], esi
	mov dword [ ebp - 76], eax
	mov dword [ ebp - 80], ebx
	call func_IO_print_int
	add esp, 2* 4
	; HERE
	mov dword eax, [ebp - 32]
	mov dword [ ebp - 32], eax
	add dword eax, 1
	mov dword [ ebp - 84], eax
	mov dword [ ebp - 32], eax
	jmp label_238

label_255:
	mov dword esp, ebp
	pop ebp
	ret
func_Qsort_Qsort:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
