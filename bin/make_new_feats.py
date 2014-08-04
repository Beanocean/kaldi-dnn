#!/bin/python
import sys
import os
import linecache
job = 10
line = 2
step = 1305
name = 1000
sample_name = 'utt-'
count = -1
f = open(sys.argv[1],'rU')
for i in range(job):
	for count,lines in enumerate(f):
		pass

f.close()
fout = open(sys.argv[2],'w')

f = sys.argv[1]

while line < step:
	sub_line = line
	fout.write(sample_name+str(name)+' [ \n')
	while sub_line<= count-step:
		content = linecache.getline(f,sub_line)
		fout.write(content)
		sub_line += step

	content = linecache.getline(f,sub_line).strip()
	fout.write(content+' ]\n')
	name += 1
	line = name - 998
sub_line = line
fout.write(sample_name+str(name)+' [ \n')
while sub_line<= count-step:
	content = linecache.getline(f,sub_line)
	content = content.split(' ]')
	content = content[0]
	fout.write(content+'\n')
	sub_line += step
content = linecache.getline(f,sub_line).split('\n')[0]
fout.write(content+'\n')


fout.close()
