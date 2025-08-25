#!/bin/bash

ansible-playbook -e "@vars.yaml" provision_ansible_instance.yaml
ansible-playbook -e "@vars.yaml" provision_app_instances.yaml
#ansible-playbook -i inventory_aws_ec2.yaml -e "@vars.yaml" configure_ansible_instance.yaml
#ansible-playbook -i inventory_aws_ec2.yaml -e "@vars.yaml" configure_app_instances.yaml
