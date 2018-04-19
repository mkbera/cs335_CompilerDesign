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
	mov dword eax, [ ebp - -12]
	mov dword ebx, [ ebp - -16]
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 12], ebx

label_15:
	mov dword [ ebp - 16], 1
	mov dword eax, [ebp - 12]
	cmp dword eax, [ ebp - -8]
	mov dword [ ebp - 12], eax
	jle label_19
	mov dword [ ebp - 16], 0

label_19:
	cmp dword [ ebp - 16], 0
	je label_122
	mov dword ebx, [ebp - -24]
	mov eax, [ebx+0]
	push eax
	;-1
	push 65
	mov dword [ ebp - -24], ebx
	mov dword [ ebp - 20], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword ebx, [ebp - -24]
	mov eax, [ebx+0]
	push eax
	;-1
	push 10
	mov dword [ ebp - -24], ebx
	mov dword [ ebp - 24], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword [ ebp - 28], 0
	cmp dword [ ebp - -16], 0
	jge label_34
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_34:
	cmp dword [ ebp - -16], 8
	jl label_36
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_36:
	mov dword eax, [ebp - 28]
	add dword eax, [ ebp - -16]
	mov dword ecx, [ebp - -20]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 36], 0
	mov dword edx, [ebp - -12]
	mov dword [ ebp - -12], edx
	add dword edx, 1
	cmp dword edx, 0
	mov dword [ ebp - -20], ecx
	mov dword [ ebp - 28], eax
	mov dword [ ebp - 32], ebx
	mov dword [ ebp - 40], edx
	jge label_45
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_45:
	cmp dword [ ebp - 40], 8
	jl label_47
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_47:
	mov dword eax, [ebp - 36]
	add dword eax, [ ebp - 40]
	mov dword ecx, [ebp - -20]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 48], 1
	cmp dword [ ebp - 32], ebx
	mov dword [ ebp - -20], ecx
	mov dword [ ebp - 36], eax
	mov dword [ ebp - 44], ebx
	jl label_54
	mov dword [ ebp - 48], 0

label_54:
	cmp dword [ ebp - 48], 1
	je label_78
	mov dword [ ebp - 52], 0
	mov dword eax, [ebp - -12]
	mov dword [ ebp - -12], eax
	add dword eax, 1
	cmp dword eax, 0
	mov dword [ ebp - 56], eax
	jge label_61
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_61:
	cmp dword [ ebp - 56], 8
	jl label_63
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_63:
	mov dword eax, [ebp - 52]
	add dword eax, [ ebp - 56]
	mov dword ecx, [ebp - -20]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 64], 0
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - -20], ecx
	mov dword [ ebp - 52], eax
	mov dword [ ebp - 60], ebx
	jge label_70
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_70:
	cmp dword [ ebp - 12], 8
	jl label_72
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_72:
	mov dword eax, [ebp - 64]
	add dword eax, [ ebp - 12]
	mov dword ebx, [ebp - 60]
	mov dword ecx, [ebp - 8]
	mov dword [ecx + eax * 4], ebx
	mov dword edx, [ebp - -12]
	mov dword [ ebp - 68], edx
	add dword edx, 1
	mov dword [ ebp - -12], edx
	mov dword [ ebp - 8], ecx
	mov dword [ ebp - 60], ebx
	mov dword [ ebp - 64], eax
	jmp label_98

label_78:
	mov dword [ ebp - 72], 0
	cmp dword [ ebp - -16], 0
	jge label_82
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_82:
	cmp dword [ ebp - -16], 8
	jl label_84
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_84:
	mov dword eax, [ebp - 72]
	add dword eax, [ ebp - -16]
	mov dword ecx, [ebp - -20]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 80], 0
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - -20], ecx
	mov dword [ ebp - 72], eax
	mov dword [ ebp - 76], ebx
	jge label_91
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_91:
	cmp dword [ ebp - 12], 8
	jl label_93
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_93:
	mov dword eax, [ebp - 80]
	add dword eax, [ ebp - 12]
	mov dword ebx, [ebp - 76]
	mov dword ecx, [ebp - 8]
	mov dword [ecx + eax * 4], ebx
	mov dword edx, [ebp - -16]
	mov dword [ ebp - 84], edx
	add dword edx, 1
	mov dword [ ebp - -16], edx
	mov dword [ ebp - 8], ecx
	mov dword [ ebp - 76], ebx
	mov dword [ ebp - 80], eax

label_98:
	mov dword eax, [ebp - 4]
	mov dword [ ebp - 4], eax
	add dword eax, 1
	mov dword [ ebp - 92], 1
	cmp dword [ ebp - -16], eax
	mov dword [ ebp - 88], eax
	je label_104
	mov dword [ ebp - 92], 0

label_104:
	cmp dword [ ebp - 92], 1
	je label_106
	jmp label_118

label_106:
	mov dword eax, [ebp - -8]
	mov dword [ ebp - -8], eax
	add dword eax, 1
	mov dword [ ebp - 100], 1
	cmp dword [ ebp - -12], eax
	mov dword [ ebp - 96], eax
	je label_112
	mov dword [ ebp - 100], 0

label_112:
	cmp dword [ ebp - 100], 1
	je label_114
	jmp label_118

label_114:
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 104], eax
	add dword eax, 1
	mov dword [ ebp - 12], eax
	jmp label_122

label_118:
	mov dword eax, [ebp - 12]
	mov dword [ ebp - 108], eax
	add dword eax, 1
	mov dword [ ebp - 12], eax
	jmp label_15

label_122:
	mov dword [ ebp - 112], 1
	mov dword eax, [ebp - -16]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - -16], eax
	jle label_126
	mov dword [ ebp - 112], 0

label_126:
	cmp dword [ ebp - 112], 0
	je label_151
	mov dword [ ebp - 116], 0
	cmp dword [ ebp - -16], 0
	jge label_131
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_131:
	cmp dword [ ebp - -16], 8
	jl label_133
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_133:
	mov dword eax, [ebp - 116]
	add dword eax, [ ebp - -16]
	mov dword ecx, [ebp - -20]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 124], 0
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - -20], ecx
	mov dword [ ebp - 116], eax
	mov dword [ ebp - 120], ebx
	jge label_140
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_140:
	cmp dword [ ebp - 12], 8
	jl label_142
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_142:
	mov dword eax, [ebp - 124]
	mov dword ebx, [ ebp - 12]
	add dword eax, ebx
	mov dword ecx, [ebp - 120]
	mov dword edx, [ebp - 8]
	mov dword [edx + eax * 4], ecx
	mov dword esi, [ebp - -16]
	mov dword [ ebp - 128], esi
	add dword esi, 1
	mov dword edi, ebx
	add dword ebx, 1
	mov dword [ ebp - -16], esi
	mov dword [ ebp - 8], edx
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 120], ecx
	mov dword [ ebp - 124], eax
	mov dword [ ebp - 132], edi
	jmp label_122

label_151:
	mov dword [ ebp - 136], 1
	mov dword eax, [ebp - -12]
	cmp dword eax, [ ebp - -8]
	mov dword [ ebp - -12], eax
	jle label_155
	mov dword [ ebp - 136], 0

label_155:
	cmp dword [ ebp - 136], 0
	je label_180
	mov dword [ ebp - 140], 0
	cmp dword [ ebp - -12], 0
	jge label_160
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_160:
	cmp dword [ ebp - -12], 8
	jl label_162
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_162:
	mov dword eax, [ebp - 140]
	add dword eax, [ ebp - -12]
	mov dword ecx, [ebp - -20]
	mov dword ebx, [ecx + eax * 4]
	mov dword [ ebp - 148], 0
	cmp dword [ ebp - 12], 0
	mov dword [ ebp - -20], ecx
	mov dword [ ebp - 140], eax
	mov dword [ ebp - 144], ebx
	jge label_169
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_169:
	cmp dword [ ebp - 12], 8
	jl label_171
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_171:
	mov dword eax, [ebp - 148]
	mov dword ebx, [ ebp - 12]
	add dword eax, ebx
	mov dword ecx, [ebp - 144]
	mov dword edx, [ebp - 8]
	mov dword [edx + eax * 4], ecx
	mov dword esi, [ebp - -12]
	mov dword [ ebp - 152], esi
	add dword esi, 1
	mov dword edi, ebx
	add dword ebx, 1
	mov dword [ ebp - -12], esi
	mov dword [ ebp - 8], edx
	mov dword [ ebp - 12], ebx
	mov dword [ ebp - 144], ecx
	mov dword [ ebp - 148], eax
	mov dword [ ebp - 156], edi
	jmp label_151

label_180:
	mov dword eax, [ ebp - -16]
	mov dword [ ebp - 160], eax

label_182:
	mov dword [ ebp - 164], 1
	mov dword eax, [ebp - 160]
	cmp dword eax, [ ebp - -8]
	mov dword [ ebp - 160], eax
	jle label_186
	mov dword [ ebp - 164], 0

label_186:
	cmp dword [ ebp - 164], 0
	je label_208
	mov dword [ ebp - 168], 0
	cmp dword [ ebp - 160], 0
	jge label_191
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_191:
	cmp dword [ ebp - 160], 8
	jl label_193
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_193:
	mov dword eax, [ebp - 168]
	mov dword ebx, [ ebp - 160]
	add dword eax, ebx
	mov dword edx, [ebp - 8]
	mov dword ecx, [edx + eax * 4]
	mov dword [ ebp - 176], 0
	cmp dword ebx, 0
	mov dword [ ebp - 8], edx
	mov dword [ ebp - 160], ebx
	mov dword [ ebp - 168], eax
	mov dword [ ebp - 172], ecx
	jge label_200
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_200:
	cmp dword [ ebp - 160], 8
	jl label_202
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_202:
	mov dword eax, [ebp - 176]
	mov dword ebx, [ ebp - 160]
	add dword eax, ebx
	mov dword ecx, [ebp - 172]
	mov dword edx, [ebp - -20]
	mov dword [edx + eax * 4], ecx
	mov dword esi, ebx
	add dword ebx, 1
	mov dword [ ebp - -20], edx
	mov dword [ ebp - 160], ebx
	mov dword [ ebp - 172], ecx
	mov dword [ ebp - 176], eax
	mov dword [ ebp - 180], esi
	jmp label_182

label_208:
	mov dword ebx, [ebp - -24]
	mov eax, [ebx+0]
	push eax
	;-1
	push 68
	mov dword [ ebp - -24], ebx
	mov dword [ ebp - 184], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword ebx, [ebp - -24]
	mov eax, [ebx+0]
	push eax
	;-1
	push 10
	mov dword [ ebp - -24], ebx
	mov dword [ ebp - 188], eax
	call func_IO_print_char
	add esp, 1* 4
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
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 1
	mov dword eax, [ebp - -12]
	cmp dword eax, [ ebp - -8]
	mov dword [ ebp - -12], eax
	jl label_228
	mov dword [ ebp - 4], 0

label_228:
	cmp dword [ ebp - 4], 1
	je label_230
	jmp label_264

label_230:
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
	mov dword ecx, [ebp - -16]
	push ecx
	mov dword edx, [ebp - -12]
	push edx
	push eax
	mov dword [ ebp - -20], ebx
	mov dword [ ebp - -12], edx
	mov dword [ ebp - -16], ecx
	mov dword [ ebp - 8], eax
	call func_MergeSort_sort
	add esp, 4* 4
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	add dword eax, 1
	mov dword ebx, [ebp - -20]
	push ebx
	mov dword ecx, [ebp - -16]
	push ecx
	push eax
	mov dword edx, [ebp - -8]
	push edx
	mov dword [ ebp - -20], ebx
	mov dword [ ebp - -8], edx
	mov dword [ ebp - -16], ecx
	mov dword [ ebp - 20], eax
	call func_MergeSort_sort
	add esp, 4* 4
	mov dword ebx, [ebp - -20]
	mov eax, [ebx+0]
	push eax
	mov dword ecx, [ebp - -8]
	push ecx
	mov dword [ ebp - -20], ebx
	mov dword [ ebp - -8], ecx
	mov dword [ ebp - 24], eax
	call func_IO_print_int
	add esp, 2* 4
	mov dword ebx, [ebp - -20]
	mov eax, [ebx+0]
	push eax
	;-1
	push 10
	mov dword [ ebp - -20], ebx
	mov dword [ ebp - 28], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - -20]
	push eax
	mov dword ebx, [ebp - -16]
	push ebx
	mov dword ecx, [ebp - -12]
	push ecx
	mov dword edx, [ebp - 8]
	push edx
	mov dword esi, [ebp - -8]
	push esi
	mov dword [ ebp - -20], eax
	mov dword [ ebp - -8], esi
	mov dword [ ebp - -12], ecx
	mov dword [ ebp - -16], ebx
	mov dword [ ebp - 8], edx
	call func_MergeSort_merge
	add esp, 5* 4

label_264:
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
	sub esp, 4
	mov dword [ ebp - 4], 8
	mov dword [ ebp - 8], 0

label_272:
	mov dword [ ebp - 12], 1
	mov dword eax, [ebp - 8]
	cmp dword eax, [ ebp - 4]
	mov dword [ ebp - 8], eax
	jl label_276
	mov dword [ ebp - 12], 0

label_276:
	cmp dword [ ebp - 12], 0
	je label_300
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov dword [ ebp - 20], 0
	cmp dword [ ebp - 8], 0
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 16], eax
	jge label_283
	push array_access_low_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_283:
	cmp dword [ ebp - 8], 8
	jl label_285
	push array_access_up_error_msg
	call printf
	mov dword eax, 1
	int 0x80

label_285:
	mov dword eax, [ebp - 20]
	add dword eax, [ ebp - 8]
	mov dword ecx, [ebp - -8]
	mov dword ebx, [ecx + eax * 4]
	mov dword edx, [ebp - 16]
	push edx
	push ebx
	mov dword [ ebp - -8], ecx
	mov dword [ ebp - 16], edx
	mov dword [ ebp - 20], eax
	mov dword [ ebp - 24], ebx
	call func_IO_print_int
	add esp, 2* 4
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	push eax
	;-1
	push 10
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 28], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword eax, [ebp - 8]
	mov dword [ ebp - 8], eax
	add dword eax, 1
	mov dword [ ebp - 32], eax
	mov dword [ ebp - 8], eax
	jmp label_272

label_300:
	mov dword esp, ebp
	pop ebp
	ret
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	push 32
	call malloc
	add esp, 4
	push eax
	push 4
	call malloc
	add esp, 4
	mov [ebp -8], eax
	mov dword eax, [ebp - 8]
	push eax
	mov dword [ ebp - 8], eax
	call func_MergeSort_MergeSort
	add esp, 1* 4
	mov dword eax, [ ebp - 8]
	mov dword ebx, [ebp - 12]
	mov dword [ebx + 0 * 4], 12
	mov dword [ebx + 1 * 4], 11
	mov dword [ebx + 2 * 4], 13
	mov dword [ebx + 3 * 4], 5
	mov dword [ebx + 4 * 4], 6
	mov dword [ebx + 5 * 4], 7
	mov dword [ebx + 6 * 4], 4
	mov dword [ebx + 7 * 4], 43
	push eax
	push ebx
	;-1
	push 0
	;-1
	push 7
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 12], ebx
	call func_MergeSort_sort
	add esp, 2* 4
	mov dword eax, [ebp - 4]
	push eax
	mov dword ebx, [ebp - 12]
	push ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 12], ebx
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
