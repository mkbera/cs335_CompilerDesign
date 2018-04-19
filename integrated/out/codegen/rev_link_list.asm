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
func_Node_Node:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov ecx, [ebx+4]
	;mem
	;d_5
	mov dword edx, [ebp - -8]
	mov dword [ebx+0], edx
	mov dword [ ebp - -8], edx
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 4], eax
	mov dword [ ebp - 8], ecx
	mov dword esp, ebp
	pop ebp
	ret
func_LinkedList_reverse:
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
	mov dword eax, [ ebp - -8]
	mov dword [ ebp - 16], 0
	mov dword [ ebp - 8], eax

label_27:
	mov dword [ ebp - 20], 1
	cmp dword [ ebp - 16], 4
	jl label_31
	mov dword [ ebp - 20], 0

label_31:
	cmp dword [ ebp - 20], 0
	je label_43
	mov dword ebx, [ebp - 8]
	mov eax, [ebx+4]
	mov dword [ ebp - 24], eax
	;mem
	;prev_11
	mov dword ecx, [ebp - 4]
	mov dword [ebx+4], ecx
	mov dword ecx, ebx
	mov dword ebx, eax
	mov dword edx, [ebp - 16]
	mov dword [ ebp - 16], edx
	add dword edx, 1
	mov dword [ ebp - 32], edx
	mov dword [ ebp - 4], ecx
	mov dword [ ebp - 8], ebx
	mov dword [ ebp - 12], eax
	mov dword [ ebp - 16], edx
	jmp label_27

label_43:
	mov dword eax, [ ebp - 4]
	mov dword [ ebp - -8], eax
	mov dword eax, [ebp - -8]
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
func_LinkedList_printList:
	push ebp
	mov ebp, esp
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	sub esp, 4
	mov dword [ ebp - 4], 0

label_52:
	mov dword [ ebp - 8], 1
	cmp dword [ ebp - 4], 4
	jl label_56
	mov dword [ ebp - 8], 0

label_56:
	cmp dword [ ebp - 8], 0
	je label_76
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	mov dword edx, [ebp - -8]
	mov ecx, [edx+0]
	push eax
	push ecx
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - -8], edx
	mov dword [ ebp - 12], eax
	mov dword [ ebp - 16], ecx
	call func_IO_print_int
	add esp, 2* 4
	mov dword ebx, [ebp - -12]
	mov eax, [ebx+0]
	push eax
	;-1
	push 10
	mov dword [ ebp - -12], ebx
	mov dword [ ebp - 20], eax
	call func_IO_print_char
	add esp, 1* 4
	mov dword ebx, [ebp - -8]
	mov eax, [ebx+4]
	mov dword ebx, eax
	mov dword ecx, [ebp - 4]
	mov dword [ ebp - 4], ecx
	add dword ecx, 1
	mov dword [ ebp - 28], ecx
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 4], ecx
	mov dword [ ebp - 24], eax
	jmp label_52

label_76:
	mov dword esp, ebp
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
	push 8
	call malloc
	add esp, 4
	mov [ebp -8], eax
	mov dword eax, [ebp - 8]
	push eax
	mov dword [ ebp - 8], eax
	call func_LinkedList_LinkedList
	add esp, 1* 4
	mov dword eax, [ ebp - 8]
	mov [ebp - 4], eax
	push 8
	call malloc
	add esp, 4
	mov [ebp -12], eax
	mov dword eax, [ebp - 12]
	push eax
	;-1
	push 85
	mov dword [ ebp - 12], eax
	call func_Node_Node
	add esp, 1* 4
	;mem
	;t19
	mov dword eax, [ebp - 12]
	mov dword ebx, [ebp - 4]
	mov dword [ebx+4], eax
	mov [ebp - 12], eax
	push 8
	call malloc
	add esp, 4
	mov [ebp -20], eax
	mov dword eax, [ebp - 20]
	push eax
	;-1
	push 15
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 20], eax
	call func_Node_Node
	add esp, 1* 4
	mov dword ebx, [ebp - 4]
	mov eax, [ebx+4]
	;mem
	;t22
	mov dword ecx, [ebp - 20]
	mov dword [eax+4], ecx
	mov [ebp - 24], eax
	push 8
	call malloc
	add esp, 4
	mov [ebp -32], eax
	mov dword eax, [ebp - 32]
	push eax
	;-1
	push 4
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 20], ecx
	mov dword [ ebp - 32], eax
	call func_Node_Node
	add esp, 1* 4
	mov dword ebx, [ebp - 4]
	mov eax, [ebx+4]
	mov ecx, [eax+4]
	;mem
	;t26
	mov dword edx, [ebp - 32]
	mov dword [ecx+4], edx
	mov [ebp - 36], eax
	push 8
	call malloc
	add esp, 4
	mov [ebp -48], eax
	mov dword eax, [ebp - 48]
	push eax
	;-1
	push 20
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 32], edx
	mov dword [ ebp - 40], ecx
	mov dword [ ebp - 48], eax
	call func_Node_Node
	add esp, 1* 4
	mov dword ebx, [ebp - 4]
	mov eax, [ebx+4]
	mov ecx, [eax+4]
	mov edx, [ecx+4]
	;mem
	;t31
	mov dword esi, [ebp - 48]
	mov dword [edx+4], esi
	mov edi, [ebx+4]
	push ebx
	push edi
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 48], esi
	mov dword [ ebp - 52], eax
	mov dword [ ebp - 56], ecx
	mov dword [ ebp - 60], edx
	mov dword [ ebp - 68], edi
	call func_LinkedList_printList
	add esp, 2* 4
	mov dword ebx, [ebp - 4]
	mov eax, [ebx+4]
	push ebx
	push eax
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 72], eax
	call func_LinkedList_reverse
	add esp, 2* 4
	; TEST
	mov dword [ebp - 76], eax
	;mem
	;t35
	mov dword eax, [ebp - 76]
	mov dword ebx, [ebp - 4]
	mov dword [ebx+4], eax
	mov ecx, [ebx+4]
	push ebx
	push ecx
	mov dword [ ebp - 4], ebx
	mov dword [ ebp - 76], eax
	mov dword [ ebp - 84], ecx
	call func_LinkedList_printList
	add esp, 2* 4
	mov dword esp, ebp
	pop ebp
	ret
func_LinkedList_LinkedList:
	push ebp
	mov ebp, esp
	sub esp, 4
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
	;t4
	mov dword eax, [ebp - 8]
	mov dword ebx, [ebp - -8]
	mov dword [ebx+0], eax
	mov ecx, [ebx+4]
	mov dword [ ebp - -8], ebx
	mov dword [ ebp - 8], eax
	mov dword [ ebp - 12], ecx
	mov dword esp, ebp
	pop ebp
	ret
