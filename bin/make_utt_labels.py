#!/usr/bin/env python
# -*- coding: utf-8 -*-
# ===================================================================
#     FileName: make_utt_labels.py
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-08 15:00
# ===================================================================

def _get_label_list(feat_file):

    feats = open(feat_file)
    label_list = ''
    genre_list = {'baroque':0, 'blues':1, 'classical':2, 'country':3, \
        'electronica':4, 'hip':5, 'jazz':6, 'metal':7, 'rock':8, 'romantic':9}

    for line in feats:
        song_id = line.split(' ')[0]
        genre = song_id.split('-')[0]
        label_list = label_list + str(genre_list[genre]) + ' '

    feats.close()
    return label_list

def write_file(old_scp, new_scp, lab_file):

    label_list = _get_label_list(old_scp)
    nscp_fid = open(new_scp)  # new scp file id
    lab_fid = open(lab_file, 'w')  # label file id

    for line in nscp_fid:
        utt_id = line.split(' ')[0]
        lab_fid.write(utt_id + ' ' + label_list + '\n')
    nscp_fid.close()
    lab_fid.close()

if __name__ == '__main__':
    import sys
    write_file(sys.argv[1], sys.argv[2], sys.argv[3])
