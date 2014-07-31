import sys
import os
import linecache
fin_name = 'splice_feature'
fout_name = 'new_feature'
dummy = 1
fout = open(fout_name+str(dummy),'w')
job = 10
line = 2
step = 3001
name = 1000
sample_name = 'utt-'
count = [-1] * job
for i in range(job):
	f = open(fin_name+str(dummy),'rU')
	for count[i],lines in enumerate(f):
		pass
	dummy += 1
	f.close()
	count[i] += 1

f.close()
dummy = 1
dummy_in = dummy
fout.write(sample_name+str(name)+' [ \n')
f = fin_name+str(dummy_in)
while line < step:
	sub_line = line
	for i in range(job):
		sub_line = line
		while sub_line<= count[i]-step:
			content = linecache.getline(f,sub_line)
			fout.write(content)
			sub_line += step
		if dummy_in != 10:
			content = linecache.getline(f,sub_line).split('\n')[0]
			fout.write(content)

		dummy_in += 1
		if dummy_in == job + 1:
			dummy_in = 1
		f=fin_name+str(dummy_in)
	f = fin_name+str(job)
	content = linecache.getline(f,sub_line).split('\n')[0]
	fout.write(content+' ]\n')
	name += 1

	if name > 3000//job * dummy + 1000:
		fout.close()
		dummy += 1
		fout = open(fout_name+str(dummy),'w')
	fout.write(sample_name+str(name)+' [ \n')
	line = name - 998
f = fin_name+str(dummy_in)
for i in range(job):
	sub_line = line
	while sub_line<= count[i]-step:
		content = linecache.getline(f,sub_line)
		content = content.split(' ]')
		content = content[0]
		fout.write(content+'\n')
		sub_line += step
	if dummy_in != 10:
		content = linecache.getline(f,sub_line)
		fout.write(content+'\n')
	dummy_in += 1
	if dummy_in == job + 1:
		dummy_in = 1
	f = fin_name + str(dummy_in)
f = fin_name+str(job)
content = linecache.getline(f,sub_line).split('\n')[0]
fout.write(content+' ]\n')


fout.close()
