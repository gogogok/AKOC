.macro generate_random_int_for_length
    	li a0 0              # нижняя граница
    	li a1 12             # верхняя граница: 12
    	li a7 42             # ecall random int range
    	ecall
.end_macro 

.macro generate_random_int
    	li a0 0              # нижняя граница
    	li a1 21             # верхняя граница: 21 чисел от -10 до 10
    	li a7 42             # ecall random int range
    	ecall
    	addi a0 a0 -10      # смещаем диапазон: 0..20 -> -10..10
.end_macro 

.macro generate_random_massive(%length, %array)
	addi sp sp -16

	li t0 0
	sw t0 (sp)
	sw %length 4(sp)
	
	la s2 %array
	
loop:
	lw t0 (sp)
	lw t1 4(sp) #каждый раз перезагружаем длину, так как после ecall t может затираться
	
	bge t0 t1 end
	
	generate_random_int
    	
	mv t2 a0
	lw t0 (sp)
	
	sw t2 (s2)
	addi s2 s2 4
	
	addi t0 t0 1
	sw t0 (sp)
	j loop
	
end:
	addi sp sp 16
	.end_macro 
	