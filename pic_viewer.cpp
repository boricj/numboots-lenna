#include <numboots.h>

#include PICTURE

extern "C" void* memset(void *ptr, int c, unsigned len) {
  uint8_t *mem = reinterpret_cast<uint8_t*>(ptr);
  while (len--)
    *mem++ = c;
  return mem;
}

extern "C" void _start(void) {
    hal_draw_pixels((320-pic_width)/2, (240-pic_height)/2, pic_width, pic_height, (const uint16_t*)pic);
    for (;;);
}
