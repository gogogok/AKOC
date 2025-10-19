.include "macrolib.asm"
.include "fill_new_massive.asm"
.include "generate_random_massive_macro.asm"

.data
.align 2
	array: .space 40 #т.к. в массиве максимум 10 элементов, а размер int - 4
	array_new: .space 40
	array_generated_length: .asciz "Длина сгенерированного массива: \n"
	array_generated: .asciz "\nСгенерированный массив: \n"
	input_length_string: .asciz "Введите количество элементов массива:\n"
	new_line: .asciz "\n"
	result: .asciz "Результат: \n"
	end_program: .asciz "Программа завершила свою работу"
	
.text
.global main #перед запуском выкинь пожалуйста tests_main из папки
main:
	print_string(array_generated_length)
	generate_random_int_for_length
	mv s0 a0
	
	write_int(s0)
	check_length(s0)
	
	print_string(array_generated)
	
	generate_random_massive(s0, array)
	write_massive(s0, array) #печать исходного массива; ввод -длина массива,  адрес массива в памяим, выход - вывод на дисплей массива
	print_string(new_line) #\n
	
	addi sp sp -16
	
	sw s0 (sp) #загрузка длины исходного массива
	
	la t0 array
	sw t0 4(sp) #указатель на память старого массива
	
	la t0 array_new  #указатель на память нового массива
	sw t0 8(sp)
	
	sw t5 12(sp) #загружаем в стек длину нового массива
	
	#информация для работы подпрограммы лежит на стеке
	jal fill_new_massive
	
	lw t5 12(sp) #кладём в t5 длину нового массива
	addi sp sp 16
	
	check_length(t5) #проверяем её; передаётся длина массива
	print_string(result) #печать строки об информации для того, что дальше будет выведен итоговый массив
	
	write_massive(t5, array_new) #печать итогового массива; ввод -длина массива,  адрес массива в памяим, выход - вывод на дисплей массива
	
	end_programm(end_program) #навершение программы с сообщением об успехе; ввод - срока сообщения, выход - вывод на дисплей сообщения
