#!/bin/bash

ansible-playbook exercise1.yaml -i hosts -e "@vars.yaml"
