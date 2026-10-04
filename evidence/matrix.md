| toolchain | rustc | LLVM | variant | result | per-function verdicts |
| --- | --- | --- | --- | --- | --- |
| esp-1.88.0.0 | 1.88.0-nightly (2ab28d2e7 2025-06-24) (1.88.0.0) | 19.1.2 | core, opt-level=3 | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.88.0.0 | 1.88.0-nightly (2ab28d2e7 2025-06-24) (1.88.0.0) | 19.1.2 | core, opt-level=z | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.88.0.0 | 1.88.0-nightly (2ab28d2e7 2025-06-24) (1.88.0.0) | 19.1.2 | core, opt-level=3, force-frame-pointers | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.88.0.0 | 1.88.0-nightly (2ab28d2e7 2025-06-24) (1.88.0.0) | 19.1.2 | std mpsc ctors (espidf), opt-level=z | FAIL | FAIL:std::sync::mpmc::channel FAIL:std::sync::mpmc::sync_channel |
| esp-1.90.0.0 | 1.90.0-nightly (abf50ae2e 2025-09-16) (1.90.0.0) | 20.1.1 | core, opt-level=3 | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.90.0.0 | 1.90.0-nightly (abf50ae2e 2025-09-16) (1.90.0.0) | 20.1.1 | core, opt-level=z | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.90.0.0 | 1.90.0-nightly (abf50ae2e 2025-09-16) (1.90.0.0) | 20.1.1 | core, opt-level=3, force-frame-pointers | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.90.0.0 | 1.90.0-nightly (abf50ae2e 2025-09-16) (1.90.0.0) | 20.1.1 | std mpsc ctors (espidf), opt-level=z | FAIL | FAIL:std::sync::mpmc::channel FAIL:std::sync::mpmc::sync_channel |
| esp-1.93.0.0 | 1.93.0-nightly (2b43689c5 2026-01-27) (1.93.0.0) | 20.1.1 | core, opt-level=3 | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.93.0.0 | 1.93.0-nightly (2b43689c5 2026-01-27) (1.93.0.0) | 20.1.1 | core, opt-level=z | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.93.0.0 | 1.93.0-nightly (2b43689c5 2026-01-27) (1.93.0.0) | 20.1.1 | core, opt-level=3, force-frame-pointers | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.93.0.0 | 1.93.0-nightly (2b43689c5 2026-01-27) (1.93.0.0) | 20.1.1 | std mpsc ctors (espidf), opt-level=z | FAIL | FAIL:std::sync::mpmc::channel FAIL:std::sync::mpmc::sync_channel |
| esp-1.97.0.0 | 1.97.0-nightly (8ea53bcd7 2026-07-08) (1.97.0.0) | 21.1.3 | core, opt-level=3 | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.97.0.0 | 1.97.0-nightly (8ea53bcd7 2026-07-08) (1.97.0.0) | 21.1.3 | core, opt-level=z | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.97.0.0 | 1.97.0-nightly (8ea53bcd7 2026-07-08) (1.97.0.0) | 21.1.3 | core, opt-level=3, force-frame-pointers | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.97.0.0 | 1.97.0-nightly (8ea53bcd7 2026-07-08) (1.97.0.0) | 21.1.3 | std mpsc ctors (espidf), opt-level=z | FAIL | FAIL:std::sync::mpmc::channel FAIL:std::sync::mpmc::sync_channel |
| esp-1.99.0.0 | 1.99.0-nightly (ad02ddc22 2026-09-30) (1.99.0.0) | 22.1.4 | core, opt-level=3 | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.99.0.0 | 1.99.0-nightly (ad02ddc22 2026-09-30) (1.99.0.0) | 22.1.4 | core, opt-level=z | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.99.0.0 | 1.99.0-nightly (ad02ddc22 2026-09-30) (1.99.0.0) | 22.1.4 | core, opt-level=3, force-frame-pointers | FAIL | FAIL:cache_padded_channel_like FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| esp-1.99.0.0 | 1.99.0-nightly (ad02ddc22 2026-09-30) (1.99.0.0) | 22.1.4 | std mpsc ctors (espidf), opt-level=z | BUILD-ERROR | |
| clang-esp-19.1.2_20250225 | - | esp-19.1.2_20250225 | llc realign.ll | FAIL | FAIL:realign NO-SP-ADJ:control |
| clang-esp-19.1.2_20250225 | - | esp-19.1.2_20250225 | clang realign.c | FAIL | FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
| clang-esp-22.1.4_20260825 | - | esp-22.1.4_20260825 | llc realign.ll | FAIL | FAIL:realign NO-SP-ADJ:control |
| clang-esp-22.1.4_20260825 | - | esp-22.1.4_20260825 | clang realign.c | FAIL | FAIL:realign_trigger NO-SP-ADJ:control_no_overalign |
