---
title: How to install msp430-gcc on OS X
description: How to build and install Texas instrument's msp430 gcc compiler on OS X
keywords: msp430, msp430-gcc, texas instrument, gcc, cc430, redhat, ti, build, install, compile, make
layout: notes
kind: article
---

~~~ bash
wget http://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPGCC/latest/exports/msp430-gcc-source.tar.bz2
tar xvjf msp430-gcc-source.tar.bz2

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
export LIBRARY_PATH=/usr/X11/lib

mkdir build
cd build
../sources/tools/configure --target=msp430-elf --prefix=/Users/cgadmin/gmiller/msp430-gcc-4.9.1 --enable-languages=c,c++ -disable-werror

make all
make install

make info
make install-info
~~~