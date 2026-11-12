;;! target = "aarch64"
;;! test = "winch"
;;! flags = "-W threads -Ccranelift-has-lse"

(module
  (memory 1 1 shared)
  (func (export "_start") (result i64)
        (i64.atomic.rmw32.and_u (i32.const 0) (i64.const 42))))
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
;;       b.lo    #0x84
;;   2c: mov     x9, x0
;;       sub     x28, x28, #0x10
;;       mov     sp, x28
;;       stur    x0, [x28, #8]
;;       stur    x1, [x28]
;;       mov     x0, #0x2a
;;       mov     x1, #0
;;       and     w1, w1, #3
;;       cmp     w1, #0
;;       b.ne    #0x88
;;   54: mov     x1, #0
;;       ldur    x16, [x9, #0x30]
;;       ldur    x2, [x16]
;;       add     x2, x2, w1, uxtw
;;       mvn     w0, w0
;;       ldclral w0, w0, [x2]
;;       add     x28, x28, #0x10
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;   84: udf     #0xc11f
;;   88: udf     #0xc11f
