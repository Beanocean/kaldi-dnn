#!/usr/bin/env bash
# ===================================================================
#     FileName: wav2sph.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-07-18 12:15
# ===================================================================

# add sph head for wav files

function walk()
{

  for x in `ls $1`; do

    local ipath=$1/$x
    local opath=$2/$x
    # echo -e "$ipath\t$opath\t$inpath\t$outpath"

    if [ -d $ipath ]; then

      mkdir -p $opath
      walk $ipath $opath

    elif [ -f $ipath ] && [[ $ipath == *.wav ]]; then

      ffmpeg -i $ipath -ac 1 -ar 16000 temp.wav >& /dev/null
      sox -t wav temp.wav -b 16 -t sph $opath >& /dev/null
      rm temp.wav

    fi

  done

}

if [ ! $# -eq 2 ]; then

  echo "USAGE: $0 <in-dir> <out-dir>"
  exit 1;

else

  if [ -d $2 ]; then
    rm -r $2;
  fi

  walk $1 $2

fi
