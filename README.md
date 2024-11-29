A github mirror (and potential place to collect improvements)
for the devmem2 utility.

Originally written by, and hosted at, www.lartmaker.nl/lartware/ .

From `devmem.c` header comment:

```
devmem.c: Simple program to read/write from/to any location in memory.
### target

xxx_devmem

### note

copying target to system bin folder (ubuntu)

sudo cp xxx_devmem /usr/bin/

### build

make

### using

sudo xxx_devmem

Usage:  xxx_devmem { address } [ type [ data ] ]
        address : memory address to act upon
        type    : access operation type : [b]yte, [h]alfword, [w]ord, [d]word
        data    : data to be written

### example

# read #
sudo xxx_devmem 0xea000000
~
sudo xxx_devmem 0xea000000 b
~
sudo xxx_devmem 0xea000000 h
~
sudo xxx_devmem 0xea000000 w
~
sudo xxx_devmem 0xea000000 d
~

# write #
~
sudo xxx_devmem 0xea000000 b 0x12
~
sudo xxx_devmem 0xea000000 h 0x1234
~
sudo xxx_devmem 0xea000000 w 0x12345678
~
sudo xxx_devmem 0xea000000 d 0x12345678aaaaaaaa
~

# READ #
~
./bat_read.sh <基地址>
~


~
sudo ./bat_read.sh 0x91000000
~
