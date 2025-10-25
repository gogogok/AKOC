.data

#таблица хранит байтовые шаблоны для каждой цифры (0–F)
byte_table:
        .byte 0x3F  # 0
        .byte 0x06  # 1
        .byte 0x5B  # 2
        .byte 0x4F  # 3
        .byte 0x66  # 4
        .byte 0x6D  # 5
        .byte 0x7D  # 6
        .byte 0x07  # 7
        .byte 0x7F  # 8
        .byte 0x6F  # 9
        .byte 0x77  # A
        .byte 0x7C  # b
        .byte 0x39  # C
        .byte 0x5E  # d
        .byte 0x79  # E
        .byte 0x71  # F

        LEFT_ADDR: .word 0xFFFF0011
	RIGHT_ADDR: .word 0xFFFF0010	 

.text
.globl put
put:
        # a0 - значение, a1 = адрес индикатора
	addi sp sp -16
        sw ra 12(sp)
        sw t0 8(sp)
        sw t1 4(sp)
        sw t2 (sp)

        li t0 0x10  # порог 16
        blt a0 t0 skip # if a0 < 16 -> skip
        li  t1 1 #нужна точка
        j second
skip :
        li t1 0
second:
        andi t2 a0 0xF #побитовое и с 0000 1111, чтобы сохранить последние 4 разряда
        la t0 byte_table
        add t0 t0 t2  #t0 указывает на байт нужного шаблона
        lbu t2 (t0)  # шаблон сегментов 0..F

        beqz t1 third
        ori t2 t2 0x80 #побитовое или для включения точки
third:
        sb t2 (a1) 
        lw ra 12(sp)
        lw t0 8(sp)
        lw t1 4(sp)
        lw t2 0(sp)
        addi sp sp 16
        jr  ra


.globl main
main:
        li t3 0  #счётчик значения
        li t4 0  # 0 - левый индикатор, 1 - правый

loop:
    	mv a0 t3
    	beqz t4 use_left

    	# правый разряд
    	la a1 RIGHT_ADDR #a1 - адрес в .data
    	lw a1 (a1) #a1 - истинный алрес
    	j call_put
    
use_left:
    	la a1 LEFT_ADDR #a1 - адрес в .data
    	lw a1 (a1) #a1 - истинный алрес

call_put:
    	jal put

        # пауза 1000 мс
        li a7 32
        li a0 1000
        ecall

        addi t3 t3 1 #следующее значение
        andi t3 t3 0x1F #оставляем 5 бит, чтобы сделать проверку на точку
        xori t4 t4 1 # переключить разряд (лев/прав)
        j loop
