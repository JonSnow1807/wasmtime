;;! target = "aarch64"
;;! test = "winch"
;;! flags = "-W threads"

(module
  (memory 2)
  (func (export "f") (param i32) (result i32)
    local.get 0
    i32.atomic.load16_u offset=0x80000000
  )
)
;; wasm[0]::function[0]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       str     x28, [sp, #-0x10]!
;;       mov     x28, sp
;;       ldur    x16, [x0, #8]
;;       ldur    x16, [x16, #0x18]
;;       mov     x17, #0
;;       movk    x17, #0x18
;;       add     x16, x16, x17
;;       cmp     sp, x16
;;       b.lo    #0xd8
;;   2c: mov     x9, x0
;;       sub     x28, x28, #0x18
;;       mov     sp, x28
;;       stur    x0, [x28, #0x10]
;;       stur    x1, [x28, #8]
;;       stur    w2, [x28, #4]
;;       ldur    w0, [x28, #4]
;;       mov     x16, #0x80000000
;;       add     w0, w0, w16, uxtx
;;       and     w0, w0, #1
;;       cmp     w0, #0
;;       sub     sp, x28, #8
;;       b.ne    #0xdc
;;   60: mov     sp, x28
;;       ldur    w0, [x28, #4]
;;       ldur    x1, [x9, #0x40]
;;       mov     w2, w0
;;       sub     sp, x28, #8
;;       mov     w16, #2
;;       movk    w16, #0x8000, lsl #16
;;       adds    x2, x2, x16, uxtx
;;       b.hs    #0xe0
;;   84: mov     sp, x28
;;       cmp     x2, x1, uxtx
;;       sub     sp, x28, #8
;;       b.hi    #0xe4
;;   94: mov     sp, x28
;;       ldur    x3, [x9, #0x38]
;;       add     x3, x3, w0, uxtw
;;       mov     x16, #0x80000000
;;       add     x3, x3, x16, uxtx
;;       mov     x4, #0
;;       cmp     x2, x1, uxtx
;;       csel    x3, x4, x3, hi
;;       sub     sp, x28, #8
;;       ldarh   w0, [x3]
;;       mov     sp, x28
;;       add     x28, x28, #0x18
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;   d8: udf     #0xc11f
;;   dc: udf     #0xc11f
;;   e0: udf     #0xc11f
;;   e4: udf     #0xc11f
