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
.dseg // ������� ���, � ������ ����� �� ��� �� �����, �� ��� ����� �������
// �� ������ ����� ���� � ������ �������� ������������ ���
.cseg // ����������� �������, ��� ��� ��� ����, ������������ � ������ ��������
.org 0 // ������ ���������� Reset, ������ Interrupt � ����������� ������������ 
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


delay: // ��������
	ldi delay1, 255 // ������ � delay1 - 255
	ldi delay2, 255 // ������ � delay2 - 255
	ldi delay3, 10 // ������ � delay3 - 10
PDelay: // ����� PDelay
	dec delay1 // "dec" ������� �������� ������� �� 1 (���������) � ������ ������ razr1
	brne PDelay // ������� �� PDelay, ���� razr1 �� = 0
	dec delay2 
	brne PDelay 
	dec delay3 
	brne PDelay
	ret // "ret" - ������� ������ �� ������������
start:
	sbic PINB, PB2 // "sbic" ������� ���������� ��������� ������, ���� ��� ����� ������(��� ����� PA0)
	rjmp start // ���� ������ �� ������, ��������� �� Proga, ���� ������ ��� ������ �����������
    SBI PORTD, PD1 
	rcall delay
	CBI PORTD, PD1 
	rcall delay
    rjmp start
