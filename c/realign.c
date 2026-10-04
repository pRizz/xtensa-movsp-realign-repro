/* C reproducer for the same frame-lowering path, to show it is not Rust-specific:
 *   clang --target=xtensa-esp-elf -mcpu=esp32s3 -O2 -S realign.c -o -
 */
void use(void *p);

void realign_trigger(void) {
  _Alignas(64) char buf[64];
  use(buf);
}

void control_no_overalign(void) {
  char buf[64];
  use(buf);
}
