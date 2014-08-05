#!/bin/python

import os
import sys

feats = open(sys.argv[1])
label_file = open(sys.argv[2], 'w')
genre_list = {'baroque':0, 'blues':1, 'classical':2, 'country':3, \
        'electronica':4, 'hip':5, 'jazz':6, 'metal':7, 'rock':8, 'romantic':9}
label = 0

for line in feats:
    if '[' in str(line):
        song_id = line.split(' ')[0]
        genre = song_id.split('-')[0]
        label_file.write(song_id + ' ')
    else:
        label_file.write(str(genre_list[genre]) + ' ')
        if ']' in str(line):
            label_file.write('\n')
feats.close()
label_file.close()

