class localconfig::ordering {

    ## All these components should be installed before Kibana
    Class['::nginx']            -> Class['::kibana']
}
