[org 0x7c00]
cli
xor ax, ax
mov ds, ax
xor dx, dx
xor cx, cx
mov dx, 0x3C2
mov al, 0x63
out dx, al

mov di, One
LoopOne:
mov dx, 0x3C4
mov al, cl
out dx, al
inc dx
mov al, [di]
out dx, al
inc di
inc cl
cmp cl, 5
jne LoopOne

mov al, 0x11
mov dx, 0x3D4
out dx, al
inc dx
in al, dx
AND al, 0x7F
out dx, al

xor cx, cx
mov di, Two
LoopTwo:
mov dx, 0x3D4
mov al, cl
out dx, al
inc dx
mov al, [di]
out dx, al
inc di
inc cl
cmp cl, 25
jne LoopTwo

xor cx, cx
mov di, Three
LoopThree:
mov dx, 0x3CE
mov al, cl
out dx, al
inc dx
mov al, [di]
out dx, al
inc di
inc cl
cmp cl, 9
jne LoopThree

mov dx, 0x3DA
in al, dx
xor cx, cx
mov di, Four
LoopFour:
mov dx, 0x3C0
mov al, cl
out dx, al
mov al, [di]
out dx, al
inc di
inc cl
cmp cl, 21
jne LoopFour

mov dx, 0x3DA
in al, dx
mov dx, 0x3C0
mov al, 0x20
out dx, al

mov dx, 0x3C8
xor al, al
out dx, al

mov ax, 0xA000
mov es, ax
xor di, di
Loop:
mov word [es:di], 0
add di, 2
cmp di, 64000
jne Loop

xor di, di
xor ax, ax
mov word dx, 0
jmp Move

; THIS IS POLLING

Loopeth:
pause
in al, 0x64
test al, 0x01
jz Loopeth
in al, 0x60

; SCANCODE CHECKING FOR ARROW KEYS, THE FIRST IS THE UP KEY, THE SECOND IS THE LEFT KEY, THE THIRD IS THE RIGHT KEY, AND THE FOURTH IS THE DOWN KEY

cmp al, 72
je Up
cmp al, 75
je Left
cmp al, 77
je Right
cmp al, 80
je Down
jmp Loopeth

Left:
cmp di, 0
je Loopeth
mov word dx, -1
jmp Move

Right:
cmp di, 63678
jae Loopeth
mov word dx, 1
jmp Move

Down:
cmp di, 63359
jae Loopeth
mov word dx, 320
jmp Move

Up:
cmp di, 320
jb Loopeth
mov word dx, -320
jmp Move

Move:
mov byte [es:di], 0
add di, 320
mov byte [es:di], 0
inc di
mov byte [es:di], 0
sub di, 320
mov byte [es:di], 0
dec di
add di, dx
mov byte [es:di], 15
add di, 320
mov byte [es:di], 15
inc di
mov byte [es:di], 15
sub di, 320
mov byte [es:di], 15
dec di
jmp Loopeth

jmp $

One: db 0x03, 0x01, 0x0F, 0x00, 0x0E
Two: db 0x5F, 0x4F, 0x50, 0x82, 0x54, 0x80, 0xBF, 0x1F, 0x00, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x9C, 0x0E, 0x8F, 0x28, 0x40, 0x96, 0xB9, 0xA3, 0xFF
Three: db 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F, 0xFF
Four: db 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x41, 0x00, 0x0F, 0x00, 0x00
times 510-($-$$) db 0
dw 0xAA55