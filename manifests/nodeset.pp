class site::node_setup {
 sudo::user_specification { 'simp_dev_sudo':
    user_list => [ 'simp' ],
    host_list => [ 'puppet.simp.test' ],
    runas => 'root',
    cmnd => [ '/bin/ping',
              '/usr/bin/make',
              '/usr/bin/yum',
              '/usr/bin/yum-builddep',
              '/usr/bin/pip',
              '/bin/rpm',
              '/usr/bin/rpmbuild',
              '/usr/bin/sudosh',
              '/usr/bin/puppet',
              'sudoedit /etc/hosts'
    ],
    passwd => false
  }
}
