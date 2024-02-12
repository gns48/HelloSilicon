//
// Assembler program to print "Hello World!"
// to stdout.
//
// X0-X2 - parameters to Unix system calls
// X16 - Mach System Call function number
//

.macro .exit code
    mov x0, #\code
    mov x16, #1 // exit syscall
    svc #0x80
.endm

.macro .write fd, buf, len
    mov x0, #\fd
    adr x1, \buf
    mov x2, #\len
    mov x16, #4     // write syscall
    svc #0x80
.endm

.global _start  // Provide program starting address to linker
.align 4        // Make sure everything is aligned properly

// Setup the parameters to print hello world
// and then call the Kernel to do it.
_start: 
    .write 1, helloworld, hlength
    .exit 0

helloworld: .ascii  "Hello, World!\n"
hlength = . - helloworld
