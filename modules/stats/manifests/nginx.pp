class stats::nginx {
    include ::stats::deps::common
    include ::stats::deps::package::pcre
    include ::stats::deps::apt::nginx

    Class['::stats::deps::common']          -> Class['::nginx']
    Class['::stats::deps::package::pcre']   -> Class['::nginx']

    class { '::nginx':
        web_domain                      => hiera('web_domain'),
        stats_dir                       => hiera('stats_dir', '/opt/kibana')
    }
}
