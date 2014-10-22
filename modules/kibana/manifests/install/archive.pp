class kibana::install::archive ($install_config, $stats_dir = '/opt/stats') {

    $_install_config = merge({
        'url_base'                  => 'https://download.elasticsearch.org/kibana/kibana',
        'url_extension'             => 'tar.gz',
        'version_major_minor'       => '4.0.0-BETA1.1'
    }, $install_config)

    $url_base               = $_install_config['url_base']
    $url_extension          = $_install_config['url_extension']
    $version_major_minor    = $_install_config['version_major_minor']

    $url_filename = "kibana-${version_major_minor}"
    $package_url = "${url_base}/${url_filename}.${url_extension}"

    # Remove the original archive
    exec { 'remove_original_archive':
        cwd         => '/opt',
        command     => 'rm -rf stats',
        logoutput   => 'on_failure',
        onlyif      => 'test -d stats'
    }

    # Download and unpack the archive
    archive { $url_filename:
        ensure          => present,
        url             => $package_url,
        target          => '/opt',
        checksum        => false,
        extension       => $url_extension,
        require         => [ Exec['remove_original_archive'] ]
    }

    # Rename the Kibana folder
    exec { 'rename_kibana_folder':
        cwd         => '/opt',
        command     => 'mv kibana-4.0.0-BETA1.1 stats',
        logoutput   => 'on_failure',
        require     => [ Archive[$url_filename] ]
    }
}
