#!/bin/python
import sys
import numpy as np
fin = open(sys.argv[1])
fout = open(sys.argv[2],'w')
for line in fin:
	line = line.strip()
	if '[' in line:
		fout.write(line)
		fout.write('\n')
		count = 0 
	else:
		if count == 0:
			fout.write(line+' ')
		elif count<2991 and count%11 != 10:
			fout.write(line+' ')
		elif count%11 == 10:
			fout.write(line)
			if count >= 2990:
				fout.write(' ]')
			fout.write('\n')
		count += 1


fin.close()
fout.close()
