//! Minimal triggers for Xtensa windowed-ABI dynamic stack realignment.
//!
//! Every exported function below owns a stack local whose alignment (64) exceeds the
//! Xtensa stack alignment (16), which forces LLVM to realign SP in the prologue.
//! Under the windowed ABI that SP change must be done with `movsp`; the checker in
//! `scripts/check.sh` flags prologues that change `a1` with plain arithmetic.
#![no_std]

use core::hint::black_box;
use core::sync::atomic::{AtomicUsize, Ordering};

/// Smallest trigger: one 64-byte-aligned local whose address escapes.
#[repr(align(64))]
pub struct Padded(pub [u8; 64]);

#[no_mangle]
#[inline(never)]
pub extern "C" fn realign_trigger(x: u8) -> u8 {
    let mut p = Padded([x; 64]);
    black_box(&mut p);
    p.0[3]
}

/// Copy of the shape std uses in `std::sync::mpmc::utils::CachePadded`
/// (`#[repr(align(64))]` on xtensa targets via the catch-all arm).
#[repr(align(64))]
pub struct CachePadded<T> {
    value: T,
}

impl<T> CachePadded<T> {
    #[inline(always)]
    pub const fn new(value: T) -> Self {
        Self { value }
    }
}

/// Mirrors the head/tail layout of std's array-flavor `Channel` built by `sync_channel`.
pub struct ChannelLike {
    pub head: CachePadded<AtomicUsize>,
    pub tail: CachePadded<AtomicUsize>,
    pub cap: usize,
}

#[no_mangle]
#[inline(never)]
pub extern "C" fn cache_padded_channel_like(cap: usize) -> usize {
    let chan = ChannelLike {
        head: CachePadded::new(AtomicUsize::new(0)),
        tail: CachePadded::new(AtomicUsize::new(cap)),
        cap,
    };
    let chan = black_box(&chan);
    chan.head.value.load(Ordering::Relaxed) + chan.tail.value.load(Ordering::Relaxed) + chan.cap
}

/// Control: no over-aligned local, so no realignment is expected.
#[no_mangle]
#[inline(never)]
pub extern "C" fn control_no_overalign(x: u8) -> u8 {
    let mut p = [x; 64];
    black_box(&mut p);
    p[3]
}
