bits 16

	org	100h

	pop	ax			; ax=0x0
	xor	ax, 214Fh		; ax=0x214f
	push	ax
	and	ax, 4000h + print	; ax=0x0140
	push	ax
	pop	bx			; bx=0x0140 ( print address )

	xor	al, 5Ch			; ax=0x011c
	push	ax
	pop	dx			; dx=0x011c ( string address )

	pop	ax			; ax=0x214f
	xor	ax, 2834h		; ax=0x097b ( ah=9 int 21h )
	push	ax
	pop	si			; si=0x097b ( encryption "key" )
	sub	[bx],si			; changes bytes at 140-141

	inc	bx
	inc	bx
	sub	[bx],si			; changes bytes at 142-143

	jnl	print			; jump over data

	; address 011ch
	db	"EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$"

print:
	; obfuscated code ( 0x097b - encoding ) address 0140h
	dw	2B48h	; int 21h ah=9 print string ending in '$'
	dw	2A48h	; int 20h program terminate
