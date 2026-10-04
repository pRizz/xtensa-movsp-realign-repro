//! The original trigger: std's mpmc channel constructors, whose `Channel` holds
//! `CachePadded` (align 64) fields. Compiled for `xtensa-esp32s3-espidf` to an object
//! only, so no ESP-IDF checkout or linker is required.
use std::sync::mpsc::{channel, sync_channel, Receiver, Sender, SyncSender};

#[no_mangle]
#[inline(never)]
pub extern "Rust" fn make_sync_channel() -> (SyncSender<u32>, Receiver<u32>) {
    sync_channel(4)
}

#[no_mangle]
#[inline(never)]
pub extern "Rust" fn make_channel() -> (Sender<u32>, Receiver<u32>) {
    channel()
}
