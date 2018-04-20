global main

extern malloc
extern printf
extern scanf

section .data
			function_return_error_msg db "Error: function with return type not void, did not seem to return", 0x0a, 0
			array_access_up_error_msg db "Error: array index exceeds dimension size", 0x0a, 0
			array_access_low_error_msg db "Error: array index cannot be negative", 0x0a, 0
		_int db "%i", 0
		_int_in db "%i", 10, 0
		_char db "%c", 0
		_char_in db "%c", 0
		_float db "%f", 0
		_float_in db "%lf", 10, 0
		__dummy_float dq 0.0


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
func_Char_Char:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov esi, [ebx+4]
	mov edi, [ebx+0]
	;mem
	;val_5
	mov dword [ ebp - 4], eax
	mov dword eax, [ebp - -8]
	mov dword [ebx+0], eax
	mov dword [ ebp - -8], eax
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 8], esi
	mov dword [ ebp - 12], edi
	mov dword esp, ebp
	pop ebp
	ret
func_String_print:
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
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov dword [ ebp - 8], eax
	mov dword [ ebp - 12], 0
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax

label_29:
	; THIS = eax
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+8]
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 12], eax
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 16], eax
	jl label_35
	mov dword [ ebp - 20], 0

label_35:
	cmp dword [ ebp - 20], 0
	je label_50
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+12]
	mov dword edi, [ebp - 4]
	mov esi, [edi+0]
	push eax
	push esi
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], edi
	mov dword [ ebp - 24], eax
	mov dword [ ebp - 28], esi
	call func_IO_print_char
	add esp, 2* 4
	mov dword ebx, [ebp - 4]
	mov eax, [ebx+4]
	mov dword ebx, eax
	mov dword esi, [ebp - 12]
	mov dword [ ebp - 36], esi
	inc dword esi
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 12], esi
	mov dword [ ebp - 32], eax
	jmp label_29

label_50:
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+12]
	push eax
	;-1
	push 10
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 40], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword esp, ebp
	pop ebp
	ret
func_String_scan:
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
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+12]
	push eax
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 8], eax
	call func_IO_scan_char
	add esp, 1* 4
	; TEST
	mov dword [ebp - 12], eax
	mov dword eax, [ ebp - 12]
	mov dword [ ebp - 16], 1
	cmp dword eax, 10
	mov dword [ ebp - 4], eax
	je label_69
	mov dword [ ebp - 16], 0

label_69:
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 4], 0
	je label_73
	mov dword [ ebp - 20], 0

label_73:
	mov dword eax, [ebp - 16]
	mov dword [ ebp - 16], eax
	or dword eax, [ ebp - 20]
	cmp dword eax, 1
	mov dword [ ebp - 24], eax
	je label_77
	jmp label_81

label_77:
	; THIS = eax
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+8]
	mov dword [ebx+8], 0
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 28], eax
	mov dword esp, ebp
	pop ebp
	ret

label_81:
	push 8
	call malloc
	add esp, 4
	mov [ebp -32], eax
	mov dword eax, [ebp - 32]
	push eax
	mov dword ebx, [ebp - 4]
	push ebx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 32], eax
	call func_Char_Char
	add esp, 2* 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	;mem
	;t25
	mov dword esi, [ebp - 32]
	mov dword [ebx+0], esi
	; THIS = edi
	mov edi, [ebx+8]
	mov dword [ebx+8], 1
	mov dword [ ebp - 36], eax
	mov eax, [ebx+0]
	mov dword [ ebp - 48], eax
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 32], esi
	mov dword [ ebp - 40], edi
	mov dword [ ebp - 44], eax

label_96:
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+12]
	push eax
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 52], eax
	call func_IO_scan_char
	add esp, 1* 4
	; TEST
	mov dword [ebp - 56], eax
	mov dword eax, [ ebp - 56]
	mov dword [ ebp - 60], 1
	cmp dword eax, 10
	mov dword [ ebp - 4], eax
	jne label_106
	mov dword [ ebp - 60], 0

label_106:
	mov dword [ ebp - 64], 1
	cmp dword [ ebp - 4], 0
	jne label_110
	mov dword [ ebp - 64], 0

label_110:
	mov dword eax, [ebp - 60]
	mov dword [ ebp - 60], eax
	and dword eax, [ ebp - 64]
	cmp dword eax, 0
	mov dword [ ebp - 68], eax
	je label_134
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+12]
	; THIS = esi
	mov esi, [ebx+8]
	push eax
	push esi
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 72], eax
	mov dword [ ebp - 76], esi
	call func_IO_print_int
	add esp, 2* 4
	; THIS = eax
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+8]
	add dword eax, 1
	mov dword [ebx+8], eax
	mov [ebp - 80], eax
	push 8
	call malloc
	add esp, 4
	mov [ebp -84], eax
	mov dword eax, [ebp - 84]
	push eax
	mov dword esi, [ebp - 4]
	push esi
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], esi
	mov dword [ ebp - 84], eax
	call func_Char_Char
	add esp, 2* 4
	mov dword eax, [ ebp - 84]
	mov ebx, [eax+4]
	mov dword eax, ebx
	mov dword [ ebp - 44], eax
	mov dword [ ebp - 88], ebx
	jmp label_96

label_134:
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+12]
	; THIS = esi
	mov esi, [ebx+8]
	push eax
	push esi
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 92], eax
	mov dword [ ebp - 96], esi
	call func_IO_print_int
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_String_compare:
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
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+8]
	; THIS = esi
	mov dword edi, [ebp - -12]
	mov esi, [edi+8]
	mov dword [ ebp - 12], 1
	cmp dword eax, esi
	mov dword [ ebp - -12], edi
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 8], esi
	jne label_153
	mov dword [ ebp - 12], 0

label_153:
	cmp dword [ ebp - 12], 1
	je label_155
	jmp label_156

label_155:
	mov dword eax, 0
	mov dword esp, ebp
	pop ebp
	ret

label_156:
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov dword [ ebp - 20], eax
	mov dword edi, [ebp - -8]
	mov esi, [edi+0]
	mov dword [ ebp - 28], esi
	mov dword [ ebp - 32], 0
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - -8], edi
	mov dword [ ebp - 16], eax
	mov dword [ ebp - 24], esi

label_166:
	; THIS = eax
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+8]
	mov dword [ ebp - 40], 1
	cmp dword [ ebp - 32], eax
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 36], eax
	jl label_172
	mov dword [ ebp - 40], 0

label_172:
	cmp dword [ ebp - 40], 0
	je label_194
	mov dword ebx, [ebp - 16]
	mov eax, [ebx+0]
	mov dword edi, [ebp - 24]
	mov esi, [edi+0]
	mov dword [ ebp - 52], 1
	cmp dword eax, esi
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 24], edi
	mov dword [ ebp - 44], eax
	mov dword [ ebp - 48], esi
	jne label_181
	mov dword [ ebp - 52], 0

label_181:
	cmp dword [ ebp - 52], 1
	je label_183
	jmp label_184

label_183:
	mov dword eax, 0
	mov dword esp, ebp
	pop ebp
	ret

label_184:
	mov dword ebx, [ebp - 16]
	mov eax, [ebx+4]
	mov dword ebx, eax
	mov dword edi, [ebp - 24]
	mov esi, [edi+4]
	mov dword edi, esi
	mov dword [ ebp - 56], eax
	mov dword eax, [ebp - 32]
	mov dword [ ebp - 64], eax
	inc dword eax
	mov dword [ ebp - 16], ebx
	mov dword [ ebp - 24], edi
	mov dword [ ebp - 32], eax
	mov dword [ ebp - 60], esi
	jmp label_166

label_194:
	mov dword eax, 1
	mov dword esp, ebp
	pop ebp
	ret
push function_return_error_msg
call printf
mov dword eax, 1
int 0x80
func_String_String:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+0]
	mov esi, [ebx+4]
	; THIS = edi
	mov edi, [ebx+8]
	mov dword [ ebp - 4], eax
	mov eax, [ebx+12]
	mov [ebp - 16], eax
	push 0
	call malloc
	add esp, 4
	mov [ebp -20], eax
	mov dword eax, [ebp - 20]
	push eax
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 8], esi
	mov dword [ ebp - 12], edi
	mov dword [ ebp - 20], eax
	call func_IO_IO
	add esp, 1* 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+12]
	;mem
	;t9
	mov dword esi, [ebp - 20]
	mov dword [ebx+12], esi
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 20], esi
	mov dword [ ebp - 24], eax
	mov dword esp, ebp
	pop ebp
	ret
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	push 16
	call malloc
	add esp, 4
	mov [ebp -8], eax
	mov dword eax, [ebp - 8]
	push eax
	mov dword [ ebp - 8], eax
	call func_String_String
	add esp, 1* 4
	mov dword eax, [ ebp - 8]
	push eax
	mov dword [ ebp - 4], eax
	call func_String_scan
	add esp, 1* 4
	mov dword eax, [ebp - 4]
	push eax
	mov dword [ ebp - 4], eax
	call func_String_print
	add esp, 1* 4
	mov dword ebx, [ebp - 4]
	mov eax, [ebx+12]
	push eax
	;-1
	push 10
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 12], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword esp, ebp
	pop ebp
	ret
func_Test_Test:
	push ebp
	mov ebp, esp
	mov dword esp, ebp
	pop ebp
	ret
