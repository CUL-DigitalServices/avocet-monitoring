## Set the path globally
Exec {
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    environment => "HOME=/root",
}

###############
## EXECUTION ##
###############

# Instantiate the environment-specific node config
import 'localconfig/nodes.pp'
