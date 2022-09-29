#!/bin/bash

NEXUS_PATH=/opt/nexus
NEXUS_USER=nexus

# Install Java
apt update
apt install -y openjdk-8-jdk wget

# Add user
useradd $NEXUS_USER -m

# Install Nexus
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz -O /opt/nexus.tar.gz
mkdir -p $NEXUS_PATH
tar -xf /opt/nexus.tar.gz --directory $NEXUS_PATH
rm /opt/nexus.tar.gz
mv $NEXUS_PATH/nexus* $NEXUS_PATH/nexus
chown -R nexus:nexus $NEXUS_PATH
sed -i 's/#run_as_user=""/run_as_user="nexus"/g' $NEXUS_PATH/nexus/bin/nexus.rc

# Start Nexus
runuser -l $NEXUS_USER -c "$NEXUS_PATH/nexus/bin/nexus start"

