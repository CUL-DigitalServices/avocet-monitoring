class stats::kibana {
    Class['::elasticsearch']      -> Class['::kibana']

    class { '::kibana': }
}
