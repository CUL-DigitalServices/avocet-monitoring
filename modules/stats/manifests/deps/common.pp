class stats::deps::common () {
    include ::apt
    Class['::apt::update'] -> Package <| title != "python-software-properties" and title != "software-properties-common" |>

    package { 'build-essential': ensure => installed }
    package { 'automake': ensure => installed }
}
