class logstash (

  # Installation configuration
  $install_method     = 'archive',
  $install_config     = {
      'url_base'                  => 'https://download.elasticsearch.org/logstash/logstash',
      'url_extension'             => 'tar.gz',
      'version_major_minor'       => '1.4.2'
  },

  # Logstash service
  $service_name       = 'logstash') {

  # Install Logstash
  class { "::logstash::install::${install_method}":
      install_config  => $install_config
  }

  # Startup script for the Logstash service
  file { 'logstash_service':
      path    => '/etc/init/${service_name}.conf',
      ensure  => present,
      content => template('logstash/logstash.conf.erb'),
      require => [ Class["::logstash::install::${install_method}"] ]
  }

  # Configuration file for the Logstash service
  file { '/etc/logstash/': ensure => directory}
  file { 'logstash_configuration_file':
      path    => '/etc/logstash/logstash-avocet.conf',
      ensure  => present,
      content => template('logstash/logstash-avocet.conf.erb'),
      require => [ Class["::logstash::install::${install_method}"] ]
  }

  # Start the Logstash service
  service { $service_name:
      ensure      => running,
      provider    => upstart,
      require     => [
          File['logstash_configuration_file'],
          File['logstash_service']
      ]
  }
}
