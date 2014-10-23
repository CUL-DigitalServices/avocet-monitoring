class stats::logstash {
  Class['::elasticsearch']      -> Class['::logstash']

  # Installation configuration
  $install_method     = 'archive'
  $install_config     = {
    'url_base'                  => 'https://download.elasticsearch.org/logstash/logstash',
    'url_extension'             => 'tar.gz',
    'version_major_minor'       => '1.4.2'
  }

  # Apply the Logstash class
  class { '::logstash':
    install_method        => $install_method,
    install_config        => $install_config
  }
}
