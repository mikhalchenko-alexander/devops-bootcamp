#!/bin/bash

ansible-playbook -e "@vars.yaml" provision_ec2_instance.yaml
ansible-playbook -i inventory_aws_ec2.yaml -e "@vars.yaml" exercise3.yaml
