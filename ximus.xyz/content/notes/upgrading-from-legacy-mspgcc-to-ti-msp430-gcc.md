---
title: Non-exhautive list of differences between mspgcc and msp430-gcc
description: Non-exhautive list of differences between the legacy mspgcc and TI's msp430-gcc.
keywords: msp430, msp430-gcc, texas instrument, gcc, cc430, redhat, ti
layout: notes
kind: article
---

* `intrinsics.h` ([link](http://sourceforge.net/p/mspgcc/msp430mcu/ci/3d23296c8ec3ef1d3d6e811272bcc5795f67b46e/tree/include/intrinsics.h)) is gone
* `legacymsp430.h` ([link](http://sourceforge.net/p/mspgcc/msp430-libc/ci/master/tree/include/legacymsp430.h)) is gone.
* `_end` is gone, use `end` (or `__bssend`?). See [here](https://e2e.ti.com/support/development_tools/compiler/f/343/p/373958/1316743). Check your MCU's ld file