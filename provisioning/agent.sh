#!/usr/bin/env bash

# Do a basic check to see if we have a good environment to start from
# Check if the oracle-java binary is present
ORACLE_JDK_INSTALLER="jdk-7u65-linux-x64.gz"
if [ ! -f /opt/avocet-monitoring/modules/oracle-java/files/$ORACLE_JDK_INSTALLER ] ; then
    echo "The Oracle JDK installer is not present in the correct location."
    echo "Please download $ORACLE_JDK_INSTALLER from the Oracle website and place it at:"
    echo "modules/oracle-java/files/$ORACLE_JDK_INSTALLER"
    exit 1
fi

# We need puppet version 3+
echo "Installing puppetlabs repo"
cd /tmp
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get update

echo "Updating puppet"
apt-get -y install puppet

# We need puppet/apt
if [ ! -d /home/ubuntu/.puppet ] || [ ! -d /home/ubuntu/.puppet/modules ] || [ ! -d /home/ubuntu/.puppet/modules/apt ]; then
    puppet module install puppetlabs/apt
fi

# We need curl
which curl
STATUS_CODE=$?
if [ $STATUS_CODE -ne 0 ] ; then
    echo "Installing curl"
    apt-get -y install curl
fi

# Enable  multiverse repositories
echo "Enable multiverse repositories"
sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list
apt-get update

# Make sure all the submodules have been pulled down
echo "Pull the submodules"
cd /opt/avocet-monitoring
sh bin/pull.sh

# Create the hiera config
echo "Create the hiera configuration file"
cat > /etc/puppet/hiera.yaml <<EOF
:backends:
  - json
:json:
  :datadir: /opt/avocet-monitoring/environments/%{::environment}/hiera
:hierarchy:
  - %{::clientcert}_hiera_secure
  - %{::clientcert}
  - %{nodetype}_hiera_secure
  - %{nodetype}
  - common_hiera_secure
  - common
EOF

# Run puppet
echo "Applying puppet catalog"
sudo puppet apply --verbose --debug --modulepath environments/staging/modules:modules:/etc/puppet/modules --certname staging0 --environment staging --hiera_config /etc/puppet/hiera.yaml site.pp

STATUS_CODE=$?
if [ $STATUS_CODE -ne 0 ] ; then
    echo "Got a ${STATUS_CODE} status code, which indicates the puppet catalog could not be properly applied."
    echo "There are a couple of possible things you can do:"
    echo " - Run sudo puppet apply --verbose --debug --modulepath environments/staging/modules:modules:/etc/puppet/modules --certname staging0 --environment staging --hiera_config /etc/puppet/hiera.yaml site.pp"
    echo " - If you're familiar with puppet try to analyze the output and tweak the puppet scripts"
    echo "Since puppet didn't finish properly, we have to abort here"
    exit 1;
fi
echo "The puppet catalog has been applied."

# Bounce all the services just in case.
echo "We're now bouncing all the services to get everything up and running."

sleep 10

service elasticsearch restart
service logstash restart
service kibana restart
service nginx restart

echo "Give the dependencies some time to start up properly"
sleep 10

echo "Done! All the dependencies have been restarted."
