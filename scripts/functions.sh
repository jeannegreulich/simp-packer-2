#!/usr/bin/sh
#
#  Check if puppet is running on ports 8140 and 8141
#  or what is set in the conf file

function get_value_lower() {
  if [[ $# -ne 2 ]]; then
    echo "usage get_value_lower <search string>  <file to search>"
    return -1
  fi
  file=$2
  if [[ ! -f $file ]]; then
    echo "get_value_lower:  File $file does not exist"
    return -1
  fi
  myvalue=""
  tempstuff=`grep $1 $file | cut -f2 -d' '`
  if [[ $? -eq 0 ]]; then
    myvalue=`echo $tempstuff |tr '[:upper:]' '[:lower:]' |  sed -e 's/^ *//g;s/ *$//g'`
  else
    echo "get_value_lower:  unknown error greping for value"
    return -1
  fi
 
  return 0
}

