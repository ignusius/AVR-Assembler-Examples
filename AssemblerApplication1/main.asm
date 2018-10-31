;
; AssemblerApplication1.asm
;
; Created: 30.10.2018 15:02:15
; Author : User
;


.def delay1	= r17
.def delay2	= r18
.def delay3	= r19
.equ led	= 4 ; PORTD bit number to blink LED on
.dseg // Сегмент ОЗУ, в данном уроке он нам не нужен, но все равно оставим
// на случай вдруг если в голову взбредет использовать его
.cseg // Программный сегмент, все что тут есть, записывается в память программ
.org 0 // Вектор прерывания Reset, раздел Interrupt в технической документации 
rjmp Reset

Reset:
SBI DDRD, PD1 
ldi r16, 0           ; reset system status
    out SREG, r16        ; init stack pointer
    ldi r16, low(RAMEND)
    out SPL, r16
    ldi r16, high(RAMEND)
    out SPH, r16
	rjmp start


delay: // Задержка
	ldi delay1, 255 // Пихаем в delay1 - 255
	ldi delay2, 255 // Пихаем в delay2 - 255
	ldi delay3, 10 // Пихаем в delay3 - 10
PDelay: // Метка PDelay
	dec delay1 // "dec" команда понижает регистр на 1 (декремент) в данном случае razr1
	brne PDelay // перейти на PDelay, если razr1 не = 0
	dec delay2 
	brne PDelay 
	dec delay3 
	brne PDelay
	ret // "ret" - команда выхода из подпрограммы
start:
	sbic PINB, PB2 // "sbic" команда пропустить следующую строку, если бит порта очищен(тут ножка PA0)
	rjmp start // Если кнопка не нажата, переходим на Proga, если нажата эта строка пропустится
    SBI PORTD, PD1 
	rcall delay
	CBI PORTD, PD1 
	rcall delay
    rjmp start
