#!/usr/bin/env bash
# ===================================================================
#     FileName: pack_dnn_code.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-07-31 17:12
# ===================================================================

files="cmd.sh path.sh run.sh myrun.sh test_dnn.sh bin conf steps utils local"

for x in $files; do
  [ ! -e $x ] && echo "$x doesn't exist, it won't be packaged." && files=${files/$x/}
done

echo "The files in package is: $files"

if [ ! -z "$files" ]; then
  tar -czf mytry.tar.gz $files && echo "package finished."
else
  echo "no file is packaged."
fi
