import sys
import linecache
f = open(sys.argv[1],'rU')
fin = sys.argv[1]
fout_name = 'splice_feature' 

num = int(sys.argv[2])
job = int(sys.argv[3])
fout = open(fout_name+str(1),'w')
line = 1
step = 3001
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
		if line > count//job * dummy:
			fout.close()
			dummy += 1
			fout = open(fout_name + str(dummy),'w')
		fout.write(l)
	else :
		for i in range(2*num+1):
			if line+idx[i]%step >= step - num:# or line+idx[i]%step <= num:
				content = linecache.getline(fin,step*(line//step)+2).strip()
			elif line+idx[i]%step <= num:
				content = linecache.getline(fin,(line//step+1) * step).split(']')[0]
			else:
				content = linecache.getline(fin,line+idx[i]).strip()
			if line%step == 0 :
				content = content + ' ]'

			#line_buffer[i] = content
			fout.write(content+' ')
		fout.write('\n')
	line += 1

fout.close()


