class stats::deps::package::fabric {
    require stats::deps::package::python
    package { 'fabric': ensure => 'installed', provider => 'pip' }
}
