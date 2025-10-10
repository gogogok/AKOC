.include "macrolib.asm"
.include "sqrt.asm"

.data 
	input_double: .asciz "Введите не отрицательное число, у которого хотите извлечь корень:\n"
	input_accuracy: .asciz "Введите не отрицательную точность (максимально допустимое отклонение) ответа:\n"
	result_string: .asciz "Результат вычисления: "

.text
.globl main
	
main:
	read_float(input_double)
	check_for_sqrt(input_double)
	
	fmv.s fs1 fa0
	
	read_float(input_accuracy)
	check_for_accuracy(input_accuracy)
	
	jal get_sqrt
	
	print_float(result_string)
	
	li a7 10
	li a0 0
	ecall
