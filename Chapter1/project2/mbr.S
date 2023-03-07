; mbr.S
section MBR vstart=0x7c00
    ;  Set Segment Register
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov sp, 0x7c00
    ; Set video memory
    mov ax, 0xb800
    mov gs, ax

    ; Print the string by writing video memory, where 4 indicates that the foreground color is red, and A indicates that the green background flashes.
    mov byte [gs:0x00], 'H'
    mov byte [gs:0x01], 0x4A
    mov byte [gs:0x02], 'e'
    mov byte [gs:0x03], 0x4A
    mov byte [gs:0x04], 'l'
    mov byte [gs:0x05], 0x4A
    mov byte [gs:0x06], 'l'
    mov byte [gs:0x07], 0x4A
    mov byte [gs:0x08], 'o'
    mov byte [gs:0x09], 0x4A
    mov byte [gs:0x0a], ' '
    mov byte [gs:0x0b], 0x4A
    mov byte [gs:0x0c], 'W'
    mov byte [gs:0x0d], 0x4A
    mov byte [gs:0x0e], 'o'
    mov byte [gs:0x0f], 0x4A
    mov byte [gs:0x10], 'r'
    mov byte [gs:0x11], 0x4A
    mov byte [gs:0x12], 'l'
    mov byte [gs:0x13], 0x4A
    mov byte [gs:0x14], 'd'
    mov byte [gs:0x15], 0x4A
    mov byte [gs:0x16], '!'
    
    ; The program hovers here.
    jmp $ 
  
 ; The previous instruction must use less than 446 bytes, and we directly let the partition table be 0.
; So this uses the times directive to start from the current byte in the final program,
; Up to the 446th+64 = 510th byte, all zeros.
times 510 - ($ - $$) db 0
 
  ; The 511th and 512th bytes are MBR signature.
  ; 0x55AA means there is a bootable os in this disk.
  db 0x55, 0xaa
