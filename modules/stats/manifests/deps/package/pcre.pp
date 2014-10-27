class stats::deps::package::pcre {
    package { 'libpcre3': ensure => installed }
    package { 'libpcre3-dev': ensure => installed }
}
