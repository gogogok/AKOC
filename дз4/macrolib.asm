.data
	error_sqrt: .asciz "Число должно быть не отрицательным!"
	error_ac: .asciz "Число должно быть положительным!"


.macro write_string(%str)
	la a0 %str
	li a7 4
	ecall
.end_macro 

.macro check_for_accuracy(%str)
loop:
	li t1 0
	fcvt.s.w  ft1 t1
	fle.s t0 fa0 ft1
	beq t0 zero end
	write_string(error_ac)
	read_float(%str)
	j loop
	
end:
	.end_macro 
	
.macro check_for_sqrt(%str)
loop:
	li t1 0
	fcvt.s.w  ft1 t1
	flt.s t0 fa0 ft1
	beq t0 zero end
	write_string(error_sqrt)
	read_float(%str)
	j loop
	
end:
	.end_macro 
	

.macro read_float(%str)
	write_string(%str)
	li a7 6
	ecall	
.end_macro 

.macro print_float(%str)
	write_string(%str)
	li a7 2
	ecall
.end_macro 
