#!/bin/python
import sys
import linecache
f = open(sys.argv[1],'rU')
fin = sys.argv[1]
fout_name = 'splice_feature' 
fout = open(sys.argv[2],'w')
num = int(sys.argv[3])
line = 1
step = 1305
count = -1
for count,lines in enumerate(f):
	pass
count += 1
f.close()
#line_buffer[2*num+1]
dummy = 1
idx = range(-num,num+1)
while line <= count:	
	l = linecache.getline(fin,line)
	if '[' in str(l):
		fout.write(l)
	else :
		for i in range(2*num+1):
			if (line+idx[i])%step >= step - num:# or line+idx[i]%step <= num:
				content = linecache.getline(fin,step*(line//step)+2).strip()
			elif (line+idx[i])%step <= num and line%step != 0:
				content = linecache.getline(fin,(line//step+1) * step).split(']')[0]
			elif line%step == 0 :
				content = linecache.getline(fin,line).split(']')[0].strip()
			else:
				content = linecache.getline(fin,line+idx[i]).strip()

			#line_buffer[i] = content
			fout.write(content+' ')
		if line%step == 0:
			fout.write(']')
		fout.write('\n')
	line += 1

fout.close()


