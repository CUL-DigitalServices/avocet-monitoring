class logstash::install::archive ($install_config) {

    $_install_config = merge({
        'url_base'                  => 'https://download.elasticsearch.org/logstash/logstash',
        'url_extension'             => 'tar.gz',
        'version_major_minor'       => '1.4.2'
    }, $install_config)

    $url_base               = $_install_config['url_base']
    $url_extension          = $_install_config['url_extension']
    $version_major_minor    = $_install_config['version_major_minor']

    $url_filename = "logstash-${version_major_minor}"
    $package_url = "${url_base}/${url_filename}.${url_extension}"

    # Remove the original archive
    exec { 'remove_original_logstash_archive':
        cwd         => '/opt',
        command     => 'rm -rf logstash',
        logoutput   => 'on_failure',
        onlyif      => 'test -d logstash'
    }

    # Download and unpack the archive
    archive { $url_filename:
        ensure          => present,
        url             => $package_url,
        target          => '/opt',
        checksum        => false,
        extension       => $url_extension,
        require         => [ Exec['remove_original_logstash_archive'] ]
    }

    # Rename the Logstash folder
    exec { 'rename_logstash_folder':
        cwd         => '/opt',
        command     => 'mv logstash-1.4.2 logstash',
        logoutput   => 'on_failure',
        require     => [ Archive[$url_filename] ]
    }
}
