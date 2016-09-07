#!/usr/bin/sh
source ./functions.sh

## Get the selinux setting

#get_value_lower "^\"selinux::ensure\":" SIMP_PACKER_simp_conf_file
get_value_lower "^\"selinux::ensure\":" /srv/jmg/packer/mypacker/simp_conf.yaml

se_value=`getenforce | tr '[:upper:]' '[:lower:]'`

if [[ $myvalue -ne $se_value ]]; then
   echo "SELINUX set to $myvalue in config file but system set to $se_value"
   exit -2
fi


exit 0
