#!/usr/bin/env bash
# ===================================================================
#     FileName: rm_old_code.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-03 16:38
# ===================================================================

files="cmd.sh path.sh run.sh myrun.sh test_dnn.sh bin conf steps utils local"

for x in $files; do
  [ ! -e $x ] && files=$(echo ${files/$x/} | tr -s ' ')
done

if [ ! -z $(echo $files | tr -d ' ') ]; then
  rm -r $files && echo "remove old code."
else
  echo "remove old code."
fi
