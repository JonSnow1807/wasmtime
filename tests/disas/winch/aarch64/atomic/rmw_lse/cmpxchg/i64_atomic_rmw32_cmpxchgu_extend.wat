;;! target = "aarch64"
;;! test = "winch"
;;! flags = "-W threads -Ccranelift-has-lse"

(module
  (memory 1 1 shared)
  (func (export "f") (result i64)
    i32.const 0
    i64.const 0xDEADBEEF00000000
    i64.const 0x1234
    i64.atomic.rmw32.cmpxchg_u))
;; wasm[0]::function[0]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       str     x28, [sp, #-0x10]!
;;       mov     x28, sp
;;       ldur    x16, [x0, #8]
;;       ldur    x16, [x16, #0x18]
;;       mov     x17, #0
;;       movk    x17, #0x10
;;       add     x16, x16, x17
;;       cmp     sp, x16
;;       b.lo    #0x8c
;;   2c: mov     x9, x0
;;       sub     x28, x28, #0x10
;;       mov     sp, x28
;;       stur    x0, [x28, #8]
;;       stur    x1, [x28]
;;       mov     x0, #0x1234
;;       mov     x1, #0xbeef00000000
;;       movk    x1, #0xdead, lsl #48
;;       mov     x2, #0
;;       and     w2, w2, #3
;;       cmp     w2, #0
;;       b.ne    #0x90
;;   5c: mov     x2, #0
;;       ldur    x16, [x9, #0x30]
;;       ldur    x3, [x16]
;;       add     x3, x3, w2, uxtw
;;       casal   w1, w0, [x3]
;;       mov     x0, x1
;;       add     x28, x28, #0x10
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;   8c: udf     #0xc11f
;;   90: udf     #0xc11f
