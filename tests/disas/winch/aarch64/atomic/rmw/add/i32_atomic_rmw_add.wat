;;! target = "aarch64"
;;! test = "winch"
;;! flags = "-W threads"

(module
  (memory 1 1 shared)
  (func (export "_start") (result i32)
        (i32.atomic.rmw.add (i32.const 0) (i32.const 42))))
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
;;       b.lo    #0x90
;;   2c: mov     x9, x0
;;       sub     x28, x28, #0x10
;;       mov     sp, x28
;;       stur    x0, [x28, #8]
;;       stur    x1, [x28]
;;       mov     x0, #0x2a
;;       mov     x1, #0
;;       and     w1, w1, #3
;;       cmp     w1, #0
;;       b.ne    #0x94
;;   54: mov     x1, #0
;;       ldur    x16, [x9, #0x30]
;;       ldur    x2, [x16]
;;       add     x2, x2, w1, uxtw
;;       ldaxr   w1, [x2]
;;       add     w17, w1, w0
;;       stlxr   w16, w17, [x2]
;;       cbnz    x16, #0x64
;;   74: mov     w0, w1
;;       add     x28, x28, #0x10
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;   90: udf     #0xc11f
;;   94: udf     #0xc11f
