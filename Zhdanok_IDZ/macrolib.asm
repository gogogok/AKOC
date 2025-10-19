.data
.align 2
	end_error_too_much: .asciz "Массив не должен содержать больше 10 элементов"
	end_error_too_little: .asciz "В массиве нет элементов"
	input_elem: .asciz "Введите элемент массива: "
	space: .asciz " "
	
#макро, печатающий строку
.macro print_string(%str)
	#формальный параметр: str - строка, которая будет выведена на дисплей
	la a0 %str
	li a7 4
	ecall
.end_macro 

#макро, заканчивающий программу
.macro end_programm(%str)
	#формальный параметр: str - строка, которая будет выведена на дисплей
	print_string(%str) #вызов принта строки для описания причины конца программы
	li a7 10
	li a0 0
	ecall
.end_macro 

#макро, позволяющий вводить инты
.macro input_int(%str)
	#формальный параметр: str - строка, которая будет выведена на дисплей
	print_string(%str)#вызов принта строки для описания того, что нужно ввести
	li a7 5
	ecall
.end_macro

#макро,проверяющий длину на то, подходит ли она условию
.macro check_length(%length)
	#формальный параметр: length - длина, введённая пользователем, которая будет проверена
	addi sp sp -16
	sw %length 8(sp)
	lw t3 8(sp)
	
	li t1 0
	sw t1 4(sp)
	
	lw t2 4(sp)
	ble t3 t2 error_too_little #проверка не меньше ли 0
	
	li t1 10
	sw t1 (sp)
	
	lw t2 (sp)
	
	bgt t3 t2 error_too_much#проверка не больше ли 10
	
	j ok_exit
	
error_too_much:
	#конец программы, если слишком маленький
	addi sp sp 16
	end_programm(end_error_too_much)
	
error_too_little:
#конец программы, если слишком большой
	addi sp sp 16	
	end_programm(end_error_too_little)
	
ok_exit:	
	#выход из программы	
	addi sp sp 16
	.end_macro 

#макро, получающий массив через ввод пользователя
.macro input_massive(%length, %array_begin)
	addi sp sp -16

	li t0 0
	sw t0 (sp)
	sw %length 4(sp)
	
	la s2 %array_begin
	
loop:
	lw t0 (sp)
	lw t1 4(sp) #каждый раз перезагружаем длину, так как после ecall t может затираться
	
	bge t0 t1 end
	
	input_int(input_elem) #ввод инта как элемента массива
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

#макро, пишущий инты
.macro write_int(%x)
	#формальный параметр: x - число, которое будет выведено на дисплей
	mv a0 %x
	li a7 1
	ecall
.end_macro 

#макро, выводящий массив на экран
.macro write_massive(%length, %array)
	#формальные параметры: length - длина массива, array - указатель на массив, который нужно будет напечататть
	addi sp sp -16
	
	li t0 0
	sw t0 4(sp)
	
	sw %length 8(sp)
	la s2 %array
	
	beqz %length end_empty_write_massive #выводим сообщение, если массив пустой
loop:
	lw t3 (s2)
	
	write_int(t3) #вывод элемента массива
	print_string(space) #печать пробела
	
	lw t0 4(sp)
	lw t2 8(sp)
	
	addi s2 s2 4 #двигаем указатель на размер инта
	addi t0 t0 1
	
	bge t0 t2 end
	
	sw t0 4(sp) 
	j loop

end_empty_write_massive:
	print_string(end_error_too_little) #печать сообщения о том, что в массиве нет элементов, фактический параметр end_error_too_little - строка об ошибке
	
end:

	addi sp sp 16
	.end_macro

