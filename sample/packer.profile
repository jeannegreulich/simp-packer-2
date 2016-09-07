#! /bin/sh
mydate=`date +%y%m%d%H%M%S`
#If you do not want packer to log then comment out the PACKER_LOG variable.
#It should be used for debug only.
#export PACKER_LOG=1 
export PACKER_LOG_PATH="/tmp/packerlog.log.${mydate}" 
# simp_disk encrypt should be "" or  "_disk_encrypt"
export SIMP_PACKER_simp_prompt="simp-big" 
export SIMP_PACKER_disk_encrypt="" 
#The network interface for the host only will be pulled from the simp_conf.yaml file
#you provide with this.
export SIMP_PACKER_host_only_network_name="vboxnet0" 
export SIMP_PACKER_nat_network_if="enp0s3" 
export SIMP_PACKER_nat_network_name="NatNetwork" 
