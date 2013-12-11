class cassandra ($version, $java_version = 'openjdk_1_7_0', $datacenter = 'dc1', $rack = 'r1') {
  apt::source { 'cassandra':
    location   => 'http://www.apache.org/dist/cassandra/debian',
    release    => $version,
    key        => '8D77295D',
    key_server => 'pgp.mit.edu',
  }

  apt::key { '2B5C1B00':
    key        => '2B5C1B00',
    key_server => 'pgp.mit.edu',
    notify     => Exec['apt_update'],
  }

  package { 'cassandra':
    ensure  => installed,
    require => [Apt::Source['cassandra'], Apt::Key['2B5C1B00']],
  }

  service { 'cassandra':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}