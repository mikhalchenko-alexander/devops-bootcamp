#!/bin/bash

echo "Type 'c' to sort by CPU, type 'm' to sort by memory"

read sortd

echo "How many lines to print?"

read lnum

if [ "$sortd" = "c" ]
then
	echo "Sorting by CPU"
	ps aux --sort -%cpu | grep `whoami` | head -n $lnum
elif [ "$sortd" = "m" ]
then
	echo "Sorting by memory"
	ps aux --sort -rss | grep `whoami` | head -n $lnum
else
	echo "No input provided. Exiting."
fi

