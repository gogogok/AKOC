.include "tests_macro.asm"

.data
.align 2

	#тестовые массивы
	arr1: .word 3, -3, -4, -45, -6        # положительное в начале
	arr2: .word -1, -2, -3, -4, -5        # нет положительных
	arr3: .word -1, 2, -3, 4, -5          # несколько положительных
	arr4: .word 5, -5, 6, -6, 7, -7       # последним положительным 7
	arr5: .word 0, 0, 1, 0, 0            	
	arr6: .word 3, 4, 5, 6, 7, 8 	      #все элементы положительные
	arr7: .word 1, -3, -4, 5, 4, -10, 3, 4, 5, -7 #граничный случай числа элементов

	#длины исходных массивов
	len1: .word 5
	len2: .word 5
	len3: .word 5
	len4: .word 6
	len5: .word 5
	len6: .word 6
	len7: .word 10

	#результаты тестов
	res1: .word -3, -4, -45, -6
	res2: .word  0
	res3: .word -5
	res4: .word -7
	res5: .word 0, 0
	res6: .word 0
	res7: .word -7

	#длина результирующего массива
	len_res1: .word 4
	len_res2: .word 0
	len_res3: .word 1
	len_res4: .word 1
	len_res5: .word 2
	len_res6: .word 0
	len_res7: .word 1

.text 
.global main  #перед запуском выкинь другие мейн файлы из папок пожалуйста
main:

	#запустится только если сначала проассемблировать этот файл, птом tests_macro
	
	#фактические параметры: первый - исходный массив,  второй - ожилаемый результат, третий - длина исходного массива, четвёртый - длина ожидаемого результата
	run_test(arr1, res1, len1, len_res1)
	run_test(arr2, res2, len2, len_res2)
	run_test(arr3, res3, len3, len_res3)
	run_test(arr4, res4, len4, len_res4)
	run_test(arr5, res5, len5, len_res5)
	run_test(arr6, res6, len6, len_res6)
	run_test(arr7, res7, len7, len_res7)

	
	
	