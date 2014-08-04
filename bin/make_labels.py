#!/bin/python

import os
import sys

feats = open(sys.argv[1])
label_file = open(sys.argv[2], 'w')
genre_list = {}
label = 0
count = 0

for line in feats:
    if '[' in str(line):
        maxcount = count
        count = 0
        song_id = line.split(' ')[0]
        genre = song_id.split('-')[0]
        if genre not in genre_list:
            genre_list[genre] = label
            label += 1
        label_file.write(song_id + ' ')
        if maxcount < 3000:
            print 'song_id:', song_id, 'count:', maxcount
    else:
        count += 1
        # if count >= 3000:
        #    print 'song_id:', song_id, 'count:', count

        label_file.write('[ ' + str(genre_list[genre]) + ' 1 ] ')
        if ']' in str(line):
            label_file.write('\n')
feats.close()
label_file.close()

