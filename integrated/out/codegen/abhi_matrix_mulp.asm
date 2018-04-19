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
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 16
	call malloc
	add esp, 4
	push eax
	push 16
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
	push 16
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
	mov dword ebx, 0
	; HERE
	add dword ebx, 0
	imul dword ebx, ebx, 2
	; HERE
	add dword ebx, 0
	mov dword ecx, [ebp - 24]
	mov dword [ecx + ebx * 4], 1
	mov dword edx, 0
	; HERE
	add dword edx, 0
	imul dword edx, edx, 2
	; HERE
	add dword edx, 1
	mov dword [ecx + edx * 4], 2
	mov dword esi, 0
	; HERE
	add dword esi, 1
	imul dword esi, esi, 2
	; HERE
	add dword esi, 0
	mov dword [ecx + esi * 4], 3
	mov dword edi, 0
	; HERE
	add dword edi, 1
	imul dword edi, edi, 2
	; HERE
	add dword edi, 1
	mov dword [ecx + edi * 4], 4
	mov dword [ ebp - 4], eax
	mov dword eax, 0
	; HERE
	add dword eax, 0
	imul dword eax, eax, 2
	; HERE
	add dword eax, 0
	mov dword [ ebp - 32], ebx
	mov dword ebx, [ebp - 28]
	mov dword [ebx + eax * 4], 5
	mov dword [ ebp - 48], eax
	mov dword eax, 0
	; HERE
	add dword eax, 0
	imul dword eax, eax, 2
	; HERE
	add dword eax, 1
	mov dword [ebx + eax * 4], 6
	mov dword [ ebp - 52], eax
	mov dword eax, 0
	; HERE
	add dword eax, 1
	imul dword eax, eax, 2
	; HERE
	add dword eax, 0
	mov dword [ebx + eax * 4], 7
	mov dword [ ebp - 56], eax
	mov dword eax, 0
	; HERE
	add dword eax, 1
	imul dword eax, eax, 2
	; HERE
	add dword eax, 1
	mov dword [ebx + eax * 4], 8
	mov dword [ ebp - 12], 0
	mov dword [ ebp - 24], ecx
	mov dword [ ebp - 28], ebx
	mov dword [ ebp - 36], edx
	mov dword [ ebp - 40], esi
	mov dword [ ebp - 44], edi
	mov dword [ ebp - 60], eax

label_65:
	mov dword [ ebp - 68], 1
	cmp dword [ ebp - 12], 2
	jl label_69
	mov dword [ ebp - 68], 0

label_69:
	cmp dword [ ebp - 68], 0
	je label_98
	mov dword [ ebp - 20], 0

label_71:
	mov dword [ ebp - 72], 1
	cmp dword [ ebp - 20], 2
	jl label_75
	mov dword [ ebp - 72], 0

label_75:
	cmp dword [ ebp - 72], 0
	je label_94
	mov dword [ ebp - 76], 0
	cmp dword [ ebp - 12], 0
	jge label_80
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_80:
	cmp dword [ ebp - 12], 2
	jl label_82
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_82:
	; HERE
	mov dword eax, [ebp - 76]
	add dword eax, [ ebp - 12]
	cmp dword [ ebp - 20], 0
	mov dword [ ebp - 76], eax
	jge label_85
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_85:
	cmp dword [ ebp - 20], 2
	jl label_87
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_87:
	mov dword eax, [ebp - 76]
	imul dword eax, eax, 2
	; HERE
	mov dword ebx, [ ebp - 20]
	add dword eax, ebx
	mov dword ecx, [ebp - 64]
	mov dword [ecx + eax * 4], 0
	mov dword edx, ebx
	inc dword ebx
	mov dword [ ebp - 20], ebx
	mov dword [ ebp - 64], ecx
	mov dword [ ebp - 76], eax
	mov dword [ ebp - 80], edx
	jmp label_71

label_94:
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 84], eax
	inc dword eax
	mov dword [ ebp - 12], eax
	jmp label_65

label_98:
	mov dword [ ebp - 12], 0

label_99:
	mov dword [ ebp - 88], 1
	cmp dword [ ebp - 12], 2
	jl label_103
	mov dword [ ebp - 88], 0

label_103:
	cmp dword [ ebp - 88], 0
	je label_191
	mov dword [ ebp - 16], 0

label_105:
	mov dword [ ebp - 92], 1
	cmp dword [ ebp - 16], 2
	jl label_109
	mov dword [ ebp - 92], 0

label_109:
	cmp dword [ ebp - 92], 0
	je label_187
	mov dword [ ebp - 20], 0

label_111:
	mov dword [ ebp - 96], 1
	cmp dword [ ebp - 20], 2
	jl label_115
	mov dword [ ebp - 96], 0

label_115:
	cmp dword [ ebp - 96], 0
	je label_183
	mov dword [ ebp - 100], 0
	cmp dword [ ebp - 12], 0
	jge label_120
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_120:
	cmp dword [ ebp - 12], 2
	jl label_122
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_122:
	; HERE
	mov dword eax, [ebp - 100]
	add dword eax, [ ebp - 12]
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - 100], eax
	jge label_125
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_125:
	cmp dword [ ebp - 16], 2
	jl label_127
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_127:
	mov dword eax, [ebp - 100]
	imul dword eax, eax, 2
	; HERE
	add dword eax, [ ebp - 16]
	mov dword ecx, [ebp - 64]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 108], 0
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - 64], ecx
	mov dword [ ebp - 100], eax
	mov dword [ ebp - 104], ebx
	jge label_135
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_135:
	cmp dword [ ebp - 12], 2
	jl label_137
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_137:
	; HERE
	mov dword eax, [ebp - 108]
	add dword eax, [ ebp - 12]
	cmp dword [ ebp - 20], 0
	mov dword [ ebp - 108], eax
	jge label_140
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_140:
	cmp dword [ ebp - 20], 2
	jl label_142
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_142:
	mov dword eax, [ebp - 108]
	imul dword eax, eax, 2
	; HERE
	mov dword ebx, [ ebp - 20]
	add dword eax, ebx
	mov dword edx, [ebp - 24]
	mov dword ecx, [edx + eax * 4]
	mov dword [ ebp - 116], 0
	cmp dword ebx, 0
	mov dword [ ebp - 20], ebx
	mov dword [ ebp - 24], edx
	mov dword [ ebp - 108], eax
	mov dword [ ebp - 112], ecx
	jge label_150
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_150:
	cmp dword [ ebp - 20], 2
	jl label_152
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_152:
	; HERE
	mov dword eax, [ebp - 116]
	add dword eax, [ ebp - 20]
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - 116], eax
	jge label_155
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_155:
	cmp dword [ ebp - 16], 2
	jl label_157
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_157:
	mov dword eax, [ebp - 116]
	imul dword eax, eax, 2
	; HERE
	add dword eax, [ ebp - 16]
	mov dword ecx, [ebp - 28]
	mov dword ebx, [ecx + eax * 4]
	mov dword edx, [ebp - 112]
	mov dword [ ebp - 112], edx
	imul dword edx, ebx
	; HERE
	mov dword esi, [ebp - 104]
	mov dword [ ebp - 104], esi
	add dword esi, edx
	mov dword [ ebp - 132], 0
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - 28], ecx
	mov dword [ ebp - 116], eax
	mov dword [ ebp - 120], ebx
	mov dword [ ebp - 124], edx
	mov dword [ ebp - 128], esi
	jge label_169
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_169:
	cmp dword [ ebp - 12], 2
	jl label_171
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_171:
	; HERE
	mov dword eax, [ebp - 132]
	add dword eax, [ ebp - 12]
	cmp dword [ ebp - 16], 0
	mov dword [ ebp - 132], eax
	jge label_174
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_174:
	cmp dword [ ebp - 16], 2
	jl label_176
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_176:
	mov dword eax, [ebp - 132]
	imul dword eax, eax, 2
	; HERE
	add dword eax, [ ebp - 16]
	mov dword ebx, [ebp - 128]
	mov dword ecx, [ebp - 64]
	mov dword [ecx + eax * 4], ebx
	mov dword edx, [ebp - 20]
	mov dword [ ebp - 136], edx
	inc dword edx
	mov dword [ ebp - 20], edx
	mov dword [ ebp - 64], ecx
	mov dword [ ebp - 128], ebx
	mov dword [ ebp - 132], eax
	jmp label_111

label_183:
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 140], eax
	inc dword eax
	mov dword [ ebp - 16], eax
	jmp label_105

label_187:
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 144], eax
	inc dword eax
	mov dword [ ebp - 12], eax
	jmp label_99

label_191:
	mov dword [ ebp - 12], 0

label_192:
	mov dword [ ebp - 148], 1
	cmp dword [ ebp - 12], 2
	jl label_196
	mov dword [ ebp - 148], 0

label_196:
	cmp dword [ ebp - 148], 0
	je label_232
	mov dword [ ebp - 20], 0

label_198:
	mov dword [ ebp - 152], 1
	cmp dword [ ebp - 20], 2
	jl label_202
	mov dword [ ebp - 152], 0

label_202:
	cmp dword [ ebp - 152], 0
	je label_228
	mov dword [ ebp - 156], 0
	cmp dword [ ebp - 12], 0
	jge label_207
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_207:
	cmp dword [ ebp - 12], 2
	jl label_209
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_209:
	; HERE
	mov dword eax, [ebp - 156]
	add dword eax, [ ebp - 12]
	cmp dword [ ebp - 20], 0
	mov dword [ ebp - 156], eax
	jge label_212
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_212:
	cmp dword [ ebp - 20], 2
	jl label_214
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_214:
	mov dword eax, [ebp - 156]
	imul dword eax, eax, 2
	; HERE
	add dword eax, [ ebp - 20]
	mov dword ecx, [ebp - 64]
	mov dword ebx, [ecx + eax * 4]
	mov dword edx, [ebp - 4]
	push edx
	push ebx
	mov dword [ ebp - 4], edx
	mov dword [ ebp - 64], ecx
	mov dword [ ebp - 156], eax
	mov dword [ ebp - 160], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 20]
	mov dword [ ebp - 164], eax
	inc dword eax
	mov dword [ ebp - 20], eax
	jmp label_198

label_228:
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 168], eax
	inc dword eax
	mov dword [ ebp - 12], eax
	jmp label_192

label_232:
	mov dword esp, ebp
	pop ebp
	ret
func_matrix_multiplication_matrix_multiplication:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
