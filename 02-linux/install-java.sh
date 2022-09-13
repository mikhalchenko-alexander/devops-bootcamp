#!/bin/bash

sudo apt install default-jre -y

java_version=$(java -version 2>&1 > /dev/null | grep version | awk '{print substr($3,2,2)}')

if [ "$java_version" -ge 11 ]
then
  echo "Java $java_version installed"
else 
  echo "Java not installed"
fi

