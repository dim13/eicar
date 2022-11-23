BITS 16

	org	100h

	pop	ax			; ax=0x0
	xor	ax, 0x214f		; ax=0x214f
	push	ax
	and	ax, 0x4000 + print	; ax=0x0140
	push	ax
	pop	bx			; bx=0x0140 ( print address )

	xor	al, 0x5c		; ax=0x011c
	push	ax
	pop	dx			; dx=0x011c ( string address )

	pop	ax			; ax=0x214f
	xor	ax, 0x2834		; ax=0x097b ( ah=9 int 21h )
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
	dw	0x2b48	; int 21h ah=9 print string ending in '$'
	dw	0x2a48	; int 20h program terminate program terminate
