BITS 16
org 100h

	pop ax		; ax=0x0
	xor ax,0x214f   ; ax=0x214f
	push ax
	and ax, 0x4000 + ziel	; ax=0x0140
	push ax
	pop bx		; bx=0x0140 ( Adresse von ziel: )
	xor al,0x5c	; ax=0x11c
	push ax
	pop dx		; dx=0x11c ( Das ist die Adresse des Strings )
	pop ax		; ax=0x214f
	xor ax,0x2834	; ax=0x97b ( ah=9 Dosfunktion zur Stringausgabe )
	push ax
	pop si		; si=0x97b ( "Schlüssel" )
; Hier wird der Code an der Stelle ziel: geändert
	sub [bx],si
	inc bx
	inc bx
	sub [bx],si

	jnl ziel

; Adresse: 011Ch
DB "EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$"

ziel:

; Das ist der verschlüsselte Code ( +0x97b-Verschlüsselung )
DW 0x2b48	; int 0x21
DW 0x2a48	; int 0x20
