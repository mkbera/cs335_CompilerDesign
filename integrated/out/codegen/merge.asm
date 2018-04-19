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
func_MergeSort_merge:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 32
	call malloc
	add esp, 4
	push eax
	push 32
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
	; HERE
	mov dword eax, [ebp - -12]
	mov dword ebx, eax
	sub dword ebx, [ ebp - -16]
	; HERE
	mov dword [ ebp - 8], ebx
	add dword ebx, 1
	mov dword [ ebp - 12], ebx
	; HERE
	mov dword esi, [ebp - -8]
	mov dword [ ebp - -8], esi
	sub dword esi, eax
	mov dword [ ebp - 20], esi
	mov dword [ ebp - 32], 0
	mov dword [ ebp - -12], eax
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 16], esi

label_24:
	mov dword [ ebp - 36], 1
	mov dword eax, [ebp - 32]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 32], eax
	jl label_28
	mov dword [ ebp - 36], 0

label_28:
	cmp dword [ ebp - 36], 0
	je label_50
	mov dword [ ebp - 40], 0
	; HERE
	mov dword eax, [ebp - -16]
	mov dword [ ebp - -16], eax
	add dword eax, [ ebp - 32]
	cmp dword eax, 0
	mov dword [ ebp - 44], eax
	jge label_35
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_35:
	cmp dword [ ebp - 44], 8
	jl label_37
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_37:
	; HERE
	mov dword eax, [ebp - 40]
	add dword eax, [ ebp - 44]
	mov dword esi, [ebp - -20]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 52], 0
	cmp dword [ ebp - 32], 0
	mov dword [ ebp - -20], esi
	mov dword [ ebp - 40], eax
	mov dword [ ebp - 48], ebx
	jge label_44
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_44:
	cmp dword [ ebp - 32], 8
	jl label_46
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_46:
	; HERE
	mov dword eax, [ebp - 52]
	mov dword ebx, [ ebp - 32]
	add dword eax, ebx
	mov dword esi, [ebp - 48]
	mov dword edi, [ebp - 24]
	mov dword [edi + eax * 4], esi
	inc dword ebx
	mov dword [ ebp - 24], edi
	mov dword [ ebp - 32], ebx
	mov dword [ ebp - 48], esi
	mov dword [ ebp - 52], eax
	jmp label_24

label_50:
	mov dword [ ebp - 56], 0

label_52:
	mov dword [ ebp - 60], 1
	mov dword eax, [ebp - 56]
	cmp dword eax, [ ebp - 16]
	mov dword [ ebp - 56], eax
	jl label_56
	mov dword [ ebp - 60], 0

label_56:
	cmp dword [ ebp - 60], 0
	je label_80
	mov dword [ ebp - 64], 0
	; HERE
	mov dword eax, [ebp - -12]
	mov dword [ ebp - -12], eax
	add dword eax, 1
	; HERE
	mov dword [ ebp - 68], eax
	add dword eax, [ ebp - 56]
	cmp dword eax, 0
	mov dword [ ebp - 72], eax
	jge label_65
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_65:
	cmp dword [ ebp - 72], 8
	jl label_67
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_67:
	; HERE
	mov dword eax, [ebp - 64]
	add dword eax, [ ebp - 72]
	mov dword esi, [ebp - -20]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 80], 0
	cmp dword [ ebp - 56], 0
	mov dword [ ebp - -20], esi
	mov dword [ ebp - 64], eax
	mov dword [ ebp - 76], ebx
	jge label_74
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_74:
	cmp dword [ ebp - 56], 8
	jl label_76
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_76:
	; HERE
	mov dword eax, [ebp - 80]
	mov dword ebx, [ ebp - 56]
	add dword eax, ebx
	mov dword esi, [ebp - 76]
	mov dword edi, [ebp - 28]
	mov dword [edi + eax * 4], esi
	inc dword ebx
	mov dword [ ebp - 28], edi
	mov dword [ ebp - 56], ebx
	mov dword [ ebp - 76], esi
	mov dword [ ebp - 80], eax
	jmp label_52

label_80:
	mov dword [ ebp - 84], 0
	mov dword [ ebp - 88], 0
	mov dword eax, [ ebp - -16]
	mov dword [ ebp - 92], eax

label_86:
	mov dword [ ebp - 96], 1
	mov dword eax, [ebp - 84]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 84], eax
	jl label_90
	mov dword [ ebp - 96], 0

label_90:
	mov dword [ ebp - 100], 1
	mov dword eax, [ebp - 88]
	cmp dword eax, [ ebp - 16]
	mov dword [ ebp - 88], eax
	jl label_94
	mov dword [ ebp - 100], 0

label_94:
	; HERE
	mov dword eax, [ebp - 96]
	mov dword [ ebp - 96], eax
	and dword eax, [ ebp - 100]
	cmp dword eax, 0
	mov dword [ ebp - 104], eax
	je label_165
	mov dword [ ebp - 108], 0
	cmp dword [ ebp - 84], 0
	jge label_101
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_101:
	cmp dword [ ebp - 84], 8
	jl label_103
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_103:
	; HERE
	mov dword eax, [ebp - 108]
	add dword eax, [ ebp - 84]
	mov dword esi, [ebp - 24]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 116], 0
	cmp dword [ ebp - 88], 0
	mov dword [ ebp - 24], esi
	mov dword [ ebp - 108], eax
	mov dword [ ebp - 112], ebx
	jge label_110
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_110:
	cmp dword [ ebp - 88], 8
	jl label_112
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_112:
	; HERE
	mov dword eax, [ebp - 116]
	add dword eax, [ ebp - 88]
	mov dword esi, [ebp - 28]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 124], 1
	cmp dword [ ebp - 112], ebx
	mov dword [ ebp - 28], esi
	mov dword [ ebp - 116], eax
	mov dword [ ebp - 120], ebx
	jle label_119
	mov dword [ ebp - 124], 0

label_119:
	cmp dword [ ebp - 124], 1
	je label_141
	mov dword [ ebp - 128], 0
	cmp dword [ ebp - 88], 0
	jge label_124
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_124:
	cmp dword [ ebp - 88], 8
	jl label_126
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_126:
	; HERE
	mov dword eax, [ebp - 128]
	add dword eax, [ ebp - 88]
	mov dword esi, [ebp - 28]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 136], 0
	cmp dword [ ebp - 92], 0
	mov dword [ ebp - 28], esi
	mov dword [ ebp - 128], eax
	mov dword [ ebp - 132], ebx
	jge label_133
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_133:
	cmp dword [ ebp - 92], 8
	jl label_135
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_135:
	; HERE
	mov dword eax, [ebp - 136]
	add dword eax, [ ebp - 92]
	mov dword ebx, [ebp - 132]
	mov dword esi, [ebp - -20]
	mov dword [esi + eax * 4], ebx
	mov dword edi, [ebp - 88]
	mov dword [ ebp - 140], edi
	inc dword edi
	mov dword [ ebp - -20], esi
	mov dword [ ebp - 88], edi
	mov dword [ ebp - 132], ebx
	mov dword [ ebp - 136], eax
	jmp label_161

label_141:
	mov dword [ ebp - 144], 0
	cmp dword [ ebp - 84], 0
	jge label_145
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_145:
	cmp dword [ ebp - 84], 8
	jl label_147
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_147:
	; HERE
	mov dword eax, [ebp - 144]
	add dword eax, [ ebp - 84]
	mov dword esi, [ebp - 24]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 152], 0
	cmp dword [ ebp - 92], 0
	mov dword [ ebp - 24], esi
	mov dword [ ebp - 144], eax
	mov dword [ ebp - 148], ebx
	jge label_154
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_154:
	cmp dword [ ebp - 92], 8
	jl label_156
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_156:
	; HERE
	mov dword eax, [ebp - 152]
	add dword eax, [ ebp - 92]
	mov dword ebx, [ebp - 148]
	mov dword esi, [ebp - -20]
	mov dword [esi + eax * 4], ebx
	mov dword edi, [ebp - 84]
	mov dword [ ebp - 156], edi
	inc dword edi
	mov dword [ ebp - -20], esi
	mov dword [ ebp - 84], edi
	mov dword [ ebp - 148], ebx
	mov dword [ ebp - 152], eax

label_161:
	mov dword eax, [ebp - 92]
	mov dword [ ebp - 160], eax
	inc dword eax
	mov dword [ ebp - 92], eax
	jmp label_86

label_165:
	mov dword [ ebp - 164], 1
	mov dword eax, [ebp - 84]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 84], eax
	jl label_169
	mov dword [ ebp - 164], 0

label_169:
	cmp dword [ ebp - 164], 0
	je label_194
	mov dword [ ebp - 168], 0
	cmp dword [ ebp - 84], 0
	jge label_174
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_174:
	cmp dword [ ebp - 84], 8
	jl label_176
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_176:
	; HERE
	mov dword eax, [ebp - 168]
	add dword eax, [ ebp - 84]
	mov dword esi, [ebp - 24]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 176], 0
	cmp dword [ ebp - 92], 0
	mov dword [ ebp - 24], esi
	mov dword [ ebp - 168], eax
	mov dword [ ebp - 172], ebx
	jge label_183
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_183:
	cmp dword [ ebp - 92], 8
	jl label_185
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_185:
	; HERE
	mov dword eax, [ebp - 176]
	mov dword ebx, [ ebp - 92]
	add dword eax, ebx
	mov dword esi, [ebp - 172]
	mov dword edi, [ebp - -20]
	mov dword [edi + eax * 4], esi
	mov dword [ ebp - 176], eax
	mov dword eax, [ebp - 84]
	mov dword [ ebp - 180], eax
	inc dword eax
	mov dword [ ebp - 84], eax
	mov dword eax, ebx
	inc dword ebx
	mov dword [ ebp - -20], edi
	mov dword [ ebp - 92], ebx
	mov dword [ ebp - 172], esi
	mov dword [ ebp - 184], eax
	jmp label_165

label_194:
	mov dword [ ebp - 188], 1
	mov dword eax, [ebp - 88]
	cmp dword eax, [ ebp - 16]
	mov dword [ ebp - 88], eax
	jl label_198
	mov dword [ ebp - 188], 0

label_198:
	cmp dword [ ebp - 188], 0
	je label_223
	mov dword [ ebp - 192], 0
	cmp dword [ ebp - 88], 0
	jge label_203
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_203:
	cmp dword [ ebp - 88], 8
	jl label_205
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_205:
	; HERE
	mov dword eax, [ebp - 192]
	add dword eax, [ ebp - 88]
	mov dword esi, [ebp - 28]
	mov dword ebx, [esi + eax * 4]
	mov dword [ ebp - 200], 0
	cmp dword [ ebp - 92], 0
	mov dword [ ebp - 28], esi
	mov dword [ ebp - 192], eax
	mov dword [ ebp - 196], ebx
	jge label_212
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_212:
	cmp dword [ ebp - 92], 8
	jl label_214
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_214:
	; HERE
	mov dword eax, [ebp - 200]
	mov dword ebx, [ ebp - 92]
	add dword eax, ebx
	mov dword esi, [ebp - 196]
	mov dword edi, [ebp - -20]
	mov dword [edi + eax * 4], esi
	mov dword [ ebp - 200], eax
	mov dword eax, [ebp - 88]
	mov dword [ ebp - 204], eax
	inc dword eax
	mov dword [ ebp - 88], eax
	mov dword eax, ebx
	inc dword ebx
	mov dword [ ebp - -20], edi
	mov dword [ ebp - 92], ebx
	mov dword [ ebp - 196], esi
	mov dword [ ebp - 208], eax
	jmp label_194

label_223:
	mov dword esp, ebp
	pop ebp
	ret
func_MergeSort_sort:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 1
	mov dword eax, [ebp - -12]
	cmp dword eax, [ ebp - -8]
	mov dword [ ebp - -12], eax
	jl label_233
	mov dword [ ebp - 4], 0

label_233:
	cmp dword [ ebp - 4], 1
	je label_235
	jmp label_259

label_235:
	; HERE
	mov dword eax, [ebp - -12]
	mov dword [ ebp - -12], eax
	add dword eax, [ ebp - -8]
	mov dword [ebp - 12], eax
	mov dword edx, 0
	mov dword ebx, 2
	cdq
	idiv dword ebx
	mov dword [ ebp - 16], eax
	mov dword ebx, [ebp - -20]
	push ebx
	mov dword esi, [ebp - -16]
	push esi
	mov dword edi, [ebp - -12]
	push edi
	push eax
	mov dword [ ebp - -20], ebx
	mov dword [ ebp - -12], edi
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 8], eax
	call func_MergeSort_sort
	add esp, 4* 4
	; HERE
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	add dword eax, 1
	mov dword ebx, [ebp - -20]
	push ebx
	mov dword esi, [ebp - -16]
	push esi
	push eax
	mov dword edi, [ebp - -8]
	push edi
	mov dword [ ebp - -20], ebx
	mov dword [ ebp - -8], edi
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 20], eax
	call func_MergeSort_sort
	add esp, 4* 4
	mov dword eax, [ebp - -20]
	push eax
	mov dword ebx, [ebp - -16]
	push ebx
	mov dword esi, [ebp - -12]
	push esi
	mov dword edi, [ebp - 8]
	push edi
	mov dword [ ebp - -20], eax
	mov dword eax, [ebp - -8]
	push eax
	mov dword [ ebp - -8], eax
	mov dword [ ebp - -12], esi
	mov dword [ ebp - -16], ebx
	mov dword [ ebp - 8], edi
	call func_MergeSort_merge
	add esp, 5* 4

label_259:
	mov dword esp, ebp
	pop ebp
	ret
func_MergeSort_printArray:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 8
	mov dword [ ebp - 8], 0

label_267:
	mov dword [ ebp - 12], 1
	mov dword eax, [ebp - 8]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 8], eax
	jl label_271
	mov dword [ ebp - 12], 0

label_271:
	cmp dword [ ebp - 12], 0
	je label_293
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov dword [ ebp - 20], 0
	cmp dword [ ebp - 8], 0
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 16], eax
	jge label_278
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_278:
	cmp dword [ ebp - 8], 8
	jl label_280
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_280:
	; HERE
	mov dword eax, [ebp - 20]
	add dword eax, [ ebp - 8]
	mov dword esi, [ebp - -8]
	mov dword ebx, [esi + eax * 4]
	mov dword edi, [ebp - 16]
	push edi
	push ebx
	mov dword [ ebp - -8], esi
	mov dword [ ebp - 16], edi
	mov dword [ ebp - 20], eax
	mov dword [ ebp - 24], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	push eax
	;-1
	push 32
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 28], eax
	call func_IO_print_char
	add esp, 1* 4
	inc dword [ ebp - 8]
	jmp label_267

label_293:
	mov dword esp, ebp
	pop ebp
	ret
main:
	push ebp
	mov ebp, esp
	push 32
	call malloc
	add esp, 4
	push eax
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword eax, [ebp - 4]
	mov dword [eax + 0 * 4], 12
	mov dword [eax + 1 * 4], 11
	mov dword [eax + 2 * 4], 13
	mov dword [eax + 3 * 4], 5
	mov dword [eax + 4 * 4], 6
	mov dword [eax + 5 * 4], 7
	mov dword [eax + 6 * 4], 67
	mov dword [eax + 7 * 4], 47
	mov [ebp - 4], eax
	push 0
	call malloc
	add esp, 4
	mov [ebp -12], eax
	mov dword eax, [ebp - 12]
	push eax
	mov dword [ ebp - 12], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword eax, [ ebp - 12]
	mov [ebp - 8], eax
	push 4
	call malloc
	add esp, 4
	mov [ebp -20], eax
	mov dword eax, [ebp - 20]
	push eax
	mov dword [ ebp - 20], eax
	call func_MergeSort_MergeSort
	add esp, 1* 4
	mov dword eax, [ ebp - 20]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 16], eax
	call func_MergeSort_printArray
	add esp, 2* 4
	mov dword eax, [ebp - 16]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	;-1
	push 0
	;-1
	push 7
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 16], eax
	call func_MergeSort_sort
	add esp, 2* 4
	mov dword eax, [ebp - 8]
	push eax
	;-1
	push 10
	mov dword [ ebp - 8], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 16]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 16], eax
	call func_MergeSort_printArray
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_MergeSort_MergeSort:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov [ebp - 4], eax
	push 0
	call malloc
	add esp, 4
	mov [ebp -8], eax
	mov dword eax, [ebp - 8]
	push eax
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 8], eax
	call func_IO_IO
	add esp, 1* 4
	;mem
	;t1
	mov dword eax, [ebp - 8]
	mov dword ebx, [ebp - -8]
	mov dword [ebx+0], eax
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 8], eax
	mov dword esp, ebp
	pop ebp
	ret
