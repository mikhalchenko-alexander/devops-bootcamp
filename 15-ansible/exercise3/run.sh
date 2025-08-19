#!/bin/bash

ansible-playbook -i inventory_aws_ec2.yaml -e "@vars.yaml" exercise3.yaml
