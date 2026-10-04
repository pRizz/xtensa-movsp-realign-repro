; ModuleID = 'movsp_realign_repro.f6eba51747e4c43a-cgu.0'
source_filename = "movsp_realign_repro.f6eba51747e4c43a-cgu.0"
target datalayout = "e-m:e-p:32:32-v1:8:8-i64:64-i128:128-n32"
target triple = "xtensa-unknown-none-elf"

; Function Attrs: noinline nounwind
define dso_local noundef i32 @cache_padded_channel_like(i32 noundef %cap) unnamed_addr #0 {
start:
  %chan1 = alloca [4 x i8], align 4
  %chan = alloca [192 x i8], align 64
  call void @llvm.lifetime.start.p0(ptr nonnull %chan)
  store i32 0, ptr %chan, align 64
  %0 = getelementptr inbounds nuw i8, ptr %chan, i32 64
  store i32 %cap, ptr %0, align 64
  %1 = getelementptr inbounds nuw i8, ptr %chan, i32 128
  store i32 %cap, ptr %1, align 64
  store ptr %chan, ptr %chan1, align 4
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %chan1) #3, !srcloc !1
  %_14 = load ptr, ptr %chan1, align 4, !nonnull !2, !align !3, !noundef !2
  %2 = load atomic i32, ptr %_14 monotonic, align 64
  %_16 = getelementptr inbounds nuw i8, ptr %_14, i32 64
  %3 = load atomic i32, ptr %_16 monotonic, align 64
  %_9 = add i32 %3, %2
  %4 = getelementptr inbounds nuw i8, ptr %_14, i32 128
  %_12 = load i32, ptr %4, align 64, !noundef !2
  %_0 = add i32 %_9, %_12
  call void @llvm.lifetime.end.p0(ptr nonnull %chan)
  ret i32 %_0
}

; Function Attrs: noinline nounwind
define dso_local noundef zeroext i8 @control_no_overalign(i8 noundef zeroext %x) unnamed_addr #0 {
start:
  %_3 = alloca [4 x i8], align 4
  %p = alloca [64 x i8], align 1
  call void @llvm.lifetime.start.p0(ptr nonnull %p)
  call void @llvm.memset.p0.i32(ptr noundef nonnull align 1 dereferenceable(64) %p, i8 %x, i32 64, i1 false)
  call void @llvm.lifetime.start.p0(ptr nonnull %_3)
  store ptr %p, ptr %_3, align 4
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_3) #3, !srcloc !1
  call void @llvm.lifetime.end.p0(ptr nonnull %_3)
  %0 = getelementptr inbounds nuw i8, ptr %p, i32 3
  %_0 = load i8, ptr %0, align 1, !noundef !2
  call void @llvm.lifetime.end.p0(ptr nonnull %p)
  ret i8 %_0
}

; Function Attrs: noinline nounwind
define dso_local noundef zeroext i8 @realign_trigger(i8 noundef zeroext %x) unnamed_addr #0 {
start:
  %_4 = alloca [4 x i8], align 4
  %p = alloca [64 x i8], align 64
  call void @llvm.lifetime.start.p0(ptr nonnull %p)
  call void @llvm.memset.p0.i32(ptr noundef nonnull align 64 dereferenceable(64) %p, i8 %x, i32 64, i1 false)
  call void @llvm.lifetime.start.p0(ptr nonnull %_4)
  store ptr %p, ptr %_4, align 4
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_4) #3, !srcloc !1
  call void @llvm.lifetime.end.p0(ptr nonnull %_4)
  %0 = getelementptr inbounds nuw i8, ptr %p, i32 3
  %_0 = load i8, ptr %0, align 1, !noundef !2
  call void @llvm.lifetime.end.p0(ptr nonnull %p)
  ret i8 %_0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i32(ptr writeonly captures(none), i8, i32, i1 immarg) #2

attributes #0 = { noinline nounwind "target-cpu"="esp32s3" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"rustc version 1.99.0-nightly (ad02ddc22 2026-09-30) (1.99.0.0)"}
!1 = !{i64 1634492754546285}
!2 = !{}
!3 = !{i64 64}
