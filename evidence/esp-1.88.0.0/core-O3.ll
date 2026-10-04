; ModuleID = 'movsp_realign_repro.52164b975cc8d24a-cgu.0'
source_filename = "movsp_realign_repro.52164b975cc8d24a-cgu.0"
target datalayout = "e-m:e-p:32:32-v1:8:8-i64:64-i128:128-n32"
target triple = "xtensa-unknown-none-elf"

; Function Attrs: noinline nounwind
define dso_local noundef zeroext i8 @realign_trigger(i8 noundef zeroext %x) unnamed_addr #0 {
start:
  %0 = alloca [4 x i8], align 4
  %p = alloca [64 x i8], align 64
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %p)
  call void @llvm.memset.p0.i32(ptr noundef nonnull align 64 dereferenceable(64) %p, i8 %x, i32 64, i1 false)
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %0)
  store ptr %p, ptr %0, align 4
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %0) #3, !srcloc !1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %0)
  %1 = getelementptr inbounds nuw i8, ptr %p, i32 3
  %_0 = load i8, ptr %1, align 1, !noundef !2
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %p)
  ret i8 %_0
}

; Function Attrs: noinline nounwind
define dso_local noundef i32 @cache_padded_channel_like(i32 noundef %cap) unnamed_addr #0 {
start:
  %0 = alloca [4 x i8], align 4
  %chan = alloca [192 x i8], align 64
  call void @llvm.lifetime.start.p0(i64 192, ptr nonnull %chan)
  store i32 0, ptr %chan, align 64
  %1 = getelementptr inbounds i8, ptr %chan, i32 64
  store i32 %cap, ptr %1, align 64
  %2 = getelementptr inbounds i8, ptr %chan, i32 128
  store i32 %cap, ptr %2, align 64
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %0)
  store ptr %chan, ptr %0, align 4
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %0) #3, !srcloc !1
  %chan1 = load ptr, ptr %0, align 4, !nonnull !2, !align !3, !noundef !2
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %0)
  %3 = load atomic i32, ptr %chan1 monotonic, align 64
  %_17 = getelementptr inbounds i8, ptr %chan1, i32 64
  %4 = load atomic i32, ptr %_17 monotonic, align 64
  %_9 = add i32 %4, %3
  %5 = getelementptr inbounds i8, ptr %chan1, i32 128
  %_12 = load i32, ptr %5, align 64, !noundef !2
  %_0 = add i32 %_9, %_12
  call void @llvm.lifetime.end.p0(i64 192, ptr nonnull %chan)
  ret i32 %_0
}

; Function Attrs: noinline nounwind
define dso_local noundef zeroext i8 @control_no_overalign(i8 noundef zeroext %x) unnamed_addr #0 {
start:
  %0 = alloca [4 x i8], align 4
  %p = alloca [64 x i8], align 1
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %p)
  call void @llvm.memset.p0.i32(ptr noundef nonnull align 1 dereferenceable(64) %p, i8 %x, i32 64, i1 false)
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %0)
  store ptr %p, ptr %0, align 4
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %0) #3, !srcloc !1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %0)
  %1 = getelementptr inbounds nuw i8, ptr %p, i32 3
  %_0 = load i8, ptr %1, align 1, !noundef !2
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %p)
  ret i8 %_0
}

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i32(ptr nocapture writeonly, i8, i32, i1 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

attributes #0 = { noinline nounwind "target-cpu"="esp32s3" }
attributes #1 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"rustc version 1.88.0-nightly (2ab28d2e7 2025-06-24) (1.88.0.0)"}
!1 = !{i64 833021792155006}
!2 = !{}
!3 = !{i64 64}
