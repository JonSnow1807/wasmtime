;;! target = "aarch64"
;;! test = "winch"
;;! flags = "-W threads -Ccranelift-has-lse"

(module
  (memory 1)
  (func (export "_start") (param i32) (result i32)
    (i32.atomic.rmw.cmpxchg
      (i32.add (i32.const 1) (local.get 0))
      (i32.xor (i32.const 1) (local.get 0))
      (i32.xor (i32.const 2) (local.get 0)))))
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
;;       b.lo    #0xb0
;;   2c: mov     x9, x0
;;       sub     x28, x28, #0x18
;;       mov     sp, x28
;;       stur    x0, [x28, #0x10]
;;       stur    x1, [x28, #8]
;;       stur    w2, [x28, #4]
;;       ldur    w0, [x28, #4]
;;       mov     x1, #1
;;       add     w1, w1, w0, uxtx
;;       ldur    w0, [x28, #4]
;;       mov     x2, #1
;;       eor     w2, w2, w0
;;       ldur    w0, [x28, #4]
;;       mov     x3, #2
;;       eor     w3, w3, w0
;;       mov     w0, w1
;;       and     w0, w0, #3
;;       cmp     w0, #0
;;       sub     sp, x28, #8
;;       b.ne    #0xb4
;;   7c: mov     sp, x28
;;       ldur    x0, [x9, #0x38]
;;       add     x0, x0, w1, uxtw
;;       sub     sp, x28, #8
;;       casal   w2, w3, [x0]
;;       mov     sp, x28
;;       mov     w0, w2
;;       add     x28, x28, #0x18
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;   b0: udf     #0xc11f
;;   b4: udf     #0xc11f
