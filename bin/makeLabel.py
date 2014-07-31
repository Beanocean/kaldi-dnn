#!/bin/python
import sys
import os

f = open(sys.argv[1])
label_list = {}
for line in f:
	line = line.split(' ')[0]
	genre = line.split('-')[0]
	if genre not in label_list:
		label_list[genre] = 0
	label_list[genre] += 1
label = ['baroque','blues','classical','country','electronica','hip','jazz','metal','rock','romantic']
f.close()

f = open(sys.argv[2])
fout = open(sys.argv[3],'w')
for line in f:
	line = line.split(' ')[0]
	fout.write(line+' ')
	for j in range(len(label)):
		length = label_list[label[j]]
		for i in range(length):
			fout.write(str(j)+' ')
	fout.write('\n')

f.close()
fout.close()


