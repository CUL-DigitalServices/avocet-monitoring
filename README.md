# Avocet Monitoring Puppet scripts

Puppet configuration for the Avocet monitoring environment.

#### Preparation

##### Get the source code

Clone [avocet-monitoring](https://github.com/CUL-DigitalServices/avocet-monitoring) into `/opt/avocet-monitoring`.

##### Download the Oracle JDK

Dependencies such as Elasticsearch perform best on Oracle JDK 7. Unfortunately, we cannot automate the step that downloads the JDK itself as you need to accept the Oracle Binary Code License Agreement.
You can download the JDK (jdk-7u65-linux-x64.tar.gz) on [Oracle's JDK7 download page](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html#jdk-7u65-oth-JPR).
You should save it at `/opt/avocet-monitoring/modules/oracle-java/files/jdk-7u65-linux-x64.gz`. (Note that Oracle lists the file incorrectly as `.tar.gz` whilst it is actually `.gz`)
