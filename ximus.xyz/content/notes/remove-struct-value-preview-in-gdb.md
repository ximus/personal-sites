---
title: How to remove struct value previews in gdb
description: How to remove struct value previews in gdb
keywords: gdb, gcc, struct, structs, value, preview, string, pointer
layout: notes
kind: article
---


If you are printing an array of structs in GDB, and those stucts contain pointers, by default GDB is going to display "previews" of the data located at that pointer address. Sometimes this can add too much noise, here is an example:

~~~
print debugstuff
$3 = {{
    pkt_data_addr = 0x256f "\020abcabcabcabcabc",
    pkt_len = 16 '\020',
    iop_addr = 0x2108 "\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"...,
    len = 15 '\017'
  }, {
    pkt_data_addr = 0x25ad "\020abcabcabcabcabc",
    pkt_len = 16 '\020',
    iop_addr = 0x2108 "\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"...,
    len = 15 '\017'
  }, ...
  ```

In the sample above, if you wanted to compare say the `len` values accross the structs, all those extra `\377`s would get in your way. You would have a hard time scanning the array.

I haven't found a way around this, but play with the format of print, for example instruct print to format as decimals (d):

~~~
print/d debugstuff
$3 = {{
    pkt_data_addr = 9583,
    pkt_len = 16,
    iop_addr = 8456,
    len = 15
  }, {
    pkt_data_addr = 9645,
    pkt_len = 16,
    iop_addr = 8456,
    len = 15
  }, ...
~~~

That's already better.