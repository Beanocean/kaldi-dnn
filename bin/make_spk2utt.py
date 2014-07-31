#!/bin/python
import sys

fin = open(sys.argv[1])
fout = open(sys.argv[2],'w')
for line in fin:
	line = line.strip().split(' ')[0]
	fout.write(line+' '+line+'\n')

fin.close()
fout.close()


