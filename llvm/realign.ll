; Minimal LLVM IR reproducer: a 64-byte-aligned alloca (Xtensa stack alignment is 16)
; whose address escapes to a call, compiled for the windowed ABI.
;
;   llc -mtriple=xtensa -mcpu=esp32s3 -O2 realign.ll -o -
;
; Expected: SP (a1) realigned with `movsp`, or another windowed-ABI-safe sequence.
; Actual:   entry a1, N ; ... ; and/sub on a scratch reg ; add.n a1, a1, a8
declare void @use(ptr)

define void @realign() {
entry:
  %buf = alloca [64 x i8], align 64
  call void @use(ptr %buf)
  ret void
}

; Control: same frame without over-alignment; SP is not touched after `entry`.
define void @control() {
entry:
  %buf = alloca [64 x i8], align 16
  call void @use(ptr %buf)
  ret void
}

; Related observation (separate from the movsp issue): the prologue only realigns when
; MaxAlign > 32, so an align-32 alloca gets no realignment at all and is only as aligned
; as SP (16). Expected: realignment (or an equivalent) for any MaxAlign > 16.
define void @under_aligned_32() {
entry:
  %buf = alloca [64 x i8], align 32
  call void @use(ptr %buf)
  ret void
}
