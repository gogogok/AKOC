.include "macroslib.asm"

.data
	max_n: .asciz "Максимальное n, при котором результат вычисления факториала размещается в 32-х разрядном машинном слове: "
	max_n_fact: .asciz "Максимальное значение факториала n: "
	new_line: .asciz "\n"
.text
.globl main

main:
        addi sp sp -12
        sw ra 8(sp) #место в памяти, хранящее адрес возврата
        
	li t0 1
	sw t0 (sp) #вершина стека - предыдущее значение факториала
	li t1 1
	
loop:
	addi t1 t1 1
	factorial(t1)
	sw a0 4(sp)  #текущее значение факториала
	lw t2 4(sp)
	divu t3 t2 t1
	
	lw t4 (sp) #загружаем в t4 превидущее значение и сравниваем с результатом деления
	bne t3 t4 done
	
	sw t2 (sp) #загружаем в предыдущее значение получившееся
	j loop
	
done:
	addi t1 t1 -1
	mv a0 t1
	lw t5 (sp)
	
	la a0 max_n
	li a7 4
	ecall 
	
	mv a0 t1
	li a7 1
	ecall
	
	la a0 new_line
	li a7 4
	ecall 
	
	la a0 max_n_fact
	li a7 4
	ecall 
	
	mv a0 t5
	li a7 1
	ecall
	
	end_pr	
	
	
