# Avocet Monitoring Puppet scripts

Puppet configuration for the Avocet monitoring environment.

#### Preparation

##### Get the source code

Clone [avocet-monitoring](https://github.com/CUL-DigitalServices/avocet-monitoring) into `/opt/avocet-monitoring`.

##### Download the Oracle JDK

Elasticsearch performs best on the Oracle JDK 6. Unfortunately, we cannot automate the step that downloads the JDK itself
as you need to accept the Oracle Binary Code License Agreement.
You can download the JDK (jdk-6u45-linux-x64.bin) on [Oracle's JDK6 download page](http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html#jdk-6u45-oth-JPR).
You should save it at `~/opt/avocet-monitoring/modules/oracle-java/files/jdk-6u45-linux-x64.bin`.
