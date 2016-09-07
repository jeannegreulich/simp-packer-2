#!/usr/bin/sh
#
#  Check if puppet is running on ports 8140 and 8141
#  or what is set in the conf file

# We want to make sure the puppet server is up after the reboot
source ./functions.sh

myyaml=SIMP_PACKER_simp_conf_file
puppetconf="/etc/puppet/puppet.conf"

## Get the values set in the /etc/puppet.conf file for the ports
master_port=`grep masterport $puppetconf | cut -f2 -d= | sed -e 's/^ *//g;s/ *$//g' | sort -u`
echo "Master Port from ${puppetconf} is:  ${master_port}"
caport=`grep ca_port ${puppetconf} | cut -f2 -d= | sed -e 's/^ *//g;s/ *$//g' | sort -u`
echo "CA port from ${puppetconf} is:  $caport"

## Get the values from our conf file
get_value_lower "puppet::ca_port" $myyaml
case $myvalue in
"") 
   # if it is not set check for default"
   sc_ca_port="8141"
   ;;
*) 
   sc_ca_port=$myvalue
   ;;
esac


regexmaster=":${master_port}[[:space:]]*$"
regexca=":${caport}[[:space:]]*$"

# Check and see if the port set in the yaml file was the port implemented:
if [[ $sc_ca_port -ne $caport ]]; then
  echo "Port $sc_ca_port expected in /etc/puppet for ca but got: $caport"
  exit -2
fi

## These next few lines are just debug so I can see what is
## actually running
tmpfile="/tmp/`basename $0`.tempfile.`date +%y%m%d%H%M%S`"
echo "hello Jeanne" > $tmpfile
netstat -lp | grep java >> $tmpfile
cat $tmpfile | echo
rm $tmpfile

netstat -lp | grep java | cut -b20-40 | grep -e "${regexmaster}"
returnmaster=$?

netstat -lp | grep java | cut -b20-40 | grep -e "${regexca}"
returnca=$?

if [[ $returnmaster -ne 0 ]]; then
	echo "Error code: $returnmaster :Puppetserver not listening on master port $master_port"
        tail -f /var/log/puppet-agent.log | echo
	exit -1
fi

if [[ $returnca -ne 0 ]]; then
	echo "Error code: $returnca :Puppetserver not listening on ca port $caport"
	exit -1
fi

exit 0
