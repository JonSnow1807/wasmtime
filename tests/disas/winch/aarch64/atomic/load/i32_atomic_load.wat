;;! target = "aarch64"
;;! test = "winch"
;;! flags = "-W threads"

(module
  (import "env" "memory" (memory 1 1 shared))
  (func (param $foo i32) (result i32)
        (i32.atomic.load
          (local.get $foo))))
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
;;       b.lo    #0x90
;;   2c: mov     x9, x0
;;       sub     x28, x28, #0x18
;;       mov     sp, x28
;;       stur    x0, [x28, #0x10]
;;       stur    x1, [x28, #8]
;;       stur    w2, [x28, #4]
;;       ldur    w0, [x28, #4]
;;       and     w0, w0, #3
;;       cmp     w0, #0
;;       sub     sp, x28, #8
;;       b.ne    #0x94
;;   58: mov     sp, x28
;;       ldur    w0, [x28, #4]
;;       ldur    x16, [x9, #0x30]
;;       ldur    x1, [x16]
;;       add     x1, x1, w0, uxtw
;;       sub     sp, x28, #8
;;       ldar    w0, [x1]
;;       mov     sp, x28
;;       add     x28, x28, #0x18
;;       mov     sp, x28
;;       mov     sp, x28
;;       ldr     x28, [sp], #0x10
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;   90: udf     #0xc11f
;;   94: udf     #0xc11f
