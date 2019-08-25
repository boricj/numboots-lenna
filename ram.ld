STACK_SIZE = 32K;

ENTRY(_start)

MEMORY {
  SRAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 256K
}

SECTIONS {
  .text : {
    *(.text)
    *(.text.*)
  } >SRAM

  .rodata : {
    *(.rodata)
    *(.rodata.*)
  } >SRAM

  .ARM.exidx: : {
    *(.ARM.exidx*)
  } >SRAM

  .preinit_array : {
    . = ALIGN(4);
    __preinit_array_start = .;
    KEEP (*(.preinit_array*))
    __preinit_array_end = .;
  } >SRAM

  .init_array : {
    . = ALIGN(4);
    _init_array_start = .;
    KEEP (*(.init_array*))
    _init_array_end = .;
  } >SRAM

  .fini_array : {
    . = ALIGN(4);
    _fini_array_start = .;
    KEEP (*(.init_array*))
    _init_array_end = .;
  } >SRAM

  .data : {
    *(.data)
    *(.data.*)
  } >SRAM

  .bss : {
    __bss_start__ = .;
    *(.bss)
    *(.bss.*)
    __bss_end__ = .;
  } >SRAM

  .heap : {
    end = .;
    /* Note: We don't increment "." here, we set it. */
    . = (ORIGIN(SRAM) + LENGTH(SRAM) - STACK_SIZE);
    heap_end = .;
  } >SRAM

  .stack : {
    . = ALIGN(8);
    _stack_end = .;
    . += (STACK_SIZE - 8);
    . = ALIGN(8);
    _stack_start = .;
    __stack = .;
  } >SRAM
}
