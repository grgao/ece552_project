j .realstart
data 0x0004
data 0x0006
data 0x0008
data 0x000a
data 0x000c
data 0x000e
data 0x0010
data 0x0012
data 0x0014
data 0x0016
data 0x0018
data 0x001a
data 0x001c
data 0x001e
data 0x0020
data 0x0022
data 0x0024
data 0x0026
data 0x0028
data 0x002a
data 0x002c
data 0x002e
data 0x0030
data 0x0032
data 0x0034
data 0x0036
data 0x0038
data 0x003a
data 0x003c
data 0x003e
data 0x0040
data 0x0042
data 0x0044
data 0x0046
data 0x0048
data 0x004a
data 0x004c
data 0x004e
data 0x0050
data 0x0052
data 0x0054
data 0x0056
data 0x0058
data 0x005a
data 0x005c
data 0x005e
data 0x0060
data 0x0062
data 0x0064
data 0x0066
data 0x0068
data 0x006a
data 0x006c
data 0x006e
data 0x0070
data 0x0072
data 0x0074
data 0x0076
data 0x0078
data 0x007a
data 0x007c
data 0x007e
.realstart:
lbi r0, 10 
lbi r1, 2
.loopstart:
ld r1, r1, 0
ld r1, r1, 0
ld r1, r1, 0
ld r1, r1, 0
addi r0, r0, -1
bgez r0, .loopstart
halt
halt
