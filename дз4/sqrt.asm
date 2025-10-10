.text  

get_sqrt:
	addi sp sp -16
    	sw   ra 12(sp)
	fmv.s ft0 fs1 #здесь лежит значение исходное
	
	li t1 0
	fcvt.s.w  ft1 t1 #ft1 хранит 0
	
	feq.s t1 ft0 ft1 
	beq t1 zero init
	
	fmv.s fa0 ft0
	lw ra 12(sp)
	addi sp sp 16
	ret
	
	
init:    #проверка на меньше единицу, так как другие границы  
	fmv.s ft2 ft1 #нижняя граница
	
    	li t1 1
	fcvt.s.w ft3 t1 #здесь хранится единица
	        
	li t1 2
	fcvt.s.w ft6 t1 #здесь хранится двойка
	
    	flt.s t2 ft0 ft3    
    	bne t2 zero set_top
    	fmv.s ft4 ft0 #здесь хранится верхняя грань 
    	j loop
	
set_top:
	fmv.s ft4 ft3   
	j loop
loop:
	fsub.s ft5 ft4 ft2 #разница
	fle.s t1 ft5 fa0  
	bne t1 zero result
	fdiv.s ft7 ft5 ft6     
    	fadd.s ft7 ft7 ft2 #в ft7 хранится середина

	fmul.s ft5 ft7 ft7
	fle.s t4 ft5 ft0 
    	beq t4 zero set_new_top
	fmv.s ft2 ft7 #двигаем нижнюю границу
	j loop
	
set_new_top:
	fmv.s ft4 ft7 #двигаем верхнюю границу
   	j loop

result: 
	fadd.s ft7 ft4 ft2 
	fdiv.s fa0 ft7 ft6 #складываем начало и конец и делим на 2
	lw ra 12(sp)
	addi sp sp 16
	ret
