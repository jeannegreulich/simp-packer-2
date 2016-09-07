## SIMP Packer manifests

#### Table of Contents

* [Overview](#overview)
* [Setup](#setup)
* [Usage](#usage)
	* [Simple build](#simple-build)
* [Notes](#notes)
* [TODO](#todo)
* [DONE](#done)

### Overview

[Packer](https://packer.io) configuration to build a [Vagrant](https://www.vagrantup.com/) box directly from a fresh [SIMP](https://github.com/NationalSecurityAgency/SIMP) ISO. The Vagrant boxes it builds use the [VirtualBox](https://www.virtualbox.org/wiki/Downloads) provider.


### Setup
NOTE:  At this time the packer executable is included in the package, we can remove it if that is bad idea.

Requirements:
  - [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  - [Vagrant](https://www.vagrantup.com/downloads.html)
  - SIMP ISO created from build:auto and its json file.

### Usage
#### Simple build
1\. To define a test, create a test directory and include the following three files:
      vars.json:  The *.json file from the build.auto.  Make sure it points to the 
           location of the SIMP ISO you want to test.
      simp_conf.yaml:  A simp_conf.yaml file with the setup you want to test.  
      packer.profile:  A configuration file, a sample is in the sample dir.  Edit
           this file to match your set up.  There is guidance in the sample file.
           You can add addditional environment variables like:
	   PACKER_CACHE_DIR - keeps ginormous tmp files out of /tmp
	   PACKER_LOG       - if set with anything, write to a log file
           PACKER_LOG_PATH  - the location of the log file

2\. Run the test: Run the script simp-packer_test.sh <full path to test directory from #1>

It will run and create an output file beginning with the date in the test directory.
All processing is in a temporary working directory created under the test directory.

The tests is runs are all defined in simp.json.template.  It tests the following:
1) That the build of the puppet server is successful.
2) Puppet server is up and running and listening on the ports configured in simp_conf.yaml
3) It verifies that FIPS is set correctly in the pre-envirinment and post simp environment according to simp_conf.yaml use_fips setting.
4) Checks that selinux matches the simp_conf.yaml selinux::secure setting.
 

### Notes
- 

### TODO
- test auditd settings
- test if master is yum that yum is set up and working.
- test if iptables is configured properly.
- 
