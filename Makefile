PROGNAME = lenna

SFLAGS = -mthumb -march=armv7e-m -mfloat-abi=softfp -mcpu=cortex-m7 -mfpu=fpv5-sp-d16
CFLAGS = -Os -nostdlib
CXXFLAGS = -Os -nostdlib -fno-exceptions -D PICTURE=\"lenna.c\"
LDFLAGS = -nostdlib -lnumboots -lgcc -n -flto -Wl,--gc-sections -s

SRCS = \
	./lenna.c \
	./pic_viewer.cpp

OBJS = $(subst .c,.o,$(subst .cpp,.o,$(SRCS)))
EXTRA_CLEAN = $(PROGNAME).elf

$(PROGNAME).elf: $(OBJS)
	arm-none-eabi-gcc $^ -o $@ $(LDFLAGS) $(SFLAGS) -T ram.ld

%.o: %.c
	arm-none-eabi-gcc $< -c -o $@ $(CXXFLAGS) $(SFLAGS)

%.o: %.cpp
	arm-none-eabi-g++ $< -c -o $@ $(CXXFLAGS) $(SFLAGS)

clean:
	rm -f $(OBJS) $(EXTRA_CLEAN)
