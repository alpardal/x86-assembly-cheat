/*
# asciz

    Like `.ascii` but adds null char to string

    Same as:

        .ascii "assert failed\n\x00"
        .ascii "assert failed\n\000"
*/

#include "lib/asm_io_s.h"

.data
s:
    .asciz "abc"
    s_len = . - s
cat:
    .asciz "a" "b"

ENTRY
    mov s, %eax
    ASSERT_EQ($0x00636261)

    /*
    Concatenates literals somewhat like C does,
    BUT adds a null after each one.
    */
    mov cat, %eax
    ASSERT_EQ($0x00620061)

    mov $s_len, %eax
    ASSERT_EQ($4)
    EXIT
