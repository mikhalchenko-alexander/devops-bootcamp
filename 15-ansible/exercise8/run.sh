#!/bin/bash

ansible-playbook -e "@ansible-secrets.yaml" exercise8.yaml
